--Mateusz Małowiecki 300774
--Kurs języka Haskell
--Lista nr.11, 14.06.2020 
{-#LANGUAGE FlexibleInstances #-}
{-#LANGUAGE ExistentialQuantification #-}
{-#LANGUAGE QuantifiedConstraints #-}
{-#LANGUAGE RankNTypes #-}
{-#LANGUAGE TypeOperators #-}
{-#LANGUAGE PolyKinds #-}
{-#LANGUAGE KindSignatures #-}
{-#LANGUAGE FlexibleContexts #-}
{-#LANGUAGE MultiParamTypeClasses #-}
{-#LANGUAGE UndecidableInstances #-}
{-#LANGUAGE FunctionalDependencies #-}
{-#LANGUAGE DeriveFunctor#-}
{-#LANGUAGE ConstraintKinds #-}

import Control.Monad (ap, MonadPlus, mzero, mplus)
import Control.Applicative (Alternative, empty, (<|>))

--Zadanie 1
data Yoneda f a = Yoneda (forall x. (a -> x) -> f x)

instance Functor (Yoneda f) where
    fmap f (Yoneda ax) = Yoneda $ \b -> ax (b . f)

toYoneda :: (Functor f) => f a -> Yoneda f a
toYoneda a = Yoneda $ \f -> fmap f a

fromYoneda :: Yoneda f a -> f a
fromYoneda (Yoneda ax) = ax id

--Zadanie 2
newtype DList a = DList { fromDList :: [a] -> [a] }
instance Semigroup (DList a) where
    DList f <> DList g = DList $ f . g
repDList :: DList a -> Yoneda DList a
repDList (DList xs) = repList (xs [])
repList :: [a] -> Yoneda DList a
repList xs = Yoneda $ \f -> DList (\ys -> (map f xs) ++ ys)
instance Semigroup (Yoneda DList a) where
    h <> j = repDList $ (fromYoneda h) <> (fromYoneda j)
--Przez tę konwersję tracimy pożądane własności list różnicowych, gdyż musimy dokonać konwersji do zwykłej listy
--Zadanie 3
--OVERLAPS nie jest częścią rozwiązania i zostało dopisane ze względu na
--instancję Semigroup dla DList w zadaniu 2
instance {-# OVERLAPS #-} (Functor f, forall x. Semigroup (f x)) => Semigroup (Yoneda f a) where 
    h <> j = toYoneda $ (fromYoneda h) <> (fromYoneda j)
--Zadanie 4
newtype Cod f a = Cod { runCod :: forall x. (a -> f x) -> f x }

instance Functor (Cod f) where
    fmap f (Cod m) = Cod $ \k -> m (\x -> k (f x))

instance Applicative (Cod f) where
    pure  = return
    (<*>) = ap

instance Monad (Cod f) where
    return x = Cod $ \k -> k x
    m >>= k  = Cod $ \c -> runCod m (\a -> runCod (k a) c)

fromCod :: (Monad m) => Cod m a -> m a
fromCod (Cod f) = f return

toCod :: (Monad m) => m a -> Cod m a
toCod a = Cod $ \k -> a >>= k

instance (Alternative f) => Alternative (Cod f) where
    empty = Cod $ const empty
    (<|>) (Cod f1) (Cod f2) = Cod $ \f -> (f1 f) <|> (f2 f)

instance MonadPlus m => MonadPlus (Cod m) where
    mzero = empty
    mplus = (<|>)

--złożoność konkatenacji przy użyciu mplus:
--zbadamy teoretycznie złożoność następującego wyrażenia:
--fromCod $ (..(toCod [1] <|> toCod [2]) <|> ...) <|> toCod [n]
--w zależności od n.
--Zauważmy najpierw że : toCod [i] == Cod (\k -> [i] >>= k) == Cod (\k -> concatMap k [i]) ==
-- == Cod (\k -> concat [k i]) == Cod (\k -> k i), więc toCod [i] == Cod (\k -> k i), 
--więc nasze wyrażenie wyewaluuje się do: 
--fromCod $ (..(Cod (\k -> k 1) <|> Cod (\k -> k 2)) <|> ...) <|> Cod (\k -> k n)
--Zauważmy teraz że Cod (\k -> k 1) <|> Cod (\k -> k 2) == Cod (\k -> k 1 <|> k 2) == Cod (\k -> k 1 ++ k 2)
--następnie Cod (\k -> k 1 ++ k 2) <|> Cod (\k -> k 3) == Cod (\k -> k 1 ++ k 2 <|> k 3) == Cod (\k -> k 1 ++ k 2 ++ k 3).
--Wykonując kolejne kroki ewaluacji wyjdzie nam że wyjściowe wyrażenie jest równe:
--fromCod $ Cod (\k -> k 1 ++ k 2 ++ ... ++ k n), a po zastosowaniu definicji "fromCod":
--return 1 ++ return 2 ++ ... ++ return n == [1] ++ [2] ++ ... ++ [n] == [1,2,..,n].
--Wnioski po ewaluacji:
--Zauważmy że każdy etap ewaluacji odbywał się w liniowym czasie i pamięci, więc złożoność konkatenacji jest liniowa.
--UWAGA 1:
--Co prawda swoje wnioskowanie oparłem jedynie na przypadku, gdy listy są jednoelementowe, jednak można go łatowo uogólnić na listy wieloelementowe, gdyż
--toCod [1,2,...,m] == Cod (\k -> [1,2,..,m] >>= k) == Cod (\k -> concatMap k [1,2,..,m]) == Cod (\k -> concat [k 1, k 2, ..., k m]) == Cod (\k -> k 1 ++ k 2 ++ ... ++ k m),
--więc ewaluacja wygląda w tym przypadku analogicznie do przypadku gdu listy są jednoelementowe, więc również zajmuje linowy czas i pamięć.
--UWAGA 2:
--Łatwo zauważyć że poza fragemntem [1] ++ [2] ++ ... ++ [n] wszystkie pozostałe części ewaluacji zajmują czas liniowy.
--Natomiast wyliczenie fragmentu [1] ++ [2] ++ ... ++ [n] w czasie liniowym wymaga żeby ewaluacja była leniwa a operator (++) łączny w prawo
--(w takim przypadku [1] ++ [2] ++ ... ++ [n] == [1] ++ ([2] ++ ...([n-1] ++ [n])...)). 
--Gdyby ewaluacja była gorliwa to wyrażenie byłoby wyliczane jako:
-- [1] ++ [2] ++ ... ++ [n] == (...([1] ++ [2]) ++ ...[n-1]) ++ [n] i złożoność byłaby kwadratowa.
--Zadanie 5
class Category (t :: k -> k -> *) ctx | t -> ctx where
    ident :: (ctx a) => a `t` a
    comp  :: (ctx a, ctx b, ctx c) => b `t` c -> a `t` b -> a `t` c

class EmptyCtx a
instance EmptyCtx a

instance Category (->) EmptyCtx where
    ident = id
    comp = (.)

newtype Kleisli m a b = Kleisli { runKleisli :: a -> m b }

instance (Monad m) => Category (Kleisli m) EmptyCtx where
    ident = Kleisli return
    comp (Kleisli f) (Kleisli g) = Kleisli $ \x -> g x >>= f
--Zadanie 6
class (Category t ctx) => MonoidalCategory (t :: k -> k -> *) ctx (tens :: k -> k -> k) (unit :: k) | t -> tens, t -> unit where
    bimap :: (ctx a, ctx a', ctx b, ctx b', ctx (tens a b), ctx (tens a' b')) => a `t` a' -> b `t` b' -> tens a b `t` tens a' b'

class (MonoidalCategory t ctx tens unit) => MonoidInCategory (t :: k -> k -> *) ctx tens unit (m :: k) where
    one  :: (ctx m) => unit `t` m
    mult :: (ctx m) => tens m m `t` m

-- example of monoid in a monoidal category

newtype NatTrans f g = NatTrans { runNatTrans :: forall a. f a -> g a }

instance Category NatTrans Functor where
    ident = NatTrans id
    NatTrans f `comp` NatTrans g = NatTrans $ f . g

newtype Identity a = Identity { runIdentity :: a } deriving (Functor)

newtype Comp f g x = Comp { runComp :: f (g x) } deriving (Functor)

instance MonoidalCategory NatTrans Functor Comp Identity where
    bimap (NatTrans f) (NatTrans g) = NatTrans (\(Comp c) -> Comp $ (f . fmap g) c)

instance MonoidInCategory NatTrans Functor Comp Identity [] where
    one  = NatTrans (\(Identity a) -> [a])
    mult = NatTrans (\(Comp xss) -> concat xss)

-- monads form monoids

newtype MonadFromMonoid m a = MonadFromMonoid (m a) deriving (Functor)

instance (Functor f, MonoidInCategory NatTrans Functor Comp Identity f) => Applicative (MonadFromMonoid f) where
    pure  = return
    (<*>) = ap
  
instance (Functor f, MonoidInCategory NatTrans Functor Comp Identity f) => Monad (MonadFromMonoid f) where
    return a = MonadFromMonoid (o (Identity a)) where (NatTrans o) = one  
    m >>= f  = (mu $ Comp (fmap f m)) where (NatTrans mu) = mult 

-- monoids from monads

newtype MonoidFromMonad m a = MonoidFromMonad (m a) deriving (Functor)

instance (Monad m) => MonoidInCategory NatTrans Functor Comp Identity m where
    one  = NatTrans (\(Identity a) -> return a)
    mult = NatTrans (\(Comp mss) -> mss >>= id)