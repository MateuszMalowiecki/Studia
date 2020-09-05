--Zad.1
class Monad m => StreamTrans m i o | m -> i o where
readS :: m (Maybe i)
emitS :: o -> m ()
--Zad.2
newtype ListTrans i o a = LT { unLT :: [i] -> ([i], [o], a) }
instance Functor (ListTrans i o)
instance Applicative (ListTrans i o)
instance Monad (ListTrans i o) where
return a = Main.LT(\i -> (i, [], a))
(Main.LT a) >>= f = (f a1) where
	(_, _, a1)=a []
instance StreamTrans (ListTrans i o) i o where
readS = Main.LT (\xs -> if xs==[]
	then (xs, [], Nothing)
	else (xs, [], (Just (head xs))))
emitS c = Main.LT (\xs -> (xs, [c], ()))
transform :: ListTrans i o a -> [i] -> ([o], a)
transform (Main.LT f) il = (os, a) where
	(is, os, a) = f il
--Zad.4
class Monad m => Random m where
random :: m Int
newtype RS t = RS {unRS :: Int -> (Int, t)}
instance Functor RS where
instance Applicative RS where
instance Monad RS where
instance Random RS where
random = RS (\i -> let y=16807*(i `mod` 127773)-2836*(i/127773) in if (y > 0) then (i, y) else (i, y+2147483647))
--Zad.6
class Monad m => Nondet m where
amb :: m a -> m a -> m a
fail :: m a
instance Nondet [] where
amb m1 m2=m1++m2
fail = []
main :: IO()
main = Prelude.return ()
