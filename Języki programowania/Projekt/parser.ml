type token =
  | IMPORT of (Support.Error.info)
  | REC of (Support.Error.info)
  | IF of (Support.Error.info)
  | THEN of (Support.Error.info)
  | ELSE of (Support.Error.info)
  | TRUE of (Support.Error.info)
  | FALSE of (Support.Error.info)
  | LAMBDA of (Support.Error.info)
  | FIX of (Support.Error.info)
  | UNIT of (Support.Error.info)
  | UUNIT of (Support.Error.info)
  | BOOL of (Support.Error.info)
  | SUCC of (Support.Error.info)
  | PRED of (Support.Error.info)
  | ISZERO of (Support.Error.info)
  | NAT of (Support.Error.info)
  | EXCEPTION of (Support.Error.info)
  | OF of (Support.Error.info)
  | IN of (Support.Error.info)
  | RAISE of (Support.Error.info)
  | AS of (Support.Error.info)
  | TRY of (Support.Error.info)
  | CATCH of (Support.Error.info)
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
# 75 "parser.ml"
let yytransl_const = [|
    0|]

let yytransl_block = [|
  257 (* IMPORT *);
  258 (* REC *);
  259 (* IF *);
  260 (* THEN *);
  261 (* ELSE *);
  262 (* TRUE *);
  263 (* FALSE *);
  264 (* LAMBDA *);
  265 (* FIX *);
  266 (* UNIT *);
  267 (* UUNIT *);
  268 (* BOOL *);
  269 (* SUCC *);
  270 (* PRED *);
  271 (* ISZERO *);
  272 (* NAT *);
  273 (* EXCEPTION *);
  274 (* OF *);
  275 (* IN *);
  276 (* RAISE *);
  277 (* AS *);
  278 (* TRY *);
  279 (* CATCH *);
  280 (* UCID *);
  281 (* LCID *);
  282 (* INTV *);
  283 (* FLOATV *);
  284 (* STRINGV *);
  285 (* APOSTROPHE *);
  286 (* DQUOTE *);
  287 (* ARROW *);
  288 (* BANG *);
  289 (* BARGT *);
  290 (* BARRCURLY *);
  291 (* BARRSQUARE *);
  292 (* COLON *);
  293 (* COLONCOLON *);
  294 (* COLONEQ *);
  295 (* COLONHASH *);
  296 (* COMMA *);
  297 (* DARROW *);
  298 (* DDARROW *);
  299 (* DOT *);
    0 (* EOF *);
  300 (* EQ *);
  301 (* EQEQ *);
  302 (* EXISTS *);
  303 (* GT *);
  304 (* HASH *);
  305 (* LCURLY *);
  306 (* LCURLYBAR *);
  307 (* LEFTARROW *);
  308 (* LPAREN *);
  309 (* LSQUARE *);
  310 (* LSQUAREBAR *);
  311 (* LT *);
  312 (* RCURLY *);
  313 (* RPAREN *);
  314 (* RSQUARE *);
  315 (* SEMI *);
  316 (* SLASH *);
  317 (* STAR *);
  318 (* TRIANGLE *);
  319 (* USCORE *);
  320 (* VBAR *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\002\000\004\000\004\000\
\005\000\005\000\006\000\006\000\007\000\007\000\008\000\008\000\
\008\000\008\000\008\000\003\000\003\000\003\000\003\000\003\000\
\003\000\003\000\003\000\003\000\009\000\009\000\009\000\009\000\
\009\000\009\000\012\000\012\000\011\000\011\000\011\000\011\000\
\011\000\011\000\010\000\010\000\013\000\000\000"

let yylen = "\002\000\
\001\000\003\000\002\000\001\000\002\000\002\000\000\000\002\000\
\002\000\002\000\001\000\004\000\003\000\001\000\003\000\001\000\
\001\000\001\000\001\000\001\000\006\000\006\000\006\000\006\000\
\006\000\005\000\005\000\006\000\001\000\002\000\002\000\002\000\
\002\000\002\000\001\000\003\000\003\000\001\000\001\000\001\000\
\001\000\001\000\001\000\003\000\004\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\039\000\040\000\000\000\000\000\
\041\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\042\000\001\000\000\000\046\000\000\000\004\000\000\000\
\029\000\003\000\038\000\000\000\000\000\000\000\031\000\032\000\
\033\000\034\000\000\000\000\000\000\000\000\000\000\000\000\000\
\005\000\000\000\000\000\006\000\000\000\000\000\000\000\030\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\017\000\018\000\019\000\016\000\000\000\008\000\011\000\
\000\000\009\000\010\000\000\000\037\000\002\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\036\000\000\000\000\000\000\000\000\000\000\000\027\000\
\026\000\000\000\000\000\000\000\000\000\015\000\013\000\021\000\
\022\000\023\000\025\000\024\000\000\000\028\000\000\000\012\000\
\000\000\044\000\000\000"

let yydgoto = "\002\000\
\021\000\022\000\023\000\041\000\044\000\063\000\064\000\065\000\
\024\000\091\000\025\000\046\000\092\000"

let yysindex = "\006\000\
\001\000\000\000\252\254\094\255\000\000\000\000\241\254\111\255\
\000\000\111\255\111\255\111\255\251\254\013\255\094\255\238\254\
\225\254\000\000\000\000\094\255\000\000\232\254\000\000\111\255\
\000\000\000\000\000\000\037\255\006\255\010\255\000\000\000\000\
\000\000\000\000\031\255\032\255\094\255\094\255\033\255\041\255\
\000\000\041\255\094\255\000\000\255\254\253\254\001\000\000\000\
\094\255\041\255\041\255\041\255\041\255\034\255\038\255\019\255\
\045\255\000\000\000\000\000\000\000\000\041\255\000\000\000\000\
\042\255\000\000\000\000\094\255\000\000\000\000\057\255\035\255\
\040\255\055\255\056\255\041\255\041\255\051\255\047\255\027\255\
\020\255\000\000\094\255\094\255\094\255\094\255\094\255\000\000\
\000\000\052\255\036\255\030\255\041\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\053\255\000\000\051\255\000\000\
\117\255\000\000\111\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\039\255\
\008\255\000\000\000\000\000\000\000\000\000\000\000\000\007\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\058\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\004\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\054\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\221\254"

let yygindex = "\000\000\
\049\000\000\000\002\000\000\000\000\000\029\000\031\000\000\000\
\008\000\022\000\248\255\060\000\000\000"

let yytablesize = 309
let yytable = "\031\000\
\019\000\032\000\033\000\034\000\042\000\028\000\001\000\014\000\
\014\000\029\000\020\000\020\000\043\000\038\000\038\000\048\000\
\039\000\038\000\035\000\036\000\045\000\045\000\014\000\026\000\
\014\000\040\000\014\000\020\000\045\000\020\000\058\000\059\000\
\038\000\038\000\047\000\060\000\037\000\038\000\054\000\055\000\
\049\000\050\000\057\000\061\000\067\000\051\000\014\000\030\000\
\052\000\053\000\071\000\058\000\059\000\069\000\076\000\056\000\
\060\000\068\000\077\000\038\000\014\000\083\000\014\000\020\000\
\061\000\020\000\038\000\078\000\079\000\045\000\066\000\062\000\
\081\000\086\000\087\000\090\000\101\000\084\000\072\000\073\000\
\074\000\075\000\085\000\094\000\096\000\097\000\098\000\099\000\
\100\000\093\000\080\000\102\000\062\000\103\000\105\000\070\000\
\004\000\007\000\048\000\005\000\006\000\007\000\008\000\009\000\
\088\000\089\000\010\000\011\000\012\000\043\000\013\000\095\000\
\107\000\014\000\035\000\015\000\005\000\006\000\027\000\018\000\
\009\000\104\000\005\000\006\000\106\000\008\000\009\000\082\000\
\000\000\010\000\011\000\012\000\000\000\000\000\000\000\027\000\
\018\000\000\000\000\000\000\000\000\000\027\000\018\000\000\000\
\000\000\020\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\020\000\000\000\000\000\000\000\000\000\000\000\
\020\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
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
\000\000\003\000\000\000\004\000\000\000\000\000\005\000\006\000\
\007\000\008\000\009\000\000\000\000\000\010\000\011\000\012\000\
\000\000\013\000\000\000\000\000\014\000\000\000\015\000\000\000\
\016\000\017\000\018\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\020\000"

let yycheck = "\008\000\
\000\000\010\000\011\000\012\000\036\001\004\000\001\000\004\001\
\005\001\025\001\004\001\005\001\044\001\006\001\007\001\024\000\
\015\000\010\001\024\001\025\001\056\001\020\000\019\001\028\001\
\021\001\044\001\023\001\021\001\064\001\023\001\011\001\012\001\
\025\001\026\001\059\001\016\001\024\001\025\001\037\000\038\000\
\004\001\036\001\002\001\024\001\043\000\036\001\043\001\063\001\
\018\001\018\001\049\000\011\001\012\001\057\001\021\001\023\001\
\016\001\059\001\021\001\052\001\057\001\005\001\059\001\057\001\
\024\001\059\001\059\001\049\001\024\001\068\000\042\000\052\001\
\031\001\019\001\019\001\025\001\025\001\043\001\050\000\051\000\
\052\000\053\000\043\001\057\001\083\000\084\000\085\000\086\000\
\087\000\043\001\062\000\056\001\052\001\064\001\042\001\047\000\
\003\001\059\001\107\000\006\001\007\001\008\001\009\001\010\001\
\076\000\077\000\013\001\014\001\015\001\056\001\017\001\081\000\
\105\000\020\001\057\001\022\001\006\001\007\001\025\001\026\001\
\010\001\093\000\006\001\007\001\103\000\009\001\010\001\068\000\
\255\255\013\001\014\001\015\001\255\255\255\255\255\255\025\001\
\026\001\255\255\255\255\255\255\255\255\025\001\026\001\255\255\
\255\255\052\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\052\001\255\255\255\255\255\255\255\255\255\255\
\052\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
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
\255\255\001\001\255\255\003\001\255\255\255\255\006\001\007\001\
\008\001\009\001\010\001\255\255\255\255\013\001\014\001\015\001\
\255\255\017\001\255\255\255\255\020\001\255\255\022\001\255\255\
\024\001\025\001\026\001\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\052\001"

let yynames_const = "\
  "

let yynames_block = "\
  IMPORT\000\
  REC\000\
  IF\000\
  THEN\000\
  ELSE\000\
  TRUE\000\
  FALSE\000\
  LAMBDA\000\
  FIX\000\
  UNIT\000\
  UUNIT\000\
  BOOL\000\
  SUCC\000\
  PRED\000\
  ISZERO\000\
  NAT\000\
  EXCEPTION\000\
  OF\000\
  IN\000\
  RAISE\000\
  AS\000\
  TRY\000\
  CATCH\000\
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
# 122 "parser.mly"
      ( fun ctx -> [],ctx )
# 380 "parser.ml"
               :  Syntax.context -> (Syntax.command list * Syntax.context) ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'Command) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 :  Syntax.context -> (Syntax.command list * Syntax.context) ) in
    Obj.repr(
# 124 "parser.mly"
      ( fun ctx ->
          let cmd,ctx = _1 ctx in
          let cmds,ctx = _3 ctx in
          cmd::cmds,ctx )
# 392 "parser.ml"
               :  Syntax.context -> (Syntax.command list * Syntax.context) ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string Support.Error.withinfo) in
    Obj.repr(
# 131 "parser.mly"
                   ( fun ctx -> (Import(_2.v)),ctx )
# 400 "parser.ml"
               : 'Command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 133 "parser.mly"
      ( fun ctx -> (let t = _1 ctx in Eval(tmInfo t,t)),ctx )
# 407 "parser.ml"
               : 'Command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string Support.Error.withinfo) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'TyBinder) in
    Obj.repr(
# 135 "parser.mly"
      ( fun ctx -> ((Bind(_1.i, _1.v, _2 ctx)), addname ctx _1.v) )
# 415 "parser.ml"
               : 'Command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string Support.Error.withinfo) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'Binder) in
    Obj.repr(
# 137 "parser.mly"
      ( fun ctx -> ((Bind(_1.i,_1.v,_2 ctx)), addname ctx _1.v) )
# 423 "parser.ml"
               : 'Command))
; (fun __caml_parser_env ->
    Obj.repr(
# 141 "parser.mly"
      ( fun ctx -> TyVarBind )
# 429 "parser.ml"
               : 'TyBinder))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 143 "parser.mly"
      ( fun ctx -> TyAbbBind(_2 ctx) )
# 437 "parser.ml"
               : 'TyBinder))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 148 "parser.mly"
      ( fun ctx -> VarBind (_2 ctx))
# 445 "parser.ml"
               : 'Binder))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 150 "parser.mly"
      ( fun ctx -> TmAbbBind(_2 ctx, None) )
# 453 "parser.ml"
               : 'Binder))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ArrowType) in
    Obj.repr(
# 155 "parser.mly"
                ( _1 )
# 460 "parser.ml"
               : 'Type))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 157 "parser.mly"
      ( fun ctx ->
          let ctx1 = addname ctx _2.v in
          TyRec(_2.v,_4 ctx1) )
# 472 "parser.ml"
               : 'Type))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'AType) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'ArrowType) in
    Obj.repr(
# 165 "parser.mly"
     ( fun ctx -> TyArr(_1 ctx, _3 ctx) )
# 481 "parser.ml"
               : 'ArrowType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'AType) in
    Obj.repr(
# 167 "parser.mly"
            ( _1 )
# 488 "parser.ml"
               : 'ArrowType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'Type) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 172 "parser.mly"
           ( _2 )
# 497 "parser.ml"
               : 'AType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string Support.Error.withinfo) in
    Obj.repr(
# 174 "parser.mly"
      ( fun ctx ->
          if isnamebound ctx _1.v then
            TyVar(name2index _1.i ctx _1.v, ctxlength ctx)
          else 
            TyId(_1.v) )
# 508 "parser.ml"
               : 'AType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 180 "parser.mly"
      ( fun ctx -> TyUnit )
# 515 "parser.ml"
               : 'AType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 182 "parser.mly"
      ( fun ctx -> TyBool )
# 522 "parser.ml"
               : 'AType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 184 "parser.mly"
      ( fun ctx -> TyNat )
# 529 "parser.ml"
               : 'AType))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'AppTerm) in
    Obj.repr(
# 188 "parser.mly"
      ( _1 )
# 536 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'Term) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Term) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 190 "parser.mly"
      ( fun ctx -> TmIf(_1, _2 ctx, _4 ctx, _6 ctx) )
# 548 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Type) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 192 "parser.mly"
      ( fun ctx ->
          let ctx1 = addname ctx _2.v in
          TmAbs(_1, _2.v, _4 ctx, _6 ctx1) )
# 562 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Type) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 196 "parser.mly"
      ( fun ctx ->
          let ctx1 = addname ctx "_" in
          TmAbs(_1, "_", _4 ctx, _6 ctx1) )
# 576 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Type) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 200 "parser.mly"
      (fun ctx ->
        TmExcDef(_1, _2.v, _4 ctx, _6 ctx))
# 589 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'Type) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 203 "parser.mly"
      (fun ctx ->
        TmExcDef(_1, _2.v, _4 ctx, _6 ctx))
# 602 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'Term) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 206 "parser.mly"
      (fun ctx ->
        TmRaiseExc(_1, TmExc(_2.v, _3 ctx), _5 ctx))
# 614 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'Term) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'Type) in
    Obj.repr(
# 209 "parser.mly"
      (fun ctx ->
        TmRaiseExc(_1, TmExc(_2.v, _3 ctx), _5 ctx))
# 626 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'Term) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : Support.Error.info) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'Handlers) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 212 "parser.mly"
      (fun ctx ->
        TmTryCatch(_1, _2 ctx, _5 ctx))
# 639 "parser.ml"
               : 'Term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 217 "parser.mly"
      ( _1 )
# 646 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'AppTerm) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 219 "parser.mly"
      ( fun ctx ->
          let e1 = _1 ctx in
          let e2 = _2 ctx in
          TmApp(tmInfo e1,e1,e2) )
# 657 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 224 "parser.mly"
      ( fun ctx ->
          TmFix(_1, _2 ctx) )
# 666 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 227 "parser.mly"
      ( fun ctx -> TmSucc(_1, _2 ctx) )
# 674 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 229 "parser.mly"
      ( fun ctx -> TmPred(_1, _2 ctx) )
# 682 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'ATerm) in
    Obj.repr(
# 231 "parser.mly"
      ( fun ctx -> TmIsZero(_1, _2 ctx) )
# 690 "parser.ml"
               : 'AppTerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Term) in
    Obj.repr(
# 235 "parser.mly"
      ( _1 )
# 697 "parser.ml"
               : 'TermSeq))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'Term) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'TermSeq) in
    Obj.repr(
# 237 "parser.mly"
      ( fun ctx ->
          TmApp(_2, TmAbs(_2, "_", TyUnit, _3 (addname ctx "_")), _1 ctx) )
# 707 "parser.ml"
               : 'TermSeq))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Support.Error.info) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'TermSeq) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 243 "parser.mly"
      ( _2 )
# 716 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string Support.Error.withinfo) in
    Obj.repr(
# 245 "parser.mly"
      ( fun ctx ->
          TmVar(_1.i, name2index _1.i ctx _1.v, ctxlength ctx) )
# 724 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 248 "parser.mly"
      ( fun ctx -> TmTrue(_1) )
# 731 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 250 "parser.mly"
      ( fun ctx -> TmFalse(_1) )
# 738 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Support.Error.info) in
    Obj.repr(
# 252 "parser.mly"
      ( fun ctx -> TmUnit(_1) )
# 745 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int Support.Error.withinfo) in
    Obj.repr(
# 254 "parser.mly"
      ( fun ctx ->
          let rec f n = match n with
              0 -> TmZero(_1.i)
            | n -> TmSucc(_1.i, f (n-1))
          in f _1.v )
# 756 "parser.ml"
               : 'ATerm))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'Handler) in
    Obj.repr(
# 262 "parser.mly"
      ( fun ctx -> [_1 ctx] )
# 763 "parser.ml"
               : 'Handlers))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'Handler) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'Handlers) in
    Obj.repr(
# 264 "parser.mly"
      ( fun ctx -> (_1 ctx) :: (_3 ctx) )
# 772 "parser.ml"
               : 'Handlers))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string Support.Error.withinfo) in
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string Support.Error.withinfo) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Support.Error.info) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'AppTerm) in
    Obj.repr(
# 268 "parser.mly"
      ( fun ctx ->
          let ctx1 = addname ctx _2.v in
          (TmHandledExc(_1.v, _2.v), _4 ctx1) )
# 784 "parser.ml"
               : 'Handler))
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
