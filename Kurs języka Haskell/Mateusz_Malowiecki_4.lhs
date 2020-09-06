> {-# LANGUAGE ViewPatterns #-}
> {-# LANGUAGE FlexibleContexts #-}
> --Mateusz Małowiecki 300774
> --kurs języka Haskell
> --lista nr. 4, 03.04.2020
>data BTree a = BNode (BTree a) a (BTree a) | BLeaf
> --Zad.1
>badflatten :: BTree a -> [a]
>badflatten BLeaf = []
>badflatten (BNode l x r) = flatten l ++ [x] ++ flatten r

>badqsort :: Ord a => [a] -> [a]
>badqsort [] = []
>badqsort (x:xs) = qsort [y | y <- xs, y < x] ++ [x] ++ qsort [y | y <- xs, y >= x]

>flatten :: BTree a -> [a]
>flatten = flatten_aux [] where
>    flatten_aux :: [a] -> BTree a -> [a]
>    flatten_aux a BLeaf = a
>    flatten_aux a (BNode l v r) = flatten_aux (v : flatten_aux a r) l

>qsort :: Ord a => [a] -> [a]
>qsort = qsort_aux [] where
>    qsort_aux :: Ord a => [a] -> [a] -> [a]
>    qsort_aux a [] = a
>    qsort_aux a (x:xs) = qsort_aux (x : qsort_aux a [y | y <- xs, y >= x]) [y | y <- xs, y < x]

> --Zad.2
>queens :: Int -> [[Int]]
>queens n =queensaux 1 where
>    queensaux k
>        |(k == n+1) = [[]]
>        | otherwise = [q:qs | qs <- queensaux (k + 1), q <- [1 .. n], canplace k q (k+1) qs] where
>            --canplace sprawdza czy nowy hetman nie atatkuje żadnego już postawionego 
>            canplace :: Int -> Int -> Int -> [Int] -> Bool
>            canplace _ _ _ [] = True
>            canplace c1 r1 c2 (r2:qs) = check_if_ok c1 r1 c2 r2 && canplace c1 r1 (c2+1) qs 
>            --check_if_ok sprawdza czy dane 2 hetmany nie atakują się nawzajem
>            check_if_ok :: Int -> Int -> Int -> Int -> Bool
>            check_if_ok c1 r1 c2 r2 = c1 /= c2 && r1 /= r2 && abs(c1 - c2) /= abs(r1 - r2)

> --Zad.3
>data BinTree = BinTree :/\: BinTree | BinTreeLeaf

>binTree :: Int -> BinTree
>binTree n 
>    --jeżeli n jest parzyste to wywołujemy funkcję binTreepair, która nie utworzy zbędnego drzewa
>    | n `mod` 2 == 0 = t1 :/\: t2 
>    --jeżeli n jest parzyste to nie wywołujemy funkcji binTreepair, bo utworzyłaby ona zbędne drzewo
>    --w takim przypadku wywołujemy funkcję binTree z parametrem (n `div` 2)
>    | otherwise = t :/\: t where
>        t = binTree (n `div` 2)
>        (t1, t2) = binTreepair ((n - 1) `div` 2)
>    -- funkcja binTreepair zwraca parę (drzewo n-wierzchołkowe, drzewo (n+1)-wierzchołkowe) 
>        binTreepair 0 =(BinTreeLeaf, BinTreeLeaf :/\: BinTreeLeaf)
>        binTreepair n 
>            | n `mod` 2 == 0 = (smaller :/\: bigger, bigger :/\: bigger)
>            | otherwise = (smaller :/\: smaller, smaller :/\: bigger) where 
>                (smaller, bigger) = binTreepair ((n - 1) `div` 2)

> --Zad.4
>binTreeLeaves :: Int -> BinTree
> --wywołujemy funkcję btl z argumentem (n - 1) ponieważ akumulator zawiera już jeden liść. 
>binTreeLeaves n = btl BinTreeLeaf BinTreeLeaf (n - 1) where
>    btl :: BinTree -> BinTree -> Int -> BinTree 
>    --Pierwszy argument btl to pełne drzewo o odpowiedniej wysokości, drugi argument to akumulator
>    btl _ acc 0 = acc
>    btl t acc n 
>        | (n `mod` 2 == 0) = btl t1 acc (n `div` 2)
>        | otherwise = btl t1 (t :/\: acc) (n `div` 2) where t1=(t :/\: t)

> --Zad.5
>class Queue q where
>    emptyQ :: q a
>    isEmptyQ :: q a -> Bool
>    put :: a -> q a -> q a
>    get :: q a -> (a, q a)
>    get q = (top q, pop q)
>    top :: q a -> a
>    top = fst . get
>    pop :: q a -> q a
>    pop = snd . get

>data SimpleQueue a = SimpleQueue { front :: [a], rear :: [a] }

>instance Queue SimpleQueue where
>   emptyQ = SimpleQueue [] []
>   isEmptyQ (SimpleQueue f r) = (null f) && (null r)
>   put a (SimpleQueue f r) = SimpleQueue f (a:r)
>   get (SimpleQueue [] []) = error "Can't get element from empty queue"
>   --naruszenie niezmiennika
>   get (SimpleQueue [] r) = error "Front is empty, but rear is not"
>   --przywracanie niezmiennika 
>   get (SimpleQueue (f1:[]) r) = (f1, SimpleQueue (reverse r) []) where
>       reverse = rev [] where
>           rev a [] = a
>           rev a (x:xs) = rev (x:a) xs
>   get (SimpleQueue (f1 : f) r) = (f1, SimpleQueue f r)

> --Zad.6
>primes :: [Integer]
> --przechodzimy po q <= sqrt(p)
>primes = 2:[ p | p <- [3..], and [ p `mod` q /= 0 | q <- [2..(floor . sqrt . fromInteger) p]]]

> --Zad.7
>fib :: [Integer]
>fib = 1:1:zipWith (+) fib (tail fib)
 
> --Zad.8
>(<+>) :: Ord a => [a] -> [a] -> [a]
>xs <+> [] = xs
>[] <+> xs = xs
>xs1@(x:xs) <+> ys1@(y:ys)
>    | x < y = x : (xs <+> ys1)
>    | x > y = y : (xs1 <+> ys)
> 	 | otherwise = x : (xs <+> ys)
>d235 :: [Integer]
>d235 = 1:([2*n | n <-d235] <+> [3*n | n <-d235] <+> [5*n | n <-d235])

> --Zad.9
>infTree :: BTree Int
>infTree = tree 1 where
>    tree n = BNode (tree (2 * n)) n (tree (2 * n + 1))

> --Zad.10
>data RoseTree a = RNode a [RoseTree a]
>infbTree :: BTree Int
>infbTree = tree where
>    tree=BNode tree 1 tree
> --Zakładam że to drzewo również ma etykietę 1 we wszystkich wierzchołkach
>infrTree :: RoseTree Int
>infrTree = tree where
>    tree=RNode 1 xs
>    xs = tree:xs	

> --Zad.11
>showFragList :: Show a => Int -> [a] -> String
>showFragList i xs = "[" ++ showlist i xs where
>    showlist _ [] = "]"
>    showlist 0 _ = "...]"
>    showlist i (x:xs) = show x ++ "," ++ showlist (i - 1) xs
>data Bintree t a = Node (t a) a (t a) | Leaf
>class BT t where
>    toTree :: t a -> Bintree t a
>showFragTree :: (BT t, Show a) => Int -> t a -> String
>showFragTree _ (toTree -> Leaf) = "-"
>showFragTree 0 _ = "..."
>showFragTree i (toTree -> Node (toTree -> Leaf) v (toTree -> Leaf)) = "- " ++ show v ++ " -"
>showFragTree i (toTree -> Node (toTree -> Leaf) v r) = "- " ++ show v ++ " (" ++ showFragTree (i - 1) r ++ ")"
>showFragTree i (toTree -> Node l v (toTree -> Leaf)) = "(" ++ showFragTree (i - 1) l ++ ") " ++ show v ++ " -"
>showFragTree i (toTree -> Node l v r) = "( " ++ showFragTree (i - 1) l ++ ") " ++ show v ++ " (" ++ showFragTree (i - 1) r ++ ")"
>instance Show a => Show (RoseTree a) where
>    show (RNode i xs) = show i ++ concatMap show xs
>showFragRose :: Show a => Int -> RoseTree a -> String
>showFragRose i (RNode a xs) = show a  ++ showFragList i xs

> --Zad.12(bez fromlist)
>data Cyclist a = Elem (Cyclist a) a (Cyclist a)
>forward :: Cyclist a -> Cyclist a
>forward (Elem _ _ n) = n
>backward :: Cyclist a -> Cyclist a
>backward (Elem p _ _) = p
>label :: Cyclist a -> a
>label (Elem _ a _) = a