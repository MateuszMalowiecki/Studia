> {-# LANGUAGE ParallelListComp #-}
> {-# LANGUAGE BlockArguments #-}
> --Mateusz Małowiecki 300774
> --kurs języka Haskell
> --lista nr. 2, 12.03.2020

>import Data.List
>import Data.Bool

> --Zad.1
> --Korzystam z tego że:
> --map f xs = [f x | x <- xs]
> --concat xss = [x | xs <-xss, x <- xs]
> --filter p xs = [x | x <- xs, p x] 

>subseqC :: [a] -> [[a]]
>subseqC [] = [[]]
>subseqC (x:xs) = [(x:ys) | ys <- yss] ++ yss where
>    yss = subseqC xs

>ipermC :: [a] -> [[a]]
>ipermC [] =[[]]
>ipermC (x:xs) =  [x1 | xs1 <- [insert ys | ys <- ipermC xs], x1 <- xs1] where
>   insert [] = [[x]]
>   insert ys1@(y:ys) = (x:ys1) : [y:ys2 | ys2 <- insert ys]

>spermC :: [a] -> [[a]]
>spermC [] = [[]]
>spermC xs = [x | xs1 <- [[y:ys1 | ys1 <- spermC ys] | (y, ys) <- select xs] , x <-xs1] where
>    select [y] = [(y,[])]
>    select (y:ys) = (y,ys) : [(z, y:zs) | (z, zs) <- select ys]

>qsortC :: Ord a => [a] -> [a]
>qsortC [] = []
>qsortC (x:xs) = qsortC [c | c <- xs, c <= x] ++ [x] ++ qsortC [c | c <- xs, c > x]

>zipC :: [a] -> [b] -> [(a,b)]
>zipC xs ys = [ (x, y) | x <- xs | y <- ys]

> --Zad.3
>data Combinator = S | K | Combinator :$ Combinator
>infixl :$
 
>instance Show Combinator where
>    show S = "S"
>    show K = "K"
>    --jeżeli wyrażenie z prawej strony jest pojedynczym operatorem, to nie musimy go brać w nawiasy
>    show (c1 :$ S) = show c1 ++ "S"
>    show (c1 :$ K) = show c1 ++ "K"
>    --w przeciwnym wypadku wyrażenie z prawej zawiera więcej niż jeden operator
>    --i musimy je wziąć w nawiasy
>    show (c1 :$ c2) = show c1 ++ "(" ++ show c2 ++ ")"
> --Zad.4
>evalC :: Combinator -> Combinator
>evalC S = S
>evalC K = K
>evalC (K :$ x :$ _) = evalC x
>evalC (S :$ x :$ y :$ z) = evalC $ (evalC x) :$ (evalC z) :$ (evalC (y :$ z))
>evalC (c1 :$ c2) = (evalC c1) :$ (evalC c2)
> --Zad.5
>data BST a = NodeBST (BST a) a (BST a) | EmptyBST

>searchBST :: Ord a => a -> BST a -> Maybe a
>searchBST _ EmptyBST = Nothing
>searchBST a (NodeBST l v r) 
>    | (a == v) = Just v
>    | (a < v) = searchBST a l
>    | otherwise = searchBST a r

>insertBST :: Ord a => a -> BST a -> BST a
>insertBST a EmptyBST = NodeBST EmptyBST a EmptyBST
>insertBST a t@(NodeBST l v r) 
>    | (a == v) = t
>    | (a < v) = NodeBST (insertBST a l) v r
>    | otherwise = NodeBST l v (insertBST a r)

> --Zad.6
>deleteMaxBST :: Ord a => BST a -> (BST a, a)
>deleteMaxBST EmptyBST = error "Extracting element from empty tree"
>deleteMaxBST (NodeBST l v EmptyBST) = (l, v)
>deleteMaxBST (NodeBST l v r) = (NodeBST l v t, max) where
>    (t, max) = deleteMaxBST r

>deleteBST :: Ord a => a -> BST a -> BST a
>deleteBST _ EmptyBST = EmptyBST
>deleteBST a t@(NodeBST l v EmptyBST) 
>    | (a == v) = l
>    | (a < v) = NodeBST (deleteBST a l) v EmptyBST
>    | otherwise = t
>deleteBST a t@(NodeBST EmptyBST v r) 
>    | (a == v) = r
>    | (a < v) = t
>    | otherwise = NodeBST EmptyBST v (deleteBST a r)
>deleteBST a (NodeBST l v r) 
>    | (a == v) = NodeBST t1 max r 
>    | (a < v) = NodeBST (deleteBST a l) v r
>    | otherwise = NodeBST l v (deleteBST a r) where
>        (t1, max) = deleteMaxBST l

> --Zad.7
>data Tree23 a = Node2 (Tree23 a) a (Tree23 a)
>    | Node3 (Tree23 a) a (Tree23 a) a (Tree23 a)
>    | Empty23

>search23 :: Ord a => a -> Tree23 a -> Maybe a
>search23 a (Empty23) = Nothing
>search23 a (Node2 t1 v t2) 
>    | (a == v) = Just v
>    | (a < v) = search23 a t1
>    | otherwise = search23 a t2
>search23 a (Node3 t1 v1 t2 v2 t3)
>    | (a == v1) = Just v1
>    | (a == v2) = Just v2    
>    | (a < v1) = search23 a t1
>    | (a > v2) = search23 a t3
>    | otherwise = search23 a t2

> --Zad.8
>data InsResult a = BalancedIns (Tree23 a) | Grown (Tree23 a) a (Tree23 a)

>ins :: Ord a => a -> Tree23 a -> InsResult a
>ins a Empty23 = Grown Empty23 a Empty23
>ins a (Node2 Empty23 v Empty23)
>    | a < v    = BalancedIns (Node3 Empty23 a Empty23 v Empty23)
>    | a == v   = BalancedIns (Node2 Empty23 a Empty23)
>    | otherwise = BalancedIns (Node3 Empty23 v Empty23 a Empty23)
> --Wstawianie do drzewa dwuelementowego to "rozbicie" korzenia na dwa poddrzewa.
> --Korzeń i poddrzewa trzymają po jednej wartości
>ins a (Node3 Empty23 v1 Empty23 v2 Empty23)
>    | a < v1 = Grown (Node2 Empty23 a Empty23) v1 (Node2 Empty23 v2 Empty23)
>    | a == v1 = BalancedIns (Node3 Empty23 a Empty23 v2 Empty23)
>    | v1 < a && a < v2 = Grown (Node2 Empty23 v1 Empty23) a (Node2 Empty23 v2 Empty23)
>    | a == v2 = BalancedIns (Node3 Empty23 v1 Empty23 a Empty23)
>    | otherwise = Grown (Node2 Empty23 v1 Empty23) v2 (Node2 Empty23 a Empty23)
> --Wstawiając do drzewa n-elementowego (n >= 3) wywołujemy się rekurencyjnie (o ile a != v),
> --po czym albo podczepiamy poddrzewo po wstawieniu pod korzeń (o ile jego wysokość się nie zwiększyła)
> --albo wykonujemy rotacje z rysunku nr.1 z listy zadań.  
>ins a (Node2 l v r)
>    | a < v    = case ins a l of
>        BalancedIns newL -> BalancedIns (Node2 newL v r)
>        Grown newL v' newR -> BalancedIns (Node3 newL v' newR v r)
>    | a == v = BalancedIns (Node2 l a r)
>    | otherwise = case ins a r of
>        BalancedIns newR -> BalancedIns (Node2 l v newR)
>        Grown newL v' newR -> BalancedIns (Node3 l v newL v' newR)
>ins a (Node3 l v1 m v2 r)
>    | a < v1 = case ins a l of
>          BalancedIns newL -> BalancedIns (Node3 newL v1 m v2 r)
>          Grown newL x newR -> Grown (Node2 newL x newR) v1 (Node2 m v2 r)
>    | a == v1 = BalancedIns (Node3 l a m v2 r)
>    | v1 < a && a < v2 = case ins a m of
>          BalancedIns newM -> BalancedIns (Node3 l v1 newM v2 r)
>          Grown newL x newR -> Grown (Node2 l v1 newL) x (Node2 newR v2 r)
>    | a == v2 = BalancedIns (Node3 l v1 m a r)
>    | otherwise = case ins a r of
>          BalancedIns newR -> BalancedIns (Node3 l v1 m v2 newR)
>          Grown newL x newR -> Grown (Node2 l v1 m) v2 (Node2 newL x newR)

>insert23 :: Ord a => a -> Tree23 a -> Tree23 a
>insert23 a t = case ins a t of
>    BalancedIns t1 -> t1
>    Grown l1 v r1 -> Node2 l1 v r1	

> --Zad.9
>data DelResult a = BalancedDel (Tree23 a) | Shrinked (Tree23 a)

>delMax :: Tree23 a -> (DelResult a, a)
>delMax Empty23 = error "deleting element from empty tree"
>delMax (Node2 Empty23 v Empty23) = (Shrinked Empty23, v)
>delMax (Node3 Empty23 v1 Empty23 v2 Empty23) = (BalancedDel (Node2 Empty23 v1 Empty23), v2) 
> --usuwanie maksimum z drzewa o n elementach (n >= 3) wykonujemy wywołując się rekurencyjnie na prawym poddrzewie
> --a następnie podczepiając prawe poddrzewo pod korzeń (o ile jego wysokość się nie zmniejszyła)
> --lub wykonując rotacje z rysunku nr.2 z listy zadań, w przypadku zmniejszenia wysokości prawego poddrzewa. 
>delMax (Node2 l v r) = case delMax r of
>    (BalancedDel r1, max) -> (BalancedDel (Node2 l v r1), max)
>    (Shrinked r1, max) -> case l of
>        (Node2 ll lv lr) -> (Shrinked (Node3 ll lv lr v r1), max)
>        (Node3 ll lv1 lm lv2 lr) -> (BalancedDel (Node2 (Node2 ll lv1 lm) lv2 (Node2 lr v r1)), max)
>delMax (Node3 l v1 m v2 r) = case delMax r of
>    (BalancedDel r1, max) -> (BalancedDel (Node3 l v1 m v2 r1), max)
>    (Shrinked r1, max) -> case m of
>       (Node2 ml mv mr) -> (BalancedDel (Node2 l v1 (Node3 ml mv mr v2 r1)), max)
>       (Node3 ml mv1 mm mv2 mr) -> (BalancedDel (Node3 l v1 (Node2 ml mv1 mm) mv2 (Node2 mr v2 r1)), max)

>del :: Ord a => a -> Tree23 a -> DelResult a
>del _ Empty23 = BalancedDel Empty23
>del a t@(Node2 Empty23 v Empty23) 
>    | (a == v) = Shrinked Empty23
>    | otherwise = BalancedDel t
>del a t@(Node3 Empty23 v1 Empty23 v2 Empty23)
>    | a == v1 = BalancedDel (Node2 Empty23 v2 Empty23)
>    | a == v2 = BalancedDel (Node2 Empty23 v1 Empty23)
>    | otherwise = BalancedDel t
> --usuwanie elementu z drzew o n elementach (n>=3), rozpatruje następujące 2 przypadki:
> --1. a nie jest równe żadnej wartości w korzeniu - wtedy wywołujemy się rekurencyjnie na poddrzewie
> --i w zależności czy wysokość poddrzewa się zmniejszyła, podczepiamy je pod korzeń lub wykonujemy rotacje 
> --2. a jest równe jednej z wartości korzenia (powiedzmy v) - wtedy szukamy maksimum w poddrzewie będącym na lewo od v,
> --a następnie je usuwamy procedurą delMax i umieszczamy w korzeniu na miejscu v i przywracamy niezmienniki.
>del a (Node2 l v r) 
>    | a < v = case del a l of
>        BalancedDel l1 -> BalancedDel (Node2 l1 v r)
>        Shrinked l1 -> case r of
>            Node2 rl rv rr -> Shrinked (Node3 l1 v rl rv rr)
>            Node3 rl rv1 rm rv2 rr -> BalancedDel (Node2 (Node2 l1 v rl) rv1 (Node2 rm rv2 rr))
>    | a == v = case delMax l of
>        (BalancedDel l1, max) -> BalancedDel (Node2 l1 max r)
>        (Shrinked l1, max) -> case r of
>            Node2 rl rv rr -> Shrinked (Node3 l1 max rl rv rr)
>            Node3 rl rv1 rm rv2 rr -> BalancedDel (Node2 (Node2 l1 max rl) rv1 (Node2 rm rv2 rr))
>    | a > v = case del a r of
>        BalancedDel r1 -> BalancedDel (Node2 l v r1)
>        Shrinked r1 -> case l of
>            Node2 ll lv lr -> Shrinked (Node3 ll lv lr v r)
>            Node3 ll lv1 lm lv2 lr -> BalancedDel (Node2 (Node2 ll lv1 lm) lv2 (Node2 lr v r1))
>del a (Node3 l v1 m v2 r)
>    | a < v1 = case del a l of
>        BalancedDel l1 -> BalancedDel (Node3 l1 v1 m v2 r)
>        Shrinked l1 -> case m of
>            Node2 ml mv mr -> BalancedDel (Node2 (Node3 l1 v1 ml mv mr) v2 r) 
>            Node3 ml mv1 mm mv2 mr -> BalancedDel (Node3 (Node2 l1 v1 ml) mv1 (Node2 mm mv2 mr) v2 r) 
>    | a == v1 = case delMax l of
>        (BalancedDel l1, max) -> BalancedDel (Node3 l1 max m v2 r)
>        (Shrinked l1, max) -> case m of
>            Node2 ml mv mr -> BalancedDel (Node2 (Node3 l1 max ml mv mr) v2 r) 
>            Node3 ml mv1 mm mv2 mr -> BalancedDel (Node3 (Node2 l1 max ml) mv1 (Node2 mm mv2 mr) v2 r)
>    | a > v1 && a < v2 = case del a m of
>        BalancedDel m1 -> BalancedDel (Node3 l v1 m1 v2 r)
>        Shrinked m1 -> case l of
>            Node2 ll lv lr -> BalancedDel (Node2 (Node3 ll lv lr v1 m1) v2 r)
>            Node3 ll lv1 lm lv2 lr -> BalancedDel (Node3 (Node2 ll lv1 lm) lv2 (Node2 lr v1 m1) v2 r)
>    | a == v2 = case delMax m of
>        (BalancedDel m1, max) -> BalancedDel (Node3 l v1 m1 max r)
>        (Shrinked m1, max) -> case l of
>            Node2 ll lv lr -> BalancedDel (Node2 (Node3 ll lv lr v1 m1) max r)
>            Node3 ll lv1 lm lv2 lr -> BalancedDel (Node3 (Node2 ll lv1 lm) lv2 (Node2 lr v1 m1) max r)
>    | a > v2 = case del a r of
>        BalancedDel r1 -> BalancedDel (Node3 l v1 m v2 r1)
>        Shrinked r1 -> case m of
>            Node2 ml mv mr -> BalancedDel (Node2 l v1 (Node3 ml mv mr v2 r1))
>            Node3 ml mv1 mm mv2 mr -> BalancedDel (Node3 l v1 (Node2 ml mv1 mm) mv2 (Node2 mr v2 r1))

>deleteMax23 :: Tree23 a -> (Tree23 a, a)
>deleteMax23 t = case delMax t of
>    (BalancedDel t1, max) -> (t1, max)
>    (Shrinked t1, max) -> (t1, max)

>delete23 :: Ord a => a -> Tree23 a -> Tree23 a
>delete23 a t = case del a t of
>    BalancedDel t1 -> t1
>    Shrinked t1 -> t1

> --Zad.10
>data Tree234 a = N2 (Tree234 a) a (Tree234 a)
>    | N3 (Tree234 a) a (Tree234 a) a (Tree234 a)
>    | N4 (Tree234 a) a (Tree234 a) a (Tree234 a) a (Tree234 a)
>    | E234
>data RBTree a = Black (RBTree a) a (RBTree a)
>    | Red (RBTree a) a (RBTree a)
>    | RBTEmpty

> --konwersje wzięte ze strony https://azrael.digipen.edu/~mmead/www/Courses/CS280/Trees-Mapping2-3-4IntoRB.html
>from234 :: Tree234 a -> RBTree a
>from234 E234 = RBTEmpty
>from234 (N2 t1 v t2) = Black (from234 t1) v (from234 t2)
>from234 (N3 t1 v1 t2 v2 t3) = Black (Red (from234 t1) v1 (from234 t2)) v2 (from234 t3)
>from234 (N4 t1 v1 t2 v2 t3 v3 t4) = Black (Red (from234 t1) v1 (from234 t2)) v2 (Red (from234 t3) v3 (from234 t4))

>to234 :: RBTree a -> Tree234 a
>to234 RBTEmpty = E234
>to234 (Black (Red l1 v1 r1) v (Red l2 v2 r2)) = (N4 (to234 l1) v1 (to234 r1) v (to234 l2) v2 (to234 r2)) 
>to234 (Black (Red l1 v1 r1) v t1) = (N3 (to234 l1) v1 (to234 r1) v (to234 t1))
>to234 (Black t1 v (Red l1 v1 r1)) = (N3 (to234 t1) v (to234 l1) v1 (to234 r1))
>to234 (Black t1 v t2) = (N2 (to234 t1) v (to234 t2))
>to234 _ = error "Given tree don't match red-black tree properties."

>main :: IO ()
>main = return ()