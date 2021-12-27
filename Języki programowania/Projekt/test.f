/* Examples for testing */




lambda x:Bool. x;
(lambda x:Bool->Bool. if x false then true else false) 
  (lambda x:Bool. if x then false else true); 

lambda x:Nat. succ x;
(lambda x:Nat. succ (succ x)) (succ 0); 
  
fix_T = 
lambda f:T->T.
  (lambda x:(Rec A.A->T). f (x x))
  (lambda x:(Rec A.A->T). f (x x));

