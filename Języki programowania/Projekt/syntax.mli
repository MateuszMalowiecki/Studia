(* module Syntax: syntax trees and associated support functions *)

open Support.Pervasive
open Support.Error

(* Data type definitions *)
type ty =
    TyVar of int * int
  | TyRec of string * ty
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
  | TyVarBind
  | TyAbbBind of ty
  | TmAbbBind of term * (ty option)
  | VarBind of ty

type command =
    Import of string
  | Eval of info * term
  | Bind of info * string * binding

(* Contexts *)
type context
val emptycontext : context 
val ctxlength : context -> int
val addbinding : context -> string -> binding -> context
val addname: context -> string -> context
val index2name : info -> context -> int -> string
val getbinding : info -> context -> int -> binding
val name2index : info -> context -> string -> int
val isnamebound : context -> string -> bool
val getTypeFromContext : info -> context -> int -> ty

(* Shifting and substitution *)
val termShift: int -> term -> term
val termSubstTop: term -> term -> term
val typeShift : int -> ty -> ty
val typeSubstTop: ty -> ty -> ty
(*val tytermSubstTop: ty -> term -> term*)

(*Exceptions functions*)
val havehandler : tmexception -> (tmhandledexception * term) list -> bool
val gethandler : tmexception -> (tmhandledexception * term) list -> term

(* Printing *)
val printtm: context -> term -> unit
val printtm_ATerm: bool -> context -> term -> unit
val printty : context -> ty -> unit
(*val prbinding : context -> binding -> unit*)

(* Misc *)
val tmInfo: term -> info

