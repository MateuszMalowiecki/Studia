--Mateusz Małowiecki 300774
--kurs języka Haskell
--lista nr. 7, 24.04.2020
{-# LANGUAGE KindSignatures, GADTs #-}
{-# LANGUAGE Rank2Types #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
import Data.List
--Zadanie 1
data PEmpty a = PEmpty
data PFork t a = PFork (t a) a (t a)
data Pennant t a = Pennant a (t a)
data PList t a = PNil
    | PZero (PList (PFork t) a)
    | POne (Pennant t a) (PList (PFork t) a)
newtype PHeap a = PHeap (PList PEmpty a)

class Prioq t where
    empty :: Ord a => t a
    isEmpty :: Ord a => t a -> Bool
    single :: Ord a => a -> t a
    insert :: Ord a => a -> t a -> t a
    merge :: Ord a => t a -> t a -> t a
    extractMin :: Ord a => t a -> (a, t a)
    findMin :: Ord a => t a -> a
    deleteMin :: Ord a => t a -> t a
    fromList :: Ord a => [a] -> t a
    qtoList :: Ord a => t a -> [a]
    insert = merge . single
    single = flip Main.insert empty
    extractMin t = (findMin t, deleteMin t)
    findMin = fst . extractMin
    deleteMin = snd . extractMin
    fromList = foldr Main.insert empty
    qtoList = unfoldr (\ t -> if isEmpty t then Nothing else Just (extractMin t))

--Pomocnicze funkcje scalające(odpowiednio) dwa proporczyki oraz dwie listy.
--Są wykorzystywane w dwóch miejscach(funkcje merge i extractMin), 
--więc wyjąłem je z klasy Prioq. 
merge_pennants :: Ord a => Pennant t a -> Pennant t a -> Pennant (PFork t) a
merge_pennants (Pennant a1 t1) (Pennant a2 t2)
    | (a1 <= a2) = Pennant a1 (PFork t1 a2 t2)
    | otherwise = Pennant a2 (PFork t1 a1 t2)

merge_plists :: Ord a => PList t a -> PList t a -> PList t a
merge_plists PNil l2 = l2
merge_plists l1 PNil = l1
merge_plists (PZero l1) (PZero l2) = PZero $ merge_plists l1 l2
merge_plists (POne p1 l1) (PZero l2) = POne p1 $ merge_plists l1 l2
merge_plists (PZero l1) (POne p2 l2) = POne p2 $ merge_plists l1 l2
merge_plists (POne p1 l1) (POne p2 l2) = PZero $ merge_plists (POne (merge_pennants p1 p2) PNil) (merge_plists l1 l2)

instance Prioq PHeap where
    empty = PHeap PNil

    isEmpty (PHeap PNil) = True
    isEmpty _ = False

    single a = PHeap $ POne (Pennant a PEmpty) PNil

    merge (PHeap l1) (PHeap l2) = PHeap $ merge_plists l1 l2

    extractMin (PHeap p) = (a, PHeap l) where
        (a, _, l) = extract_min_from p
        extract_min_from :: Ord a => PList t a -> (a, t a, PList t a)
        extract_min_from PNil = error "extracting element from empty heap"
        extract_min_from (PZero PNil) = error "invalid argument, last element of PList should be POne."
        extract_min_from (POne (Pennant a t) PNil) = (a, t, PNil)
        extract_min_from (PZero l1) = (a, l, POne (Pennant v r) xs) where
            (a, PFork l v r, xs)=extract_min_from l1
        extract_min_from (POne p@(Pennant v t1) l1) 
            | (v <= a) = (v, t1, zero l1)
            | otherwise = (a, l, PZero $ merge_plists (POne (merge_pennants p (Pennant a r)) PNil) xs) where
                (a, PFork l v r, xs)=extract_min_from l1
        zero :: PList (PFork t) a -> PList t a   
        zero PNil = PNil
        zero t =PZero t
--Zadanie 2
data BEmpty a = BEmpty
data BCons l a = BCons (BFork l a) (l a)
data BFork l a = BFork a (l a)
data BList l a = BNil
    | BZero (BList (BCons l) a)
    | BOne (BFork l a) (BList (BCons l) a)
newtype BHeap a = BHeap (BList BEmpty a)

--Pomocnicze funkcje scalające(odpowiednio) dwa forki oraz dwie listy.
--Są wykorzystywane w dwóch miejscach(funkcje merge i extractMin), 
--więc wyjąłem je z klasy Prioq. 

merge_forks :: Ord a => BFork t a -> BFork t a -> BFork (BCons t) a
merge_forks bf1@(BFork a1 t1) bf2@(BFork a2 t2)
    | (a1 <= a2) = BFork a1 (BCons bf2 t1)
    | otherwise = BFork a2 (BCons bf1 t2)

merge_blists :: Ord a => BList t a -> BList t a -> BList t a
merge_blists BNil l2 = l2
merge_blists l1 BNil = l1
merge_blists (BZero l1) (BZero l2) = BZero $ merge_blists l1 l2
merge_blists (BOne p1 l1) (BZero l2) = BOne p1 $ merge_blists l1 l2
merge_blists (BZero l1) (BOne p2 l2) = BOne p2 $ merge_blists l1 l2
merge_blists (BOne bf1 l1) (BOne bf2 l2) = BZero $ merge_blists (BOne (merge_forks bf1 bf2) BNil) (merge_blists l1 l2)

instance Prioq BHeap where
    empty = BHeap BNil
    isEmpty (BHeap BNil) = True
    isEmpty _ = False
    single a = BHeap $ BOne (BFork a BEmpty) BNil
    merge (BHeap l1) (BHeap l2) = BHeap $ merge_blists l1 l2
    extractMin (BHeap b) = (a, BHeap l) where
        (a, _, l) = extract_min_from b
        extract_min_from :: Ord a => BList t a -> (a, t a, BList t a)
        extract_min_from BNil = error "extracting element from empty heap"
        extract_min_from (BZero BNil) = error "invalid argument, last element of BList should be BOne."
        extract_min_from (BOne (BFork a t) BNil) = (a, t, BNil)
        extract_min_from (BZero l1) = (a, rc, BOne fc xs) where
            (a, BCons fc rc, xs)=extract_min_from l1
        extract_min_from (BOne p@(BFork v t1) l1) 
            | (v <= a) = (v, t1, zero l1)
            | otherwise = (a, rc, BZero $ merge_blists (BOne (merge_forks p fc) BNil) xs) where
                (a, BCons fc rc, xs)=extract_min_from l1
        zero :: BList (BCons t) a -> BList t a   
        zero BNil = BNil
        zero t =BZero t
--Zadanie 3
data Expr a where
    C :: a -> Expr a
    P :: (Expr a, Expr b) -> Expr (a,b)
    Not :: Expr Bool -> Expr Bool
    (:+), (:-), (:*) :: Expr Integer -> Expr Integer -> Expr Integer
    (:/) :: Expr Integer -> Expr Integer -> Expr (Integer,Integer)
    (:<), (:>), (:<=), (:>=), (:!=), (:==) :: Expr Integer -> Expr Integer -> Expr Bool
    (:&&), (:||) :: Expr Bool -> Expr Bool -> Expr Bool
    (:?) :: Expr Bool -> Expr a -> Expr a -> Expr a
    Fst :: Expr (a,b) -> Expr a
    Snd :: Expr (a,b) -> Expr b
infixl 6 :*, :/
infixl 5 :+, :-
infixl 4 :<, :>, :<=, :>=, :!=, :==
infixl 3 :&&
infixl 2 :||
infixl 1 :?

eval :: Expr a -> a
eval (C a) = a
eval (P (e1, e2)) = (eval e1, eval e2)
eval (Fst p)= fst (eval p)
eval (Snd p)= snd (eval p)
eval (Not e1) = not (eval e1)
eval (e1 :+ e2) = eval e1 + eval e2
eval (e1 :- e2) = eval e1 - eval e2
eval (e1 :* e2) = eval e1 * eval e2
eval (e1 :/ e2) = (eval e1 `div` eval e2, eval e1 `mod` eval e2)
eval (e1 :< e2) = eval e1 < eval e2
eval (e1 :<= e2) = eval e1 <= eval e2
eval (e1 :> e2) = eval e1 > eval e2
eval (e1 :>= e2) = eval e1 >= eval e2
eval (e1 :== e2) = eval e1 == eval e2
eval (e1 :!= e2) = eval e1 /= eval e2
eval (e1 :&& e2) = eval e1 && eval e2
eval (e1 :|| e2) = eval e1 || eval e2
eval ((:?) b e1 e2) = case eval b of
    True -> eval e1;
    False -> eval e2;

--Zadanie 4
data Zero :: *
data Succ :: * -> *
data Red :: *
data Black :: *
data Tree :: * -> * -> * -> * where
    Empty :: Tree Black Zero a
    Black :: Tree c1 h a -> a -> Tree c2 h a -> Tree Black (Succ h) a
    Red :: Tree Black h a -> a -> Tree Black h a -> Tree Red h a
data RedBlackTree :: * -> * where
    RedBlackTree :: Tree Black h a -> RedBlackTree a
rbfind :: Ord a => a -> RedBlackTree a -> Bool
rbfind a (RedBlackTree t) = find_in_tree a t where
    find_in_tree :: Ord a => a -> Tree c h a -> Bool
    find_in_tree a Empty = False
    find_in_tree a (Black l v r)
        | a < v = find_in_tree a l
        | a > v = find_in_tree a r
        | otherwise =True
    find_in_tree a (Red l v r)
        | a < v = find_in_tree a l
        | a > v = find_in_tree a r
        | otherwise =True
rbinsert :: Ord a => a -> RedBlackTree a -> RedBlackTree a
rbinsert = undefined
rbdelete :: Ord a => a -> RedBlackTree a -> RedBlackTree a
rbdelete = undefined
rbflatten :: RedBlackTree a -> [a]
rbflatten (RedBlackTree t) = flat t [] where
    flat :: Tree c h a -> [a] -> [a]
    flat Empty acc = acc
    flat (Black l v r) acc = flat l (v:flat r acc)
--Zadanie 6
newtype Church = Church (forall a. (a -> a) -> (a -> a))
--pomocnicza funkcja konwertująca typ Church na Integer
to_integer :: Church -> Integer
to_integer (Church f) = f (1 +) 0

--wartość zero typu Church
czero :: Church
czero = Church $ \f x -> x

--wartość jeden typu Church
cone :: Church
cone = Church $ \f x -> f x

instance Eq Church where
    c1 == c2 = (to_integer c1) == (to_integer c2)
instance Ord Church where
    c1 <= c2 = (to_integer c1) <= (to_integer c2)
instance Show Church where
    show = show . to_integer
instance Num Church where
    (Church n) + (Church m) = Church $ \f -> n f . m f
    c1 - c2 
        | c1 <= c2 = czero
        | otherwise = fromInteger $ (to_integer c1) - (to_integer c2)
    (Church n) * (Church m) = Church $ n . m
    abs = id
    signum c
        | (c == czero) = czero
        | otherwise = cone
    fromInteger n = Church $ \f x -> iterate f x !! (fromInteger n) 

--Zadanie 7
newtype CList x = CList (forall a. (x -> a -> a) -> a -> a)
cempty :: CList x
cempty = CList $ \f e -> e
cons :: x -> CList x -> CList x
cons x (CList xs) = CList $ \f -> (f x . xs f)
append :: CList x -> CList x -> CList x
append (CList c1) (CList c2) = CList $ \f -> (c1 f) . (c2 f)
--cfromList $ (ctoList c1) ++ (ctoList c2)
cfromList :: [x] -> CList x
cfromList xs = CList (flip g xs) where
    g :: (x -> a -> a) -> [x] -> a -> a
    g = flip . foldr
ctoList :: CList x -> [x]
ctoList (CList f) = f (:) []

--Zadanie 8
newtype MList x = MList (forall m. Monoid m => (x -> m) -> m)
moempty :: MList x
moempty = MList $ \f -> mempty
mocons :: x -> MList x -> MList x
mocons x (MList xs) = MList $ \f -> f x `mappend` xs f
moappend :: MList x -> MList x -> MList x
moappend (MList m1) (MList m2) = MList $ (\f -> (m1 f) `mappend` (m2 f))
mofromList :: [x] -> MList x
mofromList xs = MList (g xs) where
    g :: Monoid m => [x] -> (x -> m) -> m
    g [] _ = mempty
    g (x:xs) f = f x `mappend` g xs f
motoList :: MList x -> [x]
motoList (MList f) = f (:) []