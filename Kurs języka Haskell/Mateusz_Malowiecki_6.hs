--Mateusz Małowiecki 300774
--Kurs języka Haskell
--Lista nr.6, 17.04.2020 
import Data.Maybe
import Data.List

--Zadanie 1

natPairs :: [(Integer,Integer)]
natPairs = [p | n <- [0..], p <- (natPairsprim n)] where 
    natPairsprim n = [(i, j) | i <- [0..n], j <- [0..n], i + j==n]

(><) :: [a] -> [b] -> [(a,b)]
(><) = flip cantor []  where
    cantor :: [a] -> [b] -> [b] -> [(a,b)]
    cantor [] _ _ = []
    cantor (x:xs) yrev [] = (Prelude.zip (x:xs) yrev) ++ (cantor xs yrev [])
    cantor xs yrev (y:ys) = (Prelude.zip xs yrev) ++ (cantor xs (y:yrev) ys)

--Zadanie 2
class Set s where
    emptyS  :: s a
    searchS :: Ord a => a -> s a -> Maybe a
    insertS :: Ord a => a -> s a -> s a
    delMaxS :: Ord a => s a -> Maybe (a, s a)
    deleteS :: Ord a => a -> s a -> s a

class Dictionary d where
    emptyD  :: d k v
    searchD :: Ord k => k -> d k v -> Maybe v
    insertD :: Ord k => k -> v -> d k v -> d k v
    deleteD :: Ord k => k -> d k v -> d k v

data KeyValue key value = KeyValue { key :: key, value :: value }
newtype SetToDict s k v = SetToDict (s (KeyValue k v))

instance Eq k => Eq (KeyValue k v) where
    kv1 == kv2 = (key kv1) == (key kv2)

instance Ord k => Ord (KeyValue k v) where
    kv1 <= kv2 = (key kv1) <= (key kv2) 

instance Set s => Dictionary (SetToDict s) where
    emptyD = SetToDict emptyS
    searchD k (SetToDict s) = change_to_val $ searchS (KeyValue {key=k, value=undefined}) s where
        change_to_val :: Maybe (KeyValue k v) -> Maybe v
        change_to_val Nothing = Nothing
        change_to_val (Just kv) = Just $ value kv
    insertD k v (SetToDict s) = SetToDict $ insertS (KeyValue {key=k, value=v}) s
    deleteD k (SetToDict s) = SetToDict $ deleteS (KeyValue {key=k, value=undefined}) s

--Zadanie 3

data PrimRec = Zero | Succ | Proj Int Int | Comb PrimRec [PrimRec] | Rec PrimRec PrimRec

arityCheck :: PrimRec -> Maybe Int
arityCheck Zero = Just 1
arityCheck Succ = Just 1
arityCheck (Proj i n) 
    | (i < 1) || (i > n) = Nothing
    | otherwise = Just n
arityCheck (Comb f []) = Nothing 
arityCheck (Comb f (g:gs)) = check_if_ok (arityCheck g) where
    check_if_ok Nothing = Nothing
    check_if_ok (Just m)
        | (helper m (arityCheck f) && all (helper m . arityCheck) gs) = Just m
        | otherwise = Nothing
    helper :: Int -> Maybe Int -> Bool
    helper m g = isJust g && fromJust g == m
arityCheck (Rec g h) = check_if_ok (arityCheck g) (arityCheck h) where
    check_if_ok Nothing _ = Nothing
    check_if_ok _ Nothing = Nothing
    check_if_ok (Just m) (Just n)
        | (m + 2 == n) = Just (m + 1)
        | otherwise = Nothing

--Zadanie 4
evalPrimRec :: PrimRec -> [Int] -> Int
evalPrimRec Zero [x] 
    | (x < 0) = error "Negative argument was passed" 
    | otherwise = 0
evalPrimRec Zero _ = error "Given argument of wrong arity"
evalPrimRec Succ [x] 
    | (x < 0) = error "Negative argument was passed" 
    | otherwise = x + 1
evalPrimRec Succ _ = error "Given argument of wrong arity"
evalPrimRec (Proj i n) xs
    | (i < 1) || (i > n) = error "Incorrect function"
    | any (< 0) xs =  error "Negative argument was passed" 
    | n /= length xs = error "Given argument of wrong arity"
    | otherwise = xs !! i
evalPrimRec (Comb f gs) xs = eval_with_arity (arityCheck (Comb f gs)) xs where
    eval_with_arity Nothing _ = error "Incorrect function"
    eval_with_arity (Just m) xs 
        | any (< 0) xs =  error "Negative argument was passed" 
        | m /= length xs = error "Given argument of wrong arity"
        | otherwise = evalPrimRec f (map (\g -> (evalPrimRec g xs)) gs) 
evalPrimRec (Rec g h) xs = eval_with_arity (arityCheck (Rec g h)) xs where
    eval_with_arity Nothing _ = error "Incorrect function"
    eval_with_arity (Just m) xs 
        | any (< 0) xs =  error "Negative argument was passed" 
        | m /= length xs = error "Given argument of wrong arity"
        | head xs == 0 = evalPrimRec g (Prelude.tail xs)
        | otherwise = evalPrimRec h (m:(evalPrimRec (Rec g h) ((head xs) - 1:(Prelude.tail xs))):(Prelude.tail xs)) 

--Zadanie 5
data Nat = S Nat | Z
rec :: (Nat -> a -> a) -> a -> Nat -> a
rec _ g Z = g
rec f g (S n) = f n (rec f g n)
add :: Nat -> Nat -> Nat
add = rec (const S)
mult :: Nat -> Nat -> Nat
mult n = rec (const (add n)) Z
pred :: Nat -> Nat
pred = rec const Z
ackermann :: Nat -> Nat -> Nat
ackermann = rec (\ _ b -> rec (const b) (b (S Z))) S
iter :: (a -> a) -> a -> Nat -> a
iter _ g Z = g
iter f g (S n) = f (iter f g n)

rec_with_iter :: (Nat -> a -> a) -> a -> Nat -> a
rec_with_iter f g = snd . iter (\(n, x) -> (S n, f n x)) (Z, g)

--Zadanie 6
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ c [] = c
foldr f c (x:xs) = f x (Main.foldr f c xs)
foldl :: (b -> a -> b) -> b -> [a] -> b
foldl _ c [] = c
foldl f c (x:xs) = Main.foldl f (f c x) xs

tail :: Eq a => [a] -> [a]
tail xs = Main.foldr (\(_:tl) _ -> tl) [] [xs]

reverse :: [a] -> [a]
reverse = Main.foldr (\x xs -> xs ++ [x]) []

zip :: [a] -> [b] -> [(a,b)]
zip = Main.foldr step done where
    done :: [b] -> [(a, b)]
    done ys = []
    step :: a -> ([b] -> [(a, b)]) -> [b] -> [(a, b)]
    step x f [] = []
    step x f (y:ys) = (x, y) : f ys

--Zadanie 7
data RAList a = RAZero (RAList (a,a)) | RAOne a (RAList (a,a)) | RANil
data List t a = Cons a (t a) | Nil

class ListView t where
    viewList :: t a -> List t a
    toList :: t a -> [a]
    cons :: a -> t a -> t a
    nil :: t a

instance ListView RAList where
    viewList RANil = Nil
    viewList (RAOne a rs) = Cons a (RAZero rs)
    viewList (RAZero rs) = make_good_type (viewList rs) where
        make_good_type :: List RAList (a,a) -> List RAList a
        make_good_type Nil = Nil
        make_good_type (Cons (v1, v2) r) = Cons v1 (RAOne v2 r)
    toList RANil =[]
    toList (RAZero rs) = extractPair (toList rs) where
        extractPair [] = []
        extractPair ((a, b):ps) = a:b:(extractPair ps)
    toList (RAOne r rs) = r:extractPair (toList rs) where
        extractPair [] = []
        extractPair ((a, b):ps) = a:b:(extractPair ps)
    nil = RANil
    cons a rl = join (RAOne a RANil) rl where
        join :: RAList a -> RAList a -> RAList a
        join acc RANil = acc
        join RANil r1 = r1
        join (RAZero rs1) (RAZero rs2) = RAZero (join rs1 rs2)
        join (RAOne a rs1) (RAZero rs2) = RAOne a (join rs1 rs2)
        join (RAZero rs1) (RAOne a rs2) = RAOne a (join rs1 rs2)
        join (RAOne a1 rs1) (RAOne a2 rs2) = RAZero $ join (RAOne (a1, a2) RANil) (join rs1 rs2)

--Zadanie 8
data BHeap a = BZero (BHeap (a,a)) | BOne a (BHeap (a,a)) | BNil

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
    fromList = Main.foldr Main.insert empty
    qtoList = unfoldr (\ t -> if isEmpty t then Nothing else Just (extractMin t))

instance Prioq BHeap where
    empty = BNil
    isEmpty BNil = True
    isEmpty _ = False
    single a = (BOne a BNil)
    merge BNil b2 = b2
    merge b1 BNil = b1
    merge (BZero b1) (BZero b2) = BZero $ merge b1 b2
    merge (BOne v1 b1) (BZero b2) = BOne v1 $ merge b1 b2
    merge (BZero b1) (BOne v2 b2) = BOne v2 $ merge b1 b2
    merge (BOne v1 b1) (BOne v2 b2) = BZero $ merge (BOne (v1, v2) BNil) (merge b1 b2)
    extractMin BNil = error "extracting min from empty heap"
    extractMin (BOne v1 b1) = (v1, BZero b1)
    extractMin (BZero b1) = (uncurry min v2, (BOne (uncurry max v2) b2)) where
        (v2, b2) = extractMin b1