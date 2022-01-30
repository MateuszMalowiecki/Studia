(* module Core

   Core typechecking and evaluation functions
*)

open Syntax
open Support.Error

val eval : context -> term -> term 
val typeof1 : context -> (string * ty) list -> term -> ty
val typeof : context -> (string * ty) list -> term -> ty
val tyeqv : context -> ty -> ty -> bool
val simplifyty : context -> ty -> ty
val is_defined_in_context : string -> (string * ty) list -> bool
val definition_in_context : string -> (string * ty) list -> ty
