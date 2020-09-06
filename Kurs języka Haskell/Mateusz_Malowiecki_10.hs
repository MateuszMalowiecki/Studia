--Mateusz Małowiecki 300774
--Kurs języka Haskell
--Lista nr.10, 26.05.2020 
{-#LANGUAGE ExistentialQuantification#-}
{-#LANGUAGE DeriveFunctor#-}
{-#LANGUAGE DeriveGeneric #-}

import GHC.Generics (Generic)
import Test.QuickCheck
import Generic.Random
import Generic.Random.Internal.Generic

--Zadanie 1
data Tree = Leaf | Single Tree | Double Tree Tree
data Spec = MinNodes Int -- co najmniej n konstruktorow
    | MaxNodes Int -- co najwyzej n konstruktorow
    | MinDepth Int -- glebokosc co najmniej n
    | MaxDepth Int -- glebokosc co najwyzej n
    | MinPaths Int -- co najmniej n sciezek
    | MaxPaths Int -- co najwyzej n sciezek

--wyświetlanie drzew
instance Show Tree where
    show Leaf = "Leaf"
    show (Single Leaf) = "Single Leaf"
    show (Single t) = "Single (" ++ show t ++ ")"
    show (Double Leaf Leaf) = "Double Leaf Leaf"
    show (Double t Leaf) = "Double (" ++ show t ++ ") Leaf"
    show (Double Leaf t) = "Double Leaf (" ++ show t ++ ")"
    show (Double t1 t2) = "Double (" ++ show t1 ++ ") (" ++ show t2 ++ ")"

--generator wszystkich drzew
gen_all_trees :: [Tree]
gen_all_trees = [t | i <- [1..], t <- trees_of_i_nodes i ] where
    trees_of_i_nodes 1 = [Leaf]
    trees_of_i_nodes i = double_trees i ++ single_trees i
    double_trees i =[Double t1 t2 | j <- [1..i - 2], t1 <- trees_of_i_nodes j, t2 <- trees_of_i_nodes (i - 1 - j)]
    single_trees i =[Single t | t <- trees_of_i_nodes (i - 1)]

--liczba konstruktorów w drzewie
nodes :: Tree -> Int
nodes Leaf = 1
nodes (Single t) = (nodes t) + 1
nodes (Double t1 t2) = (nodes t1) + (nodes t2) + 1

--głębokość drzewa
depth :: Tree -> Int
depth Leaf = 0
depth (Single t) = 1 + depth t
depth (Double t1 t2) = 1 + max (depth t1) (depth t2) 

--liczba ścieżek w drzewie
paths :: Tree -> Int
paths Leaf = 0
paths (Single t) = paths t + nodes t
paths (Double t1 t2) = paths t1 + paths t2 + (nodes t1)*(nodes t2) + nodes t1 + nodes t2

genTree :: [Spec] -> [Tree]
genTree [] = gen_all_trees
genTree (s:ss) = let generated = genTree ss in
    case s of
        MaxNodes n -> takeWhile (\t -> (nodes t) <= n) generated
        MinNodes n -> filter (\t -> (nodes t) >= n) generated
        MaxDepth n -> takeWhile (\t -> (depth t) <= n) generated
        MinDepth n -> filter (\t -> (depth t) >= n) generated
        MaxPaths n -> takeWhile (\t -> (paths t) <= n) generated
        MinPaths n -> filter (\t -> (paths t) >= n) generated
--Zadanie 2
--rozwiązanie Zadania 3 ze SKOS'a
data UF s = UF {
   ids :: STUArray s Int Int,
   ranks :: STUArray s Int Int
}
ufCreate :: Int -> ST s (UF s)
ufCreate n = do
   ids <- newListArray (0, n-1) [0..n-1]
   ranks <- newArray (0, n-1) 0
   return $ UF ids ranks
ufFind :: UF s -> Int -> ST s Int
ufFind uf id = do
   (min, max) <- getBounds (ids uf)
   unless (id >= min && id <= max) $ error "UF: Invalid index"
   parent <- readArray (ids uf) id
   root <- if parent /= id then ufFind uf parent
           else return parent
   writeArray (ids uf) id root
   return root
ufUnion :: UF s -> Int -> Int -> ST s ()
ufUnion uf id1 id2 = do
   (min, max) <- getBounds (ids uf)
   unless (id1 >= min && id1 <= max) $ error "UF: Invalid first index"
   unless (id2 >= min && id2 <= max) $ error "UF: Invalid second index"
   root1 <- ufFind uf id1
   root2 <- ufFind uf id2
   unless (root1 /= root2) $ return ()
   rank1 <- readArray (ranks uf) root1
   rank2 <- readArray (ranks uf) root2
   when (rank1 == rank2) $ writeArray (ranks uf) root1 (rank1 + 1)
   if rank1 >= rank2
      then writeArray (ids uf) root2 root1
      else writeArray (ids uf) root1 root2
type Edge = (Int, Float, Int)
data Graph = Graph Int [Edge] deriving (Show, Generic)
-- Założenia: graf ma wierzchołki o indentyfikatorach 0-n (pierwszy element konstruktora)
--            dla krawędzi (v, x, u) zachodzi v <= u
--            istnieje tylko jeden element dla krawędzi v <-> u postaci (v, x, u)
graphCreate :: [Edge] -> Graph
graphCreate edges = Graph size newEdges
   where size = maximum . map (\(v, _ , w) -> max v w) $ edges
         newEdges = map (\e@(v, x, w) -> if v >= w then (w, x, v) else e) edges
kruskalSpanning :: Graph -> Graph
kruskalSpanning (Graph size edges) = graphCreate $ runST $ do
       uf <- ufCreate (size + 1)
       edgesMut <- newSTRef []
       forM_ sortedEdges $ \e@(v, x, w) -> do
           rv <- ufFind uf v
           rw <- ufFind uf w
           when (rv /= rw) $ ufUnion uf v w >> modifySTRef edgesMut (e:)
       readSTRef edgesMut
   where sortedEdges = sortBy (\(_, x, _) (_, y, _) -> x `compare` y) edges
--Rozwiązanie zadania 4 ze SKOS'a
data UFFun = UFFun [Int] [Int]
uffunCreate :: Int -> UFFun
uffunCreate n = UFFun [0..n-1] (replicate n 0)
actOnElement :: [a] -> Int -> (a -> a) -> [a]
actOnElement l n f = h ++ (f . head $ t) : tail t
   where (h, t) = splitAt n l
uffunFind :: UFFun -> Int -> (Int, UFFun)
uffunFind uf@(UFFun ids ranks) id
   | id < 0 || id >= len = error "UFFun: Invalid index"
   | otherwise = if parent == id then (id, uf)
                 else (root, UFFun (actOnElement newIds id (const root)) newRanks)
   where len = length ids
         parent = ids !! id
         (root, newUF) = uffunFind uf parent
         (UFFun newIds newRanks) = newUF
uffunUnion :: UFFun -> Int -> Int -> UFFun
uffunUnion uf@(UFFun ids _) id1 id2
   | id1 < 0 || id1 >= len = error "UFFun: Invalid first index"
   | id2 < 0 || id2 >= len = error "UFFun: Invalid second index"
   | otherwise = if root1 == root2 then uf2
                 else UFFun newIDs newRanks
   where len = length ids
         (root1, uf1) = uffunFind uf id1
         (root2, uf2) = uffunFind uf1 id2
         (UFFun ids' ranks') = uf2
         rank1 = ranks' !! id1
         rank2 = ranks' !! id2
         newRanks = if rank1 == rank2
                       then actOnElement ranks' id1 (+1)
                       else ranks'
         newIDs = if rank1 >= rank2
                     then actOnElement ids root2 (const root1)
                     else actOnElement ids root1 (const root2)
kruskalSpanningFun :: Graph -> Graph
kruskalSpanningFun (Graph size edges) = graphCreate newEdges
   where uf = uffunCreate (size + 1)
         sortedEdges = sortBy (\(_, x, _) (_, y, _) -> x `compare` y) edges
         (newEdges, _) = foldl (\(edges, uf) e@(v, x, w) ->
             let (rv, uf1) = uffunFind uf v in
             let (rw, uf2) = uffunFind uf1 w in
             if rv /= rw
                then (e:edges, uffunUnion uf2 v w)
                else (edges, uf2)) ([], uf) sortedEdges
gen_i_vert_graph :: Arbitrary a => Int -> Gen (Graph)
gen_i_vert_graph i = Graph i $ generateEdges num_of_edges where
    num_of_edges = arbitrary :: Int
    generateEdges 0 = []
    generateEdges i = (arbitrary, arbitrary, arbitrary):(generateEdges (i-1))
genericArbitrary :: Arbitrary a => {-Weights Graph-} Int -> Int -> Int -> Gen Graph
genericArbitrary {-(x % y % ())-} x y i =
  frequency
    [ (x, gen_i_vert_graph i)
    , (y, genericArbitrary (x % y % ()) (i+1))
    ]
instance Arbitrary (Graph) where
   arbitrary = genericArbitrary {-(5 % 15 % ())-} 5 15 1
--Zadanie 3
data Queue a = Queue { front :: [a], rear :: [a] }
empty :: Queue a
empty = Queue [] []
pushBack :: a -> Queue a -> Queue a
pushBack x (Queue [] []) = Queue [x] []
pushBack x (Queue f r) = Queue f (x:r)
popFront :: Queue a -> Queue a
popFront (Queue [] []) = error "Extracting elem from empty queue"
popFront (Queue [] r) = error "Invariant broken"
popFront (Queue (a:[]) r) = Queue (reverse r) []
popFront (Queue (a:f) r) = (Queue f r)
peek :: Queue a -> a
peek (Queue [] []) = error "Peeking elem from empty queue"
peek (Queue [] r) = error "Invariant broken"
peek (Queue (a:f) r) = a
isEmpty :: Queue a -> Bool
isEmpty (Queue [] []) = True
isEmpty _ = False

is_invariant_good (Queue [] (_:_)) = False
is_invariant_good _ =True
--konwertery między kolejką i listą
list_to_q xs = Queue xs []
q_to_list (Queue f r) = f ++ (reverse r)

--Nieefektywna wersja kolejki, tylko z jedną listą
data Inefficient_Queue a = In_q [a]

iqempty :: Inefficient_Queue a
iqempty = In_q []
iqpushBack :: a -> Inefficient_Queue a -> Inefficient_Queue a
iqpushBack x (In_q xs) = In_q $ x : xs
iqpopFront :: Inefficient_Queue a -> Inefficient_Queue a
iqpopFront (In_q []) = error "Extracting elem from empty queue"
iqpopFront (In_q xs) = In_q $ init xs
iqpeek :: Inefficient_Queue a -> a
iqpeek (In_q []) = error "Peeking elem from empty queue"
iqpeek (In_q xs) = last xs
iqisEmpty :: Inefficient_Queue a -> Bool
iqisEmpty (In_q []) = True
iqisEmpty _ = False

--Konwertery
list_to_iq xs = In_q (reverse xs)
iq_to_list (In_q xs) = reverse xs

--instalacje kolejki w klasach dla QuickCheck'a
instance Arbitrary a => Arbitrary (Queue a) where
   arbitrary = sized $ \n -> do
       k <- choose(0, n)
       fmap (\xs -> Queue xs []) $ sequence [arbitrary | _ <- [1..k]]
instance Show a => Show (Queue a) where
   show = show . q_to_list

--Testy porównujące obie implementacje 
test1 :: [Int] -> Bool
test1 xs = (q_to_list . pushBack 42 . pushBack 41 . list_to_q) xs == (iq_to_list . iqpushBack 42 . iqpushBack 41 . list_to_iq) xs

test2 :: [Int] -> Bool
test2 xs = (peek . pushBack 75 . list_to_q) xs == (iqpeek . iqpushBack 75 . list_to_iq) xs

test3 :: [Int] -> Bool
test3 xs = (q_to_list . popFront . pushBack 79 . list_to_q) xs == (iq_to_list . iqpopFront . iqpushBack 79 . list_to_iq) xs

test4 :: [Int] -> Bool
test4 xs = (peek . pushBack 452 . popFront . pushBack 42 . list_to_q) xs == (iqpeek . iqpushBack 452 . iqpopFront . iqpushBack 42 . list_to_iq) xs

--Testy sprawdzające niezmiennik
test_invariant1 :: (Queue Int) -> Bool
test_invariant1 q = (is_invariant_good . pushBack 42 . pushBack 41) q

test_invariant2 :: (Queue Int) -> Bool
test_invariant2 q = (is_invariant_good . popFront . pushBack 79) q

test_invariant3 :: (Queue Int) -> Bool
test_invariant3 q = (is_invariant_good . popFront . pushBack 452 . popFront . pushBack 42) q

--Zadanie 5
data CoYoneda f a = forall b. CoYoneda (b -> a) (f b)

toCoYoneda :: f a -> CoYoneda f a
toCoYoneda x = CoYoneda id x

fromCoYoneda :: (Functor f) => CoYoneda f a -> f a
fromCoYoneda (CoYoneda f x) = fmap f x

instance Functor f => Functor (CoYoneda f) where
    fmap f (CoYoneda cf x) = CoYoneda (f . cf) x
--fromCoYoneda . toCoYoneda == id:
--Weźmy dow. x typu f a. Pokażemy że (fromCoYoneda . toCoYoneda) x == x. 
--Z definicji (fromCoYoneda . toCoYoneda) x == fromCoYoneda (toCoYoneda x) ==
-- == fromCoYoneda (CoYoneda id x) == fmap id x == x, co kończy dowód że (fromCoYoneda . toCoYoneda) x == x.

--Zadanie 7
data Free f a = Node (f (Free f a)) | Var a deriving (Functor)

sumFree :: (Functor f, Foldable f) => Free f Int -> Int
sumFree (Var n) = n
sumFree (Node s) = foldr (+) 0 $ fmap sumFree s
instance (Foldable f) => (Foldable (CoYoneda f)) where
    foldMap f (CoYoneda cf x) = foldMap (f . cf) x