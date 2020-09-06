--Mateusz Małowiecki 300774
--kurs języka Haskell
--lista nr. 8, 08.05.2020

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}
{-# LANGUAGE FlexibleInstances #-}

import GHC.TypeLits (TypeError, ErrorMessage(Text))
import Data.Maybe

--Zadanie 1
data Nat = Zero | Succ Nat

data Full_tree :: Nat -> * -> * where
    Full_leaf :: Full_tree Zero a
    Full_node :: Full_tree n a -> a -> Full_tree n a -> Full_tree (Succ n) a

--Zadanie 2
data Matrix :: Nat -> Nat -> * -> * where
     Matr :: Num a => [[a]] -> Matrix n m a

matrix_add :: Num a => Matrix m n a -> Matrix m n a -> Matrix m n a
matrix_add (Matr xss) (Matr yss) = Matr $ zipWith (\xs ys -> zipWith (+) xs ys) xss yss

matrix_mult :: Num a => Matrix m n a -> Matrix n k a -> Matrix m k a
matrix_mult (Matr xss) (Matr yss) = Matr $ [[sum (zipWith (*) xr yc) | yc <- transpose yss] | xr <- xss] where
    transpose :: [[a]] -> [[a]]
    transpose [] = []
    transpose ([]:xss) = transpose xss
    transpose xss = ([h | (h:_) <- xss]) : transpose ([t | (_:t) <- xss])

--Zadanie 3

--dodatkowy kind Pair_List do reprezentowania partii szachowych
data Pair_List a = Pair_Nil | Pair_Cons (a, a) (Pair_List a)

--Good_game reprezentuje gry, które mają min.  2 ruchy, takie że
--ostatnie 2 ruchy są takie same oraz każdy ruch jest inny niż "następnik jego następnika"
type family Good_game g1 where
    Good_game Pair_Nil = TypeError (Text "Podany argument nie jest poprawną grą.")
    Good_game (Pair_Cons p Pair_Nil) = TypeError (Text "Podany argument nie jest poprawną grą.")
    Good_game (Pair_Cons p1 (Pair_Cons p1 Pair_Nil)) = True
    Good_game (Pair_Cons p1 (Pair_Cons p2 Pair_Nil)) = TypeError (Text "Podany argument nie jest poprawną grą.")
    Good_game (Pair_Cons p1 (Pair_Cons p (Pair_Cons p1 xs))) = TypeError (Text "Podany argument nie jest poprawną grą.")
    Good_game (Pair_Cons p1 (Pair_Cons p (Pair_Cons p2 xs))) = Good_game (Pair_Cons p (Pair_Cons p2 xs))

data Chess_with_rooks :: (Pair_List a) -> * where
    Board :: (Good_game xs ~ True) => [(a, a)] -> Chess_with_rooks xs

--Zadanie 4

type family OkHeight lmax lmin rmax rmin where
    OkHeight n n n n = True
    OkHeight (Succ n) (Succ n) n n = True
    OkHeight (Succ n) (Succ n) (Succ n) n = True
    OkHeight (Succ n) n n n = True
    OkHeight nmax nmin mmax mmin = TypeError (Text "Niezmiennik nmax >= nmin >= mmax >= mmin >= nmax - 1 złamany.")

--pierwszy parametr to odległość od korzenia do najdalszego lisćia
--drugi to odległość do najbliższego liścia.
data Heap :: Nat -> Nat  -> * -> * where
    Empty :: Heap Zero Zero a
    Heap_leaf :: a -> Heap Zero Zero a
    Un_node :: a -> Heap Zero Zero a -> Heap (Succ Zero) (Succ Zero) a
    Bin_node :: (OkHeight nmax nmin mmax mmin ~ True) => a -> Heap nmax nmin a -> Heap mmax mmin a -> Heap (Succ nmax) (Succ mmin) a

findMin :: Heap nmax nmin a -> a
findMin Empty = error "Empty heap doesn't have minimum"
findMin (Heap_leaf a) = a
findMin (Un_node a _) = a
findMin (Bin_node a _ _) = a

--Zadanie 5

--dodatkowy kind List do reprezentowania listy wierzchołków
data List a = Nil | Cons a (Pair_List a)

--graf to lista wierzchołków i lista krawędzi
data Graph :: (List a) -> (Pair_List a) -> * where
    My_graph :: (Eq a) => [a] -> [(a, a)] -> Graph v e

--graf 3-kolorowalny to 3 listy wierzchołków i lista krawędzi
data Graph3Col :: (List a) -> (List a) -> (List a) -> (Pair_List a) -> * where
    My_graph3col :: Eq a => [a] -> [a] -> [a] -> [(a, a)] -> Graph3Col v1 v2 v3 e

member :: (Eq a) => a -> [a] -> Bool
member x [] = False
member x (y:ys) 
    | x == y = True
    | otherwise = member x ys
--pomocnicza funkcja is_beetween_sets sprawdzająca czy dana krawędź jest pomiędzy dwoma zbiorami wierzchołków
--(tzn. jeden z końców tej krawędzi jest w jednym zbiorze, a drugi w drugim).
is_beetween_sets :: Eq a => (a, a) -> [a] -> [a] -> Bool
is_beetween_sets (v1, v2) vl vr = (member v1 vl && member v2 vr) || (member v1 vr && member v2 vl)
--funkcja colorGraph próbująca zmienić graf w jego 3-kolorowalną reprezentację za pomocą przeszukiwania z nawrotami
colorGraph :: Graph v e -> Maybe (Graph3Col v1 v2 v3 e)
colorGraph (My_graph v e) = try_divide e [] [] [] [] where
    try_divide :: Eq a => [(a,a)] -> [a] -> [a] -> [a] -> [(a, a)] -> Maybe (Graph3Col v1 v2 v3 e) 
    --jeśli nie ma więcej krawędzi to tworzymy graf z tego co mamy
    try_divide [] vfi vse vth e3col = Just $ My_graph3col vfi vse vth e3col
    --w p.p. mamy kilka przypadków
    try_divide ((v1, v2):es) vfi vse vth e3col 
        --oba końce krawędzi są na tej samej liście wierzchołków, wtedy mamy niepowodzenie
        | ((member v1 vfi) && (member v2 vfi)) || ((member v1 vse) && (member v2 vse)) || ((member v1 vth) && (member v2 vth)) = Nothing
        --końce są na różnych listach - wtedy dodajemy krawędź do zbioru krawędzi i wywołujemy się rekurencyjnie
        | ((is_beetween_sets (v1, v2) vfi vse) || (is_beetween_sets (v1, v2) vfi vth) || (is_beetween_sets (v1, v2) vse vth)) = try_divide  es vfi vse vth ((v1, v2):e3col)
        --jeden z końców jest w którymś ze zbiorów - wtedy wykonujemy 2 wywołania rekurecnyjne i sprawdzamy czy któreś zwróciło Just
        | (member v1 vfi) = foldr (\x e -> if (isJust e) then e else x) Nothing [rec2, rec3] 
        | (member v1 vse) = foldr (\x e -> if (isJust e) then e else x) Nothing [rec1, rec3] 
        | (member v1 vth) = foldr (\x e -> if (isJust e) then e else x) Nothing [rec1, rec2] 
        | (member v2 vfi) = foldr (\x e -> if (isJust e) then e else x) Nothing [rec5, rec6] 
        | (member v2 vse) = foldr (\x e -> if (isJust e) then e else x) Nothing [rec4, rec6]
        | (member v2 vth) = foldr (\x e -> if (isJust e) then e else x) Nothing [rec4, rec5]
        --żaden z końców nie jest w żadnym ze zbiorów - analogicznie do wcześniejszych przypadków
        --z tym że wykonujemy 6 wywołań rekurecnyjnych
        | otherwise = foldr (\x e -> if (isJust e) then e else x) Nothing [rec7, rec8, rec9, rec10, rec11, rec12] where
            rec1=(try_divide es (v2:vfi) vse vth ((v1,v2):e3col))
            rec2=(try_divide es vfi (v2:vse) vth ((v1,v2):e3col)) 
            rec3=(try_divide es vfi vse (v2:vth) ((v1,v2):e3col))
            rec4=(try_divide es (v1:vfi) vse vth ((v1,v2):e3col)) 
            rec5=(try_divide es vfi (v1:vse) vth ((v1,v2):e3col)) 
            rec6=(try_divide es vfi vse (v1:vth) ((v1,v2):e3col))
            rec7=(try_divide es (v1:vfi) (v2:vse) vth ((v1,v2):e3col))
            rec8=(try_divide es (v1:vfi) vse (v2:vth) ((v1,v2):e3col))
            rec9=(try_divide es (v2:vfi) (v1:vse) vth ((v1,v2):e3col))
            rec10=(try_divide es vfi (v1:vse) (v2:vth) ((v1,v2):e3col))
            rec11=(try_divide es (v2:vfi) vse (v1:vth) ((v1,v2):e3col))
            rec12=(try_divide es vfi (v2:vse) (v1:vth) ((v1,v2):e3col))