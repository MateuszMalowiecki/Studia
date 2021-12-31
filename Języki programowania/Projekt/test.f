/* Examples for testing */

lambda x:Bool. x;
(lambda x:Bool->Bool. if x false then true else false) 
  (lambda x:Bool. if x then false else true); 

lambda x:Nat. succ x;
(lambda x:Nat. succ (succ x)) (succ 0); 

exception RunTimeException of Nat in unit;

exception RunTimeException of Nat in (raise RunTimeException 0 as Nat);

raise RunTimeException 0 as Nat;

exception RunTimeException of Bool in (raise RunTimeException true as Nat);

exception RunTimeException of Nat in try (raise RunTimeException 0 as Nat) catch {RunTimeException 0 ==> 42 | RunTimeException 1 ==> 43};