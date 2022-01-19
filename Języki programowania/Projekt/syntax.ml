open Format
open Support.Error
open Support.Pervasive

(* ---------------------------------------------------------------------- *)
(* Datatypes *)

exception NoRuleApplies

(*TODO: Check if all of these types and bindings are neccessary
TyVar - type variables*)
type ty =
    TyVar of int * int
  | TyId of string
  | TyArr of ty * ty
  | TyUnit
  | TyNat
  | TyBool
  | TyNotTyped

type term =
  | TmVar of info * int * int
  | TmTrue of info
  | TmFalse of info
  | TmIf of info * term * term * term
  | TmAbs of info * string * ty * term
  | TmApp of info * term * term
  | TmFix of info * term
  | TmUnit of info
  | TmZero of info
  | TmSucc of info * term
  | TmPred of info * term
  | TmIsZero of info * term
  | TmExcDef of info * string * ty * term
  | TmRaiseExc of info * tmexception * ty
  | TmTryCatch of info * term * (tmhandledexception * term) list
and tmexception = TmExc of string * term
and tmhandledexception = TmHandledExc of string * string

type binding =
    NameBind 
  | TyAbbBind of ty
  | TmAbbBind of term * (ty option)
  | VarBind of ty

type context = (string * binding) list

type command =
    Import of string
  | Eval of info * term
  | Bind of info * string * binding

(* ---------------------------------------------------------------------- *)
(* Context management *)

let emptycontext = []

let ctxlength ctx = List.length ctx

let addbinding ctx x bind = (x,bind)::ctx

let addname ctx x = addbinding ctx x NameBind

let rec isnamebound ctx x =
  match ctx with
      [] -> false
    | (y,_)::rest ->
        if y=x then true
        else isnamebound rest x

let rec pickfreshname ctx x =
  if isnamebound ctx x then pickfreshname ctx (x^"'")
  else ((x,NameBind)::ctx), x

let index2name fi ctx x =
  try
    let (xn,_) = List.nth ctx x in
    xn
  with Failure _ ->
    let msg =
      Printf.sprintf "Variable lookup failure: offset: %d, ctx size: %d" in
    error fi (msg x (List.length ctx))

let rec name2index fi ctx x =
  match ctx with
      [] -> error fi ("Identifier " ^ x ^ " is unbound")
    | (y,_)::rest ->
        if y=x then 0
        else 1 + (name2index fi rest x)

(* ---------------------------------------------------------------------- *)
(* Shifting *)

let tymap onvar c tyT = 
  let rec walk c tyT = match tyT with
    TyVar(x,n) -> onvar c x n
  | TyId(b) as tyT -> tyT
  | TyArr(tyT1,tyT2) -> TyArr(walk c tyT1,walk c tyT2)
  | TyUnit -> TyUnit
  | TyBool -> TyBool
  | TyNat -> TyNat
  | TyNotTyped -> TyNotTyped
  in walk c tyT

let tmmap onvar ontype c t = 
  let rec walk c t = match t with
    TmVar(fi,x,n) -> onvar fi c x n
  | TmTrue(fi) as t -> t
  | TmFalse(fi) as t -> t
  | TmIf(fi,t1,t2,t3) -> TmIf(fi,walk c t1,walk c t2,walk c t3)
  | TmAbs(fi,x,tyT1,t2) -> TmAbs(fi,x,ontype c tyT1,walk (c+1) t2)
  | TmApp(fi,t1,t2) -> TmApp(fi,walk c t1,walk c t2)
  | TmFix(fi,t1) -> TmFix(fi,walk c t1)
  | TmUnit(fi) as t -> t
  | TmZero(fi)      -> TmZero(fi)
  | TmSucc(fi,t1)   -> TmSucc(fi, walk c t1)
  | TmPred(fi,t1)   -> TmPred(fi, walk c t1)
  | TmIsZero(fi,t1) -> TmIsZero(fi, walk c t1)
  | TmExcDef(fi,name, ty,t1) -> TmExcDef(fi,name, ontype c ty, walk c t1)
  | TmRaiseExc(fi, TmExc(name, t), ty) -> TmRaiseExc(fi, TmExc(name, walk c t), ty)
  | TmTryCatch(fi, t, handlers) -> 
    TmTryCatch(fi, walk c t, List.map (fun (TmHandledExc(name, x), t1) -> (TmHandledExc(name, x), walk c t1)) handlers)
  in walk c t

let typeShiftAbove d c tyT =
  tymap
    (fun c x n -> if x>=c then TyVar(x+d,n+d) else TyVar(x,n+d))
    c tyT

let termShiftAbove d c t =
  tmmap
    (fun fi c x n -> if x>=c then TmVar(fi,x+d,n+d) 
                     else TmVar(fi,x,n+d))
    (typeShiftAbove d)
    c t

let termShift d t = termShiftAbove d 0 t

let typeShift d tyT = typeShiftAbove d 0 tyT

let bindingshift d bind =
  match bind with
    NameBind -> NameBind
  | TyAbbBind(tyT) -> TyAbbBind(typeShift d tyT)
  | TmAbbBind(t,tyT_opt) ->
     let tyT_opt' = match tyT_opt with
                      None->None
                    | Some(tyT) -> Some(typeShift d tyT) in
     TmAbbBind(termShift d t, tyT_opt')
  | VarBind(tyT) -> VarBind(typeShift d tyT)

(* ---------------------------------------------------------------------- *)
(* Substitution *)

let termSubst j s t =
  tmmap
    (fun fi j x n -> if x=j then termShift j s else TmVar(fi,x,n))
    (fun j tyT -> tyT)
    j t

let termSubstTop s t = 
  termShift (-1) (termSubst 0 (termShift 1 s) t)

let typeSubst tyS j tyT =
  tymap
    (fun j x n -> if x=j then (typeShift j tyS) else (TyVar(x,n)))
    j tyT

let typeSubstTop tyS tyT = 
  typeShift (-1) (typeSubst (typeShift 1 tyS) 0 tyT)

(* ---------------------------------------------------------------------- *)
(* Context management (continued) *)

let rec getbinding fi ctx i =
  try
    let (_,bind) = List.nth ctx i in
    bindingshift (i+1) bind 
  with Failure _ ->
    let msg =
      Printf.sprintf "Variable lookup failure: offset: %d, ctx size: %d" in
    error fi (msg i (List.length ctx))
let getTypeFromContext fi ctx i =
   match getbinding fi ctx i with
         VarBind(tyT) -> tyT
     | TmAbbBind(_,Some(tyT)) -> tyT
     | TmAbbBind(_,None) -> error fi ("No type recorded for variable "
                                        ^ (index2name fi ctx i))
     | _ -> error fi 
       ("getTypeFromContext: Wrong kind of binding for variable " 
         ^ (index2name fi ctx i)) 

(*Exceptions functions*)
let rec havehandler exc handlers = match (exc, handlers) with
  | (_, []) -> false
  | ((TmExc (name, v)), (TmHandledExc (name', v'), handler)::tail) when name=name' -> true
  | (exc, _::tail) -> havehandler exc tail

let rec gethandler exc handlers = match (exc, handlers) with
  | ((TmExc (name, v)), (TmHandledExc (name', v'), handler)::tail) when name=name' -> termSubstTop v handler
  | (exc, _::tail) -> gethandler exc tail
  | (_, []) -> raise NoRuleApplies
(* ---------------------------------------------------------------------- *)
(* Extracting file info *)

let tmInfo t = match t with
  | TmVar(fi,_,_) -> fi
  | TmTrue(fi) -> fi
  | TmFalse(fi) -> fi
  | TmIf(fi,_,_,_) -> fi
  | TmAbs(fi,_,_,_) -> fi
  | TmApp(fi, _, _) -> fi
  | TmFix(fi,_) -> fi
  | TmUnit(fi) -> fi
  | TmZero(fi) -> fi
  | TmSucc(fi,_) -> fi
  | TmPred(fi,_) -> fi
  | TmIsZero(fi,_) -> fi
  | TmExcDef(fi,_,_,_) -> fi
  | TmRaiseExc(fi,_,_) -> fi
  | TmTryCatch(fi,_,_) -> fi

(* ---------------------------------------------------------------------- *)
(* Printing *)

(* The printing functions call these utility functions to insert grouping
  information and line-breaking hints for the pretty-printing library:
     obox   Open a "box" whose contents will be indented by two spaces if
            the whole box cannot fit on the current line
     obox0  Same but indent continuation lines to the same column as the
            beginning of the box rather than 2 more columns to the right
     cbox   Close the current box
     break  Insert a breakpoint indicating where the line maybe broken if
            necessary.
  See the documentation for the Format module in the OCaml library for
  more details. 
*)

let obox0() = open_hvbox 0
let obox() = open_hvbox 2
let cbox() = close_box()
let break() = print_break 0 0

let small t = 
  match t with
    TmVar(_,_,_) -> true
  | _ -> false

let rec printty_Type outer ctx tyT = match tyT with
  | tyT -> printty_ArrowType outer ctx tyT

and printty_ArrowType outer ctx  tyT = match tyT with 
    TyArr(tyT1,tyT2) ->
      obox0(); 
      printty_AType false ctx tyT1;
      if outer then print_space();
      pr "->";
      if outer then print_space() else break();
      printty_ArrowType outer ctx tyT2;
      cbox()
  | tyT -> printty_AType outer ctx tyT

and printty_AType outer ctx tyT = match tyT with
    TyVar(x,n) ->
      if ctxlength ctx = n then
        pr (index2name dummyinfo ctx x)
      else
        pr ("[bad index: " ^ (string_of_int x) ^ "/" ^ (string_of_int n)
            ^ " in {"
            ^ (List.fold_left (fun s (x,_) -> s ^ " " ^ x) "" ctx)
            ^ " }]")
  | TyId(b) -> pr b
  | TyUnit -> pr "Unit"
  | TyBool -> pr "Bool"
  | TyNat -> pr "Nat"
  | TyNotTyped -> pr "No type"
  | tyT -> pr "("; printty_Type outer ctx tyT; pr ")"

let printty ctx tyT = printty_Type true ctx tyT; print_newline() 

let rec printtm_Term outer ctx t = match t with
    TmIf(fi, t1, t2, t3) ->
       obox0();
       pr "if ";
       printtm_Term false ctx t1;
       print_space();
       pr "then ";
       printtm_Term false ctx t2;
       print_space();
       pr "else ";
       printtm_Term false ctx t3;
       cbox()
  | TmAbs(fi,x,tyT1,t2) ->
      (let (ctx',x') = (pickfreshname ctx x) in
         obox(); pr "lambda ";
         pr x'; pr ":"; printty_Type false ctx tyT1; pr ".";
         if (small t2) && not outer then break() else print_space();
         printtm_Term outer ctx' t2;
         cbox())
  | TmFix(fi, t1) ->
       obox();
       pr "fix "; 
       printtm_Term false ctx t1;
       cbox()
  | TmExcDef(_, name, ty,t1) -> (pr "exception "; pr name; pr " of "; printty_Type outer ctx ty; pr " in "; printtm_Term outer ctx t1)
  | TmRaiseExc(_, TmExc(name, t), ty) -> 
    (pr "raise "; pr name; print_space(); printtm_Term outer ctx t; pr " as "; printty_Type outer ctx ty;)
  | TmTryCatch(_, t, handlers) -> 
    pr "try "; printtm_Term outer ctx t; 
    pr " catch {"; 
    (List.iter (fun (TmHandledExc(name, x), t1) ->
      (let (ctx',x') = (pickfreshname ctx x) in 
      pr name; print_space(); pr x'; pr " -> "; printtm_Term outer ctx' t1; print_space())) handlers);
    pr "}"
  | t -> printtm_AppTerm outer ctx t

and printtm_AppTerm outer ctx t = match t with
    TmApp(fi, t1, t2) ->
      obox0();
      printtm_AppTerm false ctx t1;
      print_space();
      printtm_ATerm false ctx t2;
      cbox()
  | TmPred(_,t1) ->
       pr "pred "; printtm_ATerm false ctx t1
  | TmIsZero(_,t1) ->
       pr "iszero "; printtm_ATerm false ctx t1
  | t -> printtm_ATerm outer ctx t

and printtm_ATerm outer ctx t = match t with
    TmVar(fi,x,n) ->
      if ctxlength ctx = n then
        pr (index2name fi ctx x)
      else
        pr ("[bad index: " ^ (string_of_int x) ^ "/" ^ (string_of_int n)
            ^ " in {"
            ^ (List.fold_left (fun s (x,_) -> s ^ " " ^ x) "" ctx)
            ^ " }]")
  | TmTrue(_) -> pr "true"
  | TmFalse(_) -> pr "false"
  | TmUnit(_) -> pr "unit"
  | TmZero(fi) ->
       pr "0"
  | TmSucc(_,t1) ->
     let rec f n t = match t with
         TmZero(_) -> pr (string_of_int n)
       | TmSucc(_,s) -> f (n+1) s
       | _ -> (pr "(succ "; printtm_ATerm false ctx t1; pr ")")
     in f 1 t1
  | t -> pr "("; printtm_Term outer ctx t; pr ")"

let printtm ctx t = printtm_Term true ctx t 


