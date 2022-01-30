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
  | TmIf(_,TmRaiseExc(fi, (TmExc(name, v)), t),_,_) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(name, v)), t)
  | TmIf(fi,t1,t2,t3) ->
      let t1' = eval1 ctx t1 in
      TmIf(fi, t1', t2, t3)
  | TmApp(fi,TmAbs(_,x,tyT11,t12),v2) when isval ctx v2 ->
      termSubstTop v2 t12
  | TmApp(_,TmRaiseExc(fi, (TmExc(name, v)), t),_) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(name, v)), t)
  | TmApp(_,_,TmRaiseExc(fi, (TmExc(name, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(name, v)), t)
  | TmApp(fi,v1,t2) when isval ctx v1 ->
      let t2' = eval1 ctx t2 in
      TmApp(fi, v1, t2')
  | TmApp(fi,t1,t2) ->
      let t1' = eval1 ctx t1 in
      TmApp(fi, t1', t2)
  | TmFix(fi,v1) as t when isval ctx v1 ->
      (match v1 with
         TmAbs(_,_,_,t12) -> termSubstTop t t12
       | _ -> raise NoRuleApplies)
  | TmFix(_, TmRaiseExc(fi, (TmExc(name, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(name, v)), t)
  | TmFix(fi,t1) ->
      let t1' = eval1 ctx t1
      in TmFix(fi,t1')
  | TmSucc(_, TmRaiseExc(fi, (TmExc(name, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(name, v)), t)
  | TmSucc(fi,t1) ->
      let t1' = eval1 ctx t1 in
      TmSucc(fi, t1')
  | TmPred(_,TmZero(_)) ->
      TmZero(dummyinfo)
  | TmPred(_,TmSucc(_,nv1)) when (isnumericval ctx nv1) ->
      nv1
  | TmPred(_,TmRaiseExc(fi, (TmExc(name, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(name, v)), t)
  | TmPred(fi,t1) ->
      let t1' = eval1 ctx t1 in
      TmPred(fi, t1')
  | TmIsZero(_,TmZero(_)) ->
      TmTrue(dummyinfo)
  | TmIsZero(_,TmSucc(_,nv1)) when (isnumericval ctx nv1) ->
      TmFalse(dummyinfo)
  | TmIsZero(_, TmRaiseExc(fi, (TmExc(name, v)), t)) when isval ctx v ->
      TmRaiseExc(fi, (TmExc(name, v)), t)
  | TmIsZero(fi,t1) ->
      let t1' = eval1 ctx t1 in
      TmIsZero(fi, t1')
  | TmExcDef(_, _, _, t) -> t
  | TmRaiseExc(fi, (TmExc (name, TmRaiseExc(fi', (TmExc(name2, v)), ty))), ty2) when isval ctx v ->
      (TmRaiseExc(fi, (TmExc (name2, v)), ty2))
  | TmRaiseExc(fi, (TmExc (name, t)), ty) ->
      let t' = eval1 ctx t in
      TmRaiseExc(fi, (TmExc (name, t')), ty)
  | TmTryCatch(_, v, _) when isval ctx v ->
    v
  | TmTryCatch(fi, TmRaiseExc(fi', TmExc(name, v), ty), handlers) when isval ctx v -> 
    let exc = TmExc(name, v) in
    if havehandler exc handlers 
    then gethandler exc handlers 
    else TmRaiseExc(fi', exc, ty)
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
    TyVar(i,_) when istyabb ctx i -> gettyabb ctx i
  | _ -> raise NoRuleApplies

let rec simplifyty ctx tyT =
  try
    let tyT' = computety ctx tyT in
    simplifyty ctx tyT' 
  with NoRuleApplies -> tyT

let rec tyeqv seen ctx tyS tyT =
  List.mem (tyS,tyT) seen 
  || match (tyS,tyT) with
       (TyId(b1),TyId(b2)) -> b1=b2
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

let tyeqv ctx tyS tyT = tyeqv [] ctx tyS tyT

let rec is_defined_in_context exc exc_ctx = match (exc, exc_ctx) with
  | (_, []) -> false
  | (excname, (excname2, _)::tail) when excname=excname2 -> true
  | (excname2, _::tail) -> is_defined_in_context exc tail

let rec definition_in_context exc exc_ctx = match (exc, exc_ctx) with
  | (_, []) -> raise NoRuleApplies
  | (excname, (excname2, ty)::tail) when excname=excname2 -> ty
  | (excname, _::tail) -> definition_in_context excname tail

let rec typeof1 ctx exc_ctx t =
  match t with
    TmVar(fi,i,_) -> getTypeFromContext fi ctx i
  | TmAbs(fi,x,tyT1,t2) ->
      let ctx' = addbinding ctx x (VarBind(tyT1)) in
      let tyT2 = typeof1 ctx' exc_ctx t2 in
      TyArr(tyT1, typeShift (-1) tyT2)
  | TmApp(fi,t1,t2) ->
      let tyT1 = typeof1 ctx exc_ctx t1 in
      let tyT2 = typeof1 ctx exc_ctx t2 in
      (match simplifyty ctx tyT1 with
          TyArr(tyT11,tyT12) ->
            if tyeqv ctx tyT2 tyT11 then tyT12
            else type_error fi "parameter type mismatch"
        | _ -> type_error fi "arrow type expected")
  | TmFix(fi, t1) ->
      let tyT1 = typeof1 ctx exc_ctx t1 in
      (match simplifyty ctx tyT1 with
           TyArr(tyT11,tyT12) ->
             if tyeqv ctx tyT12 tyT11 then tyT12
             else type_error fi "result of body not compatible with domain"
         | _ -> type_error fi "arrow type expected")
  | TmUnit(fi) -> TyUnit
  | TmTrue(fi) -> 
      TyBool
  | TmFalse(fi) -> 
      TyBool
  | TmIf(fi,t1,t2,t3) ->
     if tyeqv ctx (typeof1 ctx exc_ctx t1) TyBool then
       let tyT2 = typeof1 ctx exc_ctx t2 in
       if tyeqv ctx tyT2 (typeof1 ctx exc_ctx t3) then tyT2
       else type_error fi "arms of conditional have different types"
     else type_error fi "guard of conditional not a boolean"
  | TmZero(fi) ->
      TyNat
  | TmSucc(fi,t1) ->
      if tyeqv ctx (typeof1 ctx exc_ctx t1) TyNat then TyNat
      else type_error fi "argument of succ is not a number"
  | TmPred(fi,t1) ->
      if tyeqv ctx (typeof1 ctx exc_ctx t1) TyNat then TyNat
      else type_error fi "argument of pred is not a number"
  | TmIsZero(fi,t1) ->
      if tyeqv ctx (typeof1 ctx exc_ctx t1) TyNat then TyBool
      else type_error fi "argument of iszero is not a number"
  | TmExcDef(fi,name, ty,t1) -> typeof1 ctx ((name, ty)::exc_ctx) t1
  | TmRaiseExc(fi, TmExc(name, t), ty) -> 
    if (is_defined_in_context name exc_ctx) 
    then 
      let tyT2 = typeof1 ctx exc_ctx t in
      if tyeqv ctx tyT2 (definition_in_context name exc_ctx) then ty
      else type_error fi "Type of subterm and exception definition mismatch"
    else type_error fi ("Undefined exception in context: " ^ name)
  | TmTryCatch(fi, t, handlers) -> 
    let tyT = typeof1 ctx exc_ctx t in
    if (List.for_all (fun (TmHandledExc(name, x), _) -> is_defined_in_context name exc_ctx) handlers)
    then if (List.for_all (fun (TmHandledExc(name, x), t1) -> let ctx'=addbinding ctx x (VarBind(definition_in_context name exc_ctx))
          in tyeqv ctx' (typeof1 ctx' exc_ctx t1) tyT) handlers) 
        then tyT 
        else type_error fi "Type of subterm and exception definition mismatch for one of try handlers."
    else type_error fi "One of try handlers have undefined exception"

let rec typeof ctx exc_ctx t = 
  try typeof1 ctx exc_ctx t 
  with 
    | (Exit _) -> TyNotTyped
