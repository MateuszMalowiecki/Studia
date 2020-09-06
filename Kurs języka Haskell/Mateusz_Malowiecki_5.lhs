{-|
    Module: Lista5.hs
    Copyright: Mateusz Małowiecki
-}
-----------------------------------
 {-# LANGUAGE FlexibleInstances #-}
 {-# LANGUAGE IncoherentInstances #-}
 {-# LANGUAGE UndecidableInstances #-}
 {-# LANGUAGE ViewPatterns #-}
 {-# LANGUAGE BangPatterns #-}
module Lista_5 where
import Control.Monad
import Control.Applicative
import Data.List
 --Zadanie 1
class NFData a where
   rnf :: a -> ()
instance (Num a) => NFData a where
   rnf !a=a `seq` ()
instance (NFData a) => NFData [a] where
   rnf ![]=()
   rnf (!x:(!xs))=(rnf x) `seq` (rnf xs)
instance (NFData a, NFData b) => NFData (a, b) where
   rnf (!a, !b) = (rnf a) `seq` (rnf b)
deepseq :: NFData a => a -> b -> b
deepseq !a !b = (rnf a) `seq` b
($!!) :: NFData a => (a -> b) -> a -> b
(!f) $!! (!x) = x `deepseq` f $! x
 --Zadanie 2
subseqM :: MonadPlus m => [a] -> m [a]
subseqM [] = return mzero
subseqM (x:xs) = do 
    ys <- subseqM xs
    return (x:ys) `mplus` return ys
ipermM :: MonadPlus m => [a] -> m [a]
ipermM [] = return mzero
ipermM (x:xs) = ipermM xs >>= insert x where
    insert :: MonadPlus m => a -> [a] -> m [a]
    insert x [] = return [x]
    insert x ys'@(y:ys)=return (x:ys') `mplus` zs where
        zs = fmap (y:) (insert x ys)
spermM :: MonadPlus m => [a] -> m [a]
spermM [] = return mzero
spermM xs = do
    (y, ys) <- select xs
    zs <- spermM ys
    return (y:zs) where
        select :: MonadPlus m => [a] -> m (a, [a])
        select [y] = return (y, [])
        select (y:ys) = return (y, ys) `mplus` do
            (z, zs) <- select ys
            return (z, y:zs)
 --Zadanie 6
data List t a = Cons a (t a) | Nil
newtype SimpleList a = SimpleList { fromSimpleList :: List SimpleList a }
class ListView t where
    viewList :: t a -> List t a
    toList :: t a -> [a]
    toList (viewList -> Nil) = []
    toList (viewList -> (Cons x xs)) = x:(toList xs) 
    cons :: a -> t a -> t a
    nil :: t a
data CList a = CList a :++: CList a | CSingle a | CNil
instance ListView CList where
    viewList CNil = Nil
    viewList (CSingle a)=Cons a CNil
    viewList (c1 :++: c2) = viewl cl1 cl2 where
        cl1 = viewList c1
        cl2 = viewList c2
        viewl :: List CList a -> List CList a -> List CList a
        viewl c1 Nil = c1
        viewl Nil c2 = c2
        viewl (Cons x xs) (Cons y ys) = Cons x (xs :++: (cons y ys))
    cons a CNil = CSingle a
    cons a (CSingle b) = (CSingle a) :++: (CSingle b)
    cons a (c1 :++: c2) = (cons a c1) :++: c2
    nil = CNil
instance Functor CList where
    fmap f CNil = CNil
    fmap f (CSingle a) = CSingle (f a)
    fmap f (c1 :++: c2) = (fmap f c1) :++: (fmap f c2)
instance Applicative CList where
    pure a = CSingle a
    CNil <*> c = CNil
    CSingle f <*> c = (fmap f c)
    (c1 :++: c2) <*> c = (c1 <*> c) :++: (c2 <*> c)
instance Monad CList where
    CNil >>= _ = CNil
    (CSingle x) >>= f = f x
    (xs :++: ys) >>= f = (xs >>= f) :++: (ys >>= f)
instance Alternative CList where
    empty = CNil
    (<|>) = (:++:)
instance MonadPlus CList
instance Foldable CList where
    foldr _ e CNil = e
    foldr f e (CSingle a) = f a e
    foldr f e (c1 :++: c2) = foldr f (foldr f e c2) c1 
instance Traversable CList where
    traverse _ CNil = pure CNil
    traverse f (CSingle a) = fmap CSingle (f a)
    traverse f (c1 :++: c2) = liftA2 (:++:) (traverse f c1) (traverse f c2)
 --Zadanie 7
newtype DList a = DList { fromDList :: [a] -> [a] }
dappend :: DList a -> DList a -> DList a
dappend d1 d2 = DList (fromDList d1 . fromDList d2)
instance ListView DList where
    viewList = vl . toList where
        vl :: [a] -> List DList a
        vl []=Nil
        vl (x:xs) = Cons x $ DList (\ys -> xs ++ ys)
    toList xs = fromDList xs []
    cons x xs = DList ((x:) . fromDList xs)
    nil = DList id
instance Functor DList where
    fmap f xs = DList (\ys -> (map f (toList xs)) ++ ys)
instance Applicative DList where
    pure x = DList (\ys -> x:ys)
    fs <*> xs = DList (\ys -> ((toList fs) <*> (toList xs)) ++ ys)
instance Monad DList where
    d >>= f = foldr dappend (DList id) (fmap f (toList d)) where 
instance Alternative DList where
    empty = DList id
    (<|>) = dappend
instance MonadPlus DList
instance Foldable DList where
    foldr f e xs = foldr f e (toList xs)
instance Traversable DList where
    traverse f xs = fmap (DList . (++)) (traverse f (toList xs))