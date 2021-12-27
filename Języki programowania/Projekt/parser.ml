type token =
  | IMPORT of (Support.Error.info)
  | AS of (Support.Error.info)
  | USTRING of (Support.Error.info)
  | TYPE of (Support.Error.info)
  | REC of (Support.Error.info)
  | IF of (Support.Error.info)
  | THEN of (Support.Error.info)
  | ELSE of (Support.Error.info)
  | TRUE of (Support.Error.info)
  | FALSE of (Support.Error.info)
  | TIMESFLOAT of (Support.Error.info)
  | UFLOAT of (Support.Error.info)
  | INERT of (Support.Error.info)
  | LET of (Support.Error.info)
  | IN of (Support.Error.info)
  | LAMBDA of (Support.Error.info)
  | FIX of (Support.Error.info)
  | LETREC of (Support.Error.info)
  | UNIT of (Support.Error.info)
  | UUNIT of (Support.Error.info)
  | BOOL of (Support.Error.info)
  | SUCC of (Support.Error.info)
  | PRED of (Support.Error.info)
  | ISZERO of (Support.Error.info)
  | NAT of (Support.Error.info)
  | CASE of (Support.Error.info)
  | OF of (Support.Error.info)
  | UCID of (string Support.Error.withinfo)
  | LCID of (string Support.Error.withinfo)
  | INTV of (int Support.Error.withinfo)
  | FLOATV of (float Support.Error.withinfo)
  | STRINGV of (string Support.Error.withinfo)
  | APOSTROPHE of (Support.Error.info)
  | DQUOTE of (Support.Error.info)
  | ARROW of (Support.Error.info)
  | BANG of (Support.Error.info)
  | BARGT of (Support.Error.info)
  | BARRCURLY of (Support.Error.info)
  | BARRSQUARE of (Support.Error.info)
  | COLON of (Support.Error.info)
  | COLONCOLON of (Support.Error.info)
  | COLONEQ of (Support.Error.info)
  | COLONHASH of (Support.Error.info)
  | COMMA of (Support.Error.info)
  | DARROW of (Support.Error.info)
  | DDARROW of (Support.Error.info)
  | DOT of (Support.Error.info)
  | EOF of (Support.Error.info)
  | EQ of (Support.Error.info)
  | EQEQ of (Support.Error.info)
  | EXISTS of (Support.Error.info)
  | GT of (Support.Error.info)
  | HASH of (Support.Error.info)
  | LCURLY of (Support.Error.info)
  | LCURLYBAR of (Support.Error.info)
  | LEFTARROW of (Support.Error.info)
  | LPAREN of (Support.Error.info)
  | LSQUARE of (Support.Error.info)
  | LSQUAREBAR of (Support.Error.info)
  | LT of (Support.Error.info)
  | RCURLY of (Support.Error.info)
  | RPAREN of (Support.Error.info)
  | RSQUARE of (Support.Error.info)
  | SEMI of (Support.Error.info)
  | SLASH of (Support.Error.info)
  | STAR of (Support.Error.info)
  | TRIANGLE of (Support.Error.info)
  | USCORE of (Support.Error.info)
  | VBAR of (Support.Error.info)

open Parsing;;
let _ = parse_error;;
# 7 "parser.mly"
open Support.Error
open Support.Pervasive
open Syntax
# 79 "parser.ml"
let yytransl_const = [|
    0|]

let yytransl_block = [|
  257 (* IMPORT *);
  258 (* AS *);
  259 (* USTRING *);
  260 (* TYPE *);
  261 (* REC *);
  262 (* IF *);
  263 (* THEN *);
  264 (* ELSE *);
  265 (* TRUE *);
  266 (* FALSE *);
  267 (* TIMESFLOAT *);
  268 (* UFLOAT *);
  269 (* INERT *);
  270 (* LET *);
  271 (* IN *);
  272 (* LAMBDA *);
  273 (* FIX *);
  274 (* LETREC *);
  275 (* UNIT *);
  276 (* UUNIT *);
  277 (* BOOL *);
  278 (* SUCC *);
  279 (* PRED *);
  280 (* ISZERO *);
  281 (* NAT *);
  282 (* CASE *);
  283 (* OF *);
  284 (* UCID *);
  285 (* LCID *);
  286 (* INTV *);
  287 (* FLOATV *);
  288 (* STRINGV *);
  289 (* APOSTROPHE *);
  290 (* DQUOTE *);
  291 (* ARROW *);
  292 (* BANG *);
  293 (* BARGT *);
  294 (* BARRCURLY *);
  295 (* BARRSQUARE *);
  296 (* COLON *);
  297 (* COLONCOLON *);
  298 (* COLONEQ *);
  299 (* COLONHASH *);
  300 (* COMMA *);
  301 (* DARROW *);
  302 (* DDARROW *);
  303 (* DOT *);
    0 (* EOF *);
  304 (* EQ *);
  305 (* EQEQ *);
  306 (* EXISTS *);
  307 (* GT *);
  308 (* HASH *);
  309 (* LCURLY *);
  310 (* LCURLYBAR *);
  311 (* LEFTARROW *);
  312 (* LPAREN *);
  313 (* LSQUARE *);
  314 (* LSQUAREBAR *);
  315 (* LT *);
  316 (* RCURLY *);
  317 (* RPAREN *);
  318 (* RSQUARE *);
  319 (* SEMI *);
  320 (* SLASH *);
  321 (* STAR *);
  322 (* TRIANGLE *);
  323 (* USCORE *);
  324 (* VBAR *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\002\000\005\000\005\000\
\006\000\006\000\008\000\008\000\008\000\008\000\004\000\004\000\
\007\000\007\000\003\000\003\000\003\000\003\000\009\000\009\000\
\009\000\009\000\009\000\009\000\011\000\011\000\012\000\012\000\
\013\000\013\000\014\000\014\000\010\000\010\000\010\000\010\000\
\010\000\010\000\015\000\015\000\016\000\016\000\017\000\017\000\
\018\000\018\000\019\000\000\000"

let yylen = "\002\000\
\001\000\003\000\002\000\001\000\002\000\002\000\002\000\002\000\
\001\000\004\000\003\000\001\000\001\000\001\000\000\000\002\000\
\003\000\001\000\001\000\006\000\006\000\006\000\001\000\002\000\
\002\000\002\000\002\000\002\000\000\000\001\000\001\000\003\000\
\003\000\001\000\001\000\003\000\003\000\001\000\001\000\001\000\
\001\000\001\000\000\000\001\000\001\000\003\000\003\000\001\000\
\001\000\003\000\007\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\039\000\040\000\000\000\000\000\
\041\000\000\000\000\000\000\000\000\000\000\000\042\000\001\000\
\000\000\052\000\000\000\004\000\000\000\023\000\003\000\038\000\
\000\000\000\000\000\000\025\000\026\000\027\000\028\000\000\000\
\005\000\000\000\000\000\006\000\000\000\000\000\000\000\024\000\
\000\000\000\000\000\000\000\000\013\000\014\000\012\000\000\000\
\016\000\009\000\000\000\007\000\008\000\000\000\037\000\002\000\
\000\000\000\000\000\000\000\000\000\000\000\000\036\000\000\000\
\000\000\000\000\000\000\011\000\017\000\020\000\021\000\022\000\
\010\000"

let yydgoto = "\002\000\
\018\000\019\000\020\000\033\000\036\000\049\000\050\000\051\000\
\021\000\022\000\000\000\000\000\000\000\038\000\000\000\000\000\
\000\000\000\000\000\000"

let yysindex = "\008\000\
\001\000\000\000\235\254\024\255\000\000\000\000\234\254\009\255\
\000\000\009\255\009\255\009\255\218\254\224\254\000\000\000\000\
\024\255\000\000\205\254\000\000\009\255\000\000\000\000\000\000\
\007\255\233\254\237\254\000\000\000\000\000\000\000\000\255\254\
\000\000\255\254\024\255\000\000\215\254\227\254\001\000\000\000\
\024\255\255\254\255\254\001\255\000\000\000\000\000\000\255\254\
\000\000\000\000\022\255\000\000\000\000\024\255\000\000\000\000\
\015\255\245\254\253\254\019\255\008\255\042\255\000\000\024\255\
\024\255\024\255\255\254\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\005\255\252\254\000\000\000\000\
\000\000\000\000\000\000\000\000\251\254\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\010\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\244\254\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\003\000\000\000\252\255\000\000\000\000\030\000\012\000\000\000\
\000\000\071\000\000\000\000\000\000\000\021\000\000\000\000\000\
\000\000\000\000\000\000"

let yytablesize = 313
let yytable = "\025\000\
\016\000\019\000\019\000\044\000\038\000\038\000\026\000\034\000\
\001\000\032\000\023\000\039\000\037\000\041\000\038\000\035\000\
\042\000\005\000\006\000\045\000\043\000\054\000\064\000\046\000\
\038\000\038\000\047\000\009\000\060\000\004\000\053\000\055\000\
\005\000\006\000\018\000\065\000\057\000\024\000\015\000\007\000\
\008\000\056\000\009\000\066\000\027\000\010\000\011\000\012\000\
\018\000\037\000\018\000\038\000\024\000\015\000\048\000\019\000\
\062\000\019\000\038\000\070\000\071\000\072\000\045\000\052\000\
\017\000\067\000\046\000\015\000\068\000\047\000\035\000\058\000\
\059\000\069\000\063\000\000\000\000\000\061\000\028\000\017\000\
\029\000\030\000\031\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\040\000\000\000\000\000\000\000\000\000\
\073\000\048\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\003\000\000\000\000\000\000\000\000\000\004\000\000\000\
\000\000\005\000\006\000\000\000\000\000\000\000\000\000\000\000\
\007\000\008\000\000\000\009\000\000\000\000\000\010\000\011\000\
\012\000\000\000\000\000\000\000\013\000\014\000\015\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\017\000"

let yycheck = "\004\000\
\000\000\007\001\008\001\005\001\009\001\010\001\029\001\040\001\
\001\000\048\001\032\001\063\001\017\000\007\001\019\001\048\001\
\040\001\009\001\010\001\021\001\040\001\063\001\008\001\025\001\
\029\001\030\001\028\001\019\001\028\001\006\001\035\000\061\001\
\009\001\010\001\047\001\047\001\041\000\029\001\030\001\016\001\
\017\001\039\000\019\001\047\001\067\001\022\001\023\001\024\001\
\061\001\054\000\063\001\056\001\029\001\030\001\056\001\061\001\
\035\001\063\001\063\001\064\000\065\000\066\000\021\001\034\000\
\056\001\047\001\025\001\063\001\061\001\028\001\061\001\042\000\
\043\000\062\000\054\000\255\255\255\255\048\000\008\000\056\001\
\010\000\011\000\012\000\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\021\000\255\255\255\255\255\255\255\255\
\067\000\056\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\001\001\255\255\255\255\255\255\255\255\006\001\255\255\
\255\255\009\001\010\001\255\255\255\255\255\255\255\255\255\255\
\016\001\017\001\255\255\019\001\255\255\255\255\022\001\023\001\
\024\001\255\255\255\255\255\255\028\001\029\001\030\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\056\001"

let yynames_const = "\
  "

let yynames_block = "\
  IMPORT\000\
  AS\000\
  USTRING\000\
  TYPE\000\
  REC\000\
  IF\000\
  THEN\000\
  ELSE\000\
  TRUE\000\
  FALSE\000\
  TIMESFLOAT\000\
  UFLOAT\000\
  INERT\000\
  LET\000\
  IN\000\
  LAMBDA\000\
  FIX\000\
  LETREC\000\
  UNIT\000\
  UUNIT\000\
  BOOL\000\
  SUCC\000\
  PRED\000\
  ISZERO\000\
  NAT\000\
  CASE\000\
  OF\000\
  UCID\000\
  LCID\000\
  INTV\000\
  FLOATV\000\
  STRINGV\000\
  APOSTROPHE\000\
  DQUOTE\000\
  ARROW\000\
  BANG\000\
  BARGT\000\
  BARRCURLY\000\
  BARRSQUARE\000\
  COLON\000\
  COLONCOLON\000\
  COLONEQ\000\
  COLONHASH\000\
  COMMA\000\
  DARROW\000\
  DDARROW\000\
  DOT\000\
  EOF\000\
  EQ\000\
  EQEQ\000\
  EXISTS\000\
  GT\000\
  HASH\000\
  LCURLY\000\
  LCURLYBAR\000\
  LEFTARROW\000\
  LPAREN\000\
  LSQUARE\000\
  LSQUAREBAR\000\
  LT\000\
  RCURLY\000\
  RPAREN\000\
  RSQUARE\000\
  SEMI\000\
  SLASH\000\
  STAR\000\
  TRIANGLE\000\
  USCORE\000\
  VBAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 126 "parser.mly"
      ( fun ctx -> [],ctx )
# 386 "parser.ml"
               :  Syntax.context -> (Syntax.command list * Syntax.context) ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'Command) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 :  Syntax.context -> (Syntax.command list * Syntax.context) ) in
    Obj.repr(
# 128 "parser.mly"
      ( fun ctx ->
          let cmd,ctx = _1 ctx in
          let cmds,ctx = _3 ctx in
          cmd::cmds,ctx )
# 398 "parser.ml"
               :  Syntax.context -> (Syntax.command list * Syntax.context) ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string Support.Error.withinfo) in
    Obj.repr(
# 135 "parser.mly"
                   ( fun ctx -> (Import(_2.v)),ctx )
# 406 "parser.ml"
               : 'Command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 137 "parser.mly"
      ( fun ctx -> (let t = _1 ctx in Eval(tmInfo t,t)),ctx )
# 413 "parser.ml"
               : 'Command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string Support.Error.withinfo) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'TyBinder) in
    Obj.repr(
# 139 "parser.mly"
      ( fun ctx -> ((Bind(_1.i, _1.v, _2 ctx)), addname ctx _1.v) )
# 421 "parser.ml"
               : 'Command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string Support.Error.withinfo) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'Binder) in
    Obj.repr(
# 141 "parser.mly"
      ( fun ctx -> ((Bind(_1.i,_1.v,_2 ctx)), addname ctx _1.v) )
# 429 "parser.ml"
               : 'Command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 146 "parser.mly"
      ( fun ctx -> VarBind (_2 ctx))
# 437 "parser.ml"
               : 'Binder))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 148 "parser.mly"
      ( fun ctx -> TmAbbBind(_2 ctx, None) )
# 445 "parser.ml"
               : 'Binder))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ArrowType) in
    Obj.repr(
# 153 "parser.mly"
                ( _1 )
# 452 "parser.ml"
               : 'Type))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 155 "parser.mly"
      ( fun ctx ->
          let ctx1 = addname ctx _2.v in
          TyRec(_2.v,_4 ctx1) )
# 464 "parser.ml"
               : 'Type))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'Type) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 162 "parser.mly"
           ( _2 )
# 473 "parser.ml"
               : 'AType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string Support.Error.withinfo) in
    Obj.repr(
# 164 "parser.mly"
      ( fun ctx ->
          if isnamebound ctx _1.v then
            TyVar(name2index _1.i ctx _1.v, ctxlength ctx)
          else 
            TyId(_1.v) )
# 484 "parser.ml"
               : 'AType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 170 "parser.mly"
      ( fun ctx -> TyBool )
# 491 "parser.ml"
               : 'AType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 172 "parser.mly"
      ( fun ctx -> TyNat )
# 498 "parser.ml"
               : 'AType))
; (fun __caml_parser_env ->
    Obj.repr(
# 176 "parser.mly"
      ( fun ctx -> TyVarBind )
# 504 "parser.ml"
               : 'TyBinder))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 178 "parser.mly"
      ( fun ctx -> TyAbbBind(_2 ctx) )
# 512 "parser.ml"
               : 'TyBinder))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'AType) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'ArrowType) in
    Obj.repr(
# 184 "parser.mly"
     ( fun ctx -> TyArr(_1 ctx, _3 ctx) )
# 521 "parser.ml"
               : 'ArrowType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'AType) in
    Obj.repr(
# 186 "parser.mly"
            ( _1 )
# 528 "parser.ml"
               : 'ArrowType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'AppTerm) in
    Obj.repr(
# 190 "parser.mly"
      ( _1 )
# 535 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'Term) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Term) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 192 "parser.mly"
      ( fun ctx -> TmIf(_1, _2 ctx, _4 ctx, _6 ctx) )
# 547 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Type) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 194 "parser.mly"
      ( fun ctx ->
          let ctx1 = addname ctx _2.v in
          TmAbs(_1, _2.v, _4 ctx, _6 ctx1) )
# 561 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Type) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 198 "parser.mly"
      ( fun ctx ->
          let ctx1 = addname ctx "_" in
          TmAbs(_1, "_", _4 ctx, _6 ctx1) )
# 575 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 204 "parser.mly"
      ( _1 )
# 582 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'AppTerm) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 206 "parser.mly"
      ( fun ctx ->
          let e1 = _1 ctx in
          let e2 = _2 ctx in
          TmApp(tmInfo e1,e1,e2) )
# 593 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 211 "parser.mly"
      ( fun ctx ->
          TmFix(_1, _2 ctx) )
# 602 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 214 "parser.mly"
      ( fun ctx -> TmSucc(_1, _2 ctx) )
# 610 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 216 "parser.mly"
      ( fun ctx -> TmPred(_1, _2 ctx) )
# 618 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 218 "parser.mly"
      ( fun ctx -> TmIsZero(_1, _2 ctx) )
# 626 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    Obj.repr(
# 222 "parser.mly"
      ( fun ctx i -> [] )
# 632 "parser.ml"
               : 'FieldTypes))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'NEFieldTypes) in
    Obj.repr(
# 224 "parser.mly"
      ( _1 )
# 639 "parser.ml"
               : 'FieldTypes))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'FieldType) in
    Obj.repr(
# 228 "parser.mly"
      ( fun ctx i -> [_1 ctx i] )
# 646 "parser.ml"
               : 'NEFieldTypes))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'FieldType) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'NEFieldTypes) in
    Obj.repr(
# 230 "parser.mly"
      ( fun ctx i -> (_1 ctx i) :: (_3 ctx (i+1)) )
# 655 "parser.ml"
               : 'NEFieldTypes))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string Support.Error.withinfo) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 234 "parser.mly"
      ( fun ctx i -> (_1.v, _3 ctx) )
# 664 "parser.ml"
               : 'FieldType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 236 "parser.mly"
      ( fun ctx i -> (string_of_int i, _1 ctx) )
# 671 "parser.ml"
               : 'FieldType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 240 "parser.mly"
      ( _1 )
# 678 "parser.ml"
               : 'TermSeq))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'Term) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'TermSeq) in
    Obj.repr(
# 242 "parser.mly"
      ( fun ctx ->
          TmApp(_2, TmAbs(_2, "_", TyUnit, _3 (addname ctx "_")), _1 ctx) )
# 688 "parser.ml"
               : 'TermSeq))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'TermSeq) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 248 "parser.mly"
      ( _2 )
# 697 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string Support.Error.withinfo) in
    Obj.repr(
# 250 "parser.mly"
      ( fun ctx ->
          TmVar(_1.i, name2index _1.i ctx _1.v, ctxlength ctx) )
# 705 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 253 "parser.mly"
      ( fun ctx -> TmTrue(_1) )
# 712 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 255 "parser.mly"
      ( fun ctx -> TmFalse(_1) )
# 719 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 257 "parser.mly"
      ( fun ctx -> TmUnit(_1) )
# 726 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int Support.Error.withinfo) in
    Obj.repr(
# 259 "parser.mly"
      ( fun ctx ->
          let rec f n = match n with
              0 -> TmZero(_1.i)
            | n -> TmSucc(_1.i, f (n-1))
          in f _1.v )
# 737 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    Obj.repr(
# 267 "parser.mly"
      ( fun ctx i -> [] )
# 743 "parser.ml"
               : 'Fields))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'NEFields) in
    Obj.repr(
# 269 "parser.mly"
      ( _1 )
# 750 "parser.ml"
               : 'Fields))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Field) in
    Obj.repr(
# 273 "parser.mly"
      ( fun ctx i -> [_1 ctx i] )
# 757 "parser.ml"
               : 'NEFields))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'Field) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'NEFields) in
    Obj.repr(
# 275 "parser.mly"
      ( fun ctx i -> (_1 ctx i) :: (_3 ctx (i+1)) )
# 766 "parser.ml"
               : 'NEFields))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string Support.Error.withinfo) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 279 "parser.mly"
      ( fun ctx i -> (_1.v, _3 ctx) )
# 775 "parser.ml"
               : 'Field))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 281 "parser.mly"
      ( fun ctx i -> (string_of_int i, _1 ctx) )
# 782 "parser.ml"
               : 'Field))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Case) in
    Obj.repr(
# 285 "parser.mly"
      ( fun ctx -> [_1 ctx] )
# 789 "parser.ml"
               : 'Cases))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'Case) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'Cases) in
    Obj.repr(
# 287 "parser.mly"
      ( fun ctx -> (_1 ctx) :: (_3 ctx) )
# 798 "parser.ml"
               : 'Cases))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 5 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : string Support.Error.withinfo) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : Support.Error.info) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'AppTerm) in
    Obj.repr(
# 291 "parser.mly"
      ( fun ctx ->
          let ctx1 = addname ctx _4.v in
          (_2.v, (_4.v, _7 ctx1)) )
# 813 "parser.ml"
               : 'Case))
(* Entry toplevel *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let toplevel (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf :  Syntax.context -> (Syntax.command list * Syntax.context) )
