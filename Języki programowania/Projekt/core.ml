open Format
open Syntax
open Support.Error
open Support.Pervasive

(* ------------------------   EVALUATION  ------------------------ *)

exception NoRuleApplies

let rec isnumericval ctx t = match t with
    TmZero(_) -> true
  | TmSucc(_,t1) -> isnumericval ctx t1
  | _ -> false

let rec isval ctx t = match t with
    TmTrue(_)  -> true
  | TmFalse(_) -> true
  | TmUnit(_)  -> true
  | t when isnumericval ctx t  -> true
  | TmAbs(_,_,_,_) -> true
  | _ -> false

let rec eval1 ctx t = match t with
    TmVar(fi,n,_) ->
      (match getbinding fi ctx n with
          TmAbbBind(t,_) -> t 
        | _ -> raise NoRuleApplies)
  | TmIf(_,TmTrue(_),t2,_) ->
      t2
  | TmIf(_,TmFalse(_),_,t3) ->
      t3
  | TmIf(_,TmRaiseExc(fi, (TmExc(_, v)), t),_,_) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(_, v)), t)
  | TmIf(fi,t1,t2,t3) ->
      let t1' = eval1 ctx t1 in
      TmIf(fi, t1', t2, t3)
  | TmApp(fi,TmAbs(_,x,tyT11,t12),v2) when isval ctx v2 ->
      termSubstTop v2 t12
  | TmApp(fi,v1,t2) when isval ctx v1 ->
      let t2' = eval1 ctx t2 in
      TmApp(fi, v1, t2')
  | TmApp(_,TmRaiseExc(fi, (TmExc(_, v)), t),_) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(_, v)), t)
  | TmApp(_,_,TmRaiseExc(fi, (TmExc(_, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(_, v)), t)
  | TmApp(fi,t1,t2) ->
      let t1' = eval1 ctx t1 in
      TmApp(fi, t1', t2)
  | TmFix(fi,v1) as t when isval ctx v1 ->
      (match v1 with
         TmAbs(_,_,_,t12) -> termSubstTop t t12
       | _ -> raise NoRuleApplies)
  | TmFix(_, TmRaiseExc(fi, (TmExc(_, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(_, v)), t)
  | TmFix(fi,t1) ->
      let t1' = eval1 ctx t1
      in TmFix(fi,t1')
  | TmSucc(_, TmRaiseExc(fi, (TmExc(_, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(_, v)), t)
  | TmSucc(fi,t1) ->
      let t1' = eval1 ctx t1 in
      TmSucc(fi, t1')
  | TmPred(_,TmZero(_)) ->
      TmZero(dummyinfo)
  | TmPred(_,TmSucc(_,nv1)) when (isnumericval ctx nv1) ->
      nv1
  | TmPred(_,TmRaiseExc(fi, (TmExc(_, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(_, v)), t)
  | TmPred(fi,t1) ->
      let t1' = eval1 ctx t1 in
      TmPred(fi, t1')
  | TmIsZero(_,TmZero(_)) ->
      TmTrue(dummyinfo)
  | TmIsZero(_,TmSucc(_,nv1)) when (isnumericval ctx nv1) ->
      TmFalse(dummyinfo)
  | TmIsZero(fi, TmRaiseExc(fi, (TmExc(_, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(_, v)), t)
  | TmIsZero(fi,t1) ->
      let t1' = eval1 ctx t1 in
      TmIsZero(fi, t1')
  | TmExcDef(_, _, t, _) -> t
  | TmRaiseExc(fi, (TmExt (TmRaiseExc(fi', (TmExc(_, v)), ty))), ty2) when isval ctx v ->
      (TmRaiseExc(fi', (TmExt v), ty))
  | TmRaiseExc(fi, (TmExt t), ty) ->
      let t' = eval1 ctx t in
      TmRaiseExc(fi, (TmExt t'), ty)
  | TmTryCatch(_, v, _) when isval ctx v ->
    v
  | TmTryCatch(fi, TmRaiseExc(fi, (TmExc(_, v)), t) as exc, handlers) when isval ctx v -> 
    if havehandler exc handlers then gethandler exc handlers else exc
  | TmTryCatch(fi, t, handlers) ->
    let t' = eval1 ctx t in
    TmTryCatch(fi, t', handlers)
  | _ -> 
      raise NoRuleApplies

let rec eval ctx t =
  try let t' = eval1 ctx t
      in eval ctx t'
  with NoRuleApplies -> t

(* ------------------------   TYPING  ------------------------ *)

let istyabb ctx i = 
  match getbinding dummyinfo ctx i with
    TyAbbBind(tyT) -> true
  | _ -> false

let gettyabb ctx i = 
  match getbinding dummyinfo ctx i with
    TyAbbBind(tyT) -> tyT
  | _ -> raise NoRuleApplies

let rec computety ctx tyT = match tyT with
    TyRec(x,tyS1) as tyS -> typeSubstTop tyS tyS1
  | TyVar(i,_) when istyabb ctx i -> gettyabb ctx i
  | _ -> raise NoRuleApplies

let rec simplifyty ctx tyT =
  try
    let tyT' = computety ctx tyT in
    simplifyty ctx tyT' 
  with NoRuleApplies -> tyT

let rec tyeqv seen ctx tyS tyT =
  List.mem (tyS,tyT) seen 
  || match (tyS,tyT) with
        (TyRec(x,tyS1),_) ->
           tyeqv ((tyS,tyT)::seen) ctx (typeSubstTop tyS tyS1) tyT
     | (_,TyRec(x,tyT1)) ->
          tyeqv ((tyS,tyT)::seen) ctx tyS (typeSubstTop tyT tyT1)
     | (TyId(b1),TyId(b2)) -> b1=b2
     | (TyVar(i,_), _) when istyabb ctx i ->
         tyeqv seen ctx (gettyabb ctx i) tyT
     | (_, TyVar(i,_)) when istyabb ctx i ->
         tyeqv seen ctx tyS (gettyabb ctx i)
     | (TyVar(i,_),TyVar(j,_)) -> i=j
     | (TyArr(tyS1,tyS2),TyArr(tyT1,tyT2)) ->
          (tyeqv seen ctx tyS1 tyT1) && (tyeqv seen ctx tyS2 tyT2)
     | (TyBool,TyBool) -> true
     | (TyNat,TyNat) -> true
     | (TyUnit,TyUnit) -> true
     | _ -> false

let is_defined_in_context exc exc_ctx = match (exc, exc_ctx) with
  | (_, []) -> false
  | (TmRaiseExc(fi1, (TmExc(name, _)), ty1), (name, _)::tail) -> true
  | (exc, _::tail) -> is_defined_in_context exc tail

let definition_in_context exc exc_ctx = match (exc, exc_ctx) with
  | (_, []) -> false
  | (TmRaiseExc(fi1, (TmExc(name, _)), ty1), (name, ty)::tail) -> ty
  | (exc, _::tail) -> definition_in_context exc tail

let tyeqv ctx tyS tyT = tyeqv [] ctx tyS tyT

let rec typeof ctx exc_ctx t =
  match t with
    TmVar(fi,i,_) -> getTypeFromContext fi ctx i
  | TmAbs(fi,x,tyT1,t2) ->
      let ctx' = addbinding ctx x (VarBind(tyT1)) in
      let tyT2 = typeof ctx' exc_ctx t2 in
      TyArr(tyT1, typeShift (-1) tyT2)
  | TmApp(fi,t1,t2) ->
      let tyT1 = typeof ctx exc_ctx t1 in
      let tyT2 = typeof ctx exc_ctx t2 in
      (match simplifyty ctx tyT1 with
          TyArr(tyT11,tyT12) ->
            if tyeqv ctx tyT2 tyT11 then tyT12
            else error fi "parameter type mismatch"
        | _ -> error fi "arrow type expected")
  | TmFix(fi, t1) ->
      let tyT1 = typeof ctx exc_ctx t1 in
      (match simplifyty ctx tyT1 with
           TyArr(tyT11,tyT12) ->
             if tyeqv ctx tyT12 tyT11 then tyT12
             else error fi "result of body not compatible with domain"
         | _ -> error fi "arrow type expected")
  | TmUnit(fi) -> TyUnit
  | TmTrue(fi) -> 
      TyBool
  | TmFalse(fi) -> 
      TyBool
  | TmIf(fi,t1,t2,t3) ->
     if tyeqv ctx (typeof ctx exc_ctx t1) TyBool then
       let tyT2 = typeof ctx exc_ctx t2 in
       if tyeqv ctx tyT2 (typeof ctx exc_ctx t3) then tyT2
       else error fi "arms of conditional have different types"
     else error fi "guard of conditional not a boolean"
  | TmZero(fi) ->
      TyNat
  | TmSucc(fi,t1) ->
      if tyeqv ctx (typeof ctx exc_ctx t1) TyNat then TyNat
      else error fi "argument of succ is not a number"
  | TmPred(fi,t1) ->
      if tyeqv ctx (typeof ctx exc_ctx t1) TyNat then TyNat
      else error fi "argument of pred is not a number"
  | TmIsZero(fi,t1) ->
      if tyeqv ctx (typeof ctx exc_ctx t1) TyNat then TyBool
      else error fi "argument of iszero is not a number"
  | TmExcDef(fi,name, t1,ty) -> typeof ctx (name, ty)::exc_ctx t1
  | TmRaiseExc(fi, exc, ty) -> 
    if (is_defined_in_context exc exc_ctx `and` tyeqv ctx (definition_in_context exc exc_ctx) (typeof ctx exc_ctx t1)) 
    then ty 
    else raise NoRuleApplies
  | TmTryCatch(fi, t, handlers) -> 
    let tyT = typeof ctx exc_ctx t in
    if (for_all (fun (exc, _) -> is_defined_in_context exc exc_ctx) handlers `and`
      for_all (fun (TmExc(_, x) as exc, t1) -> let ctx'=addbinding ctx x (VarBind(definition_in_context exc exc_ctx))
          tyeqv ctx' (typeof ctx' exc_ctx t1) tyT)  handlers) then tyT else raise NoRuleApplies

let evalbinding ctx b = match b with
    TmAbbBind(t,tyT) ->
      let t' = eval ctx t in 
      TmAbbBind(t',tyT)
  | bind -> bind
