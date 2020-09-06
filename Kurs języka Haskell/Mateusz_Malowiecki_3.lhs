> {-# LANGUAGE ViewPatterns #-}
> {-# LANGUAGE FlexibleInstances #-}
> {-# LANGUAGE UndecidableInstances #-}
> --Mateusz Małowiecki 300774
> --kurs języka Haskell
> --lista nr. 3, 19.03.2020
>data BTree t a = Node (t a) a (t a) | Leaf

>class BT t where
>    toTree :: t a -> BTree t a

>data UTree a = UNode (UTree a) a (UTree a) | ULeaf

> --Zad.1

>treeSize :: BT t => t a -> Int
>treeSize (toTree -> Leaf) = 0
>treeSize (toTree -> Node l _ r) = treeSize l + treeSize r + 1

>treeLabels :: BT t => t a -> [a]
>treeLabels = aux [] where
>    aux acc (toTree -> Leaf) = acc
>    aux acc (toTree -> Node l x r) = aux (x : aux acc r) l

>treeFold :: BT t => (b -> a -> b -> b) -> b -> t a -> b
>treeFold _ e (toTree -> Leaf) = e
>treeFold f e (toTree -> Node l v r) = f (treeFold f e l) v (treeFold f e r)

>instance BT UTree where
>    toTree ULeaf = Leaf
>    toTree (UNode l x r) = Node l x r

> --Zad.2

>newtype Unbalanced a = Unbalanced { fromUnbalanced :: BTree Unbalanced a}

>instance BT Unbalanced where
>    toTree = fromUnbalanced

>searchBT :: (Ord a, BT t) => a -> t a -> Maybe a
>searchBT _ (toTree -> Leaf) = Nothing
>searchBT a (toTree -> Node l v r) 
>    | (a > v) = searchBT a r
>    | (a < v) = searchBT a l 
>    | otherwise = Just v

>toUTree :: BT t => t a -> UTree a
>toUTree (toTree -> Leaf) = ULeaf
>toUTree (toTree -> Node l v r) = UNode (toUTree l) v (toUTree r) 

>toUnbalanced :: BT t => t a -> Unbalanced a
>toUnbalanced (toTree -> Leaf) = Unbalanced Leaf
>toUnbalanced (toTree -> Node l v r) = Unbalanced (Node (toUnbalanced l) v (toUnbalanced r))
> --Zad.3

>instance (BT t, Show a) => Show (t a) where
>     show (toTree -> Leaf) = "-"
>     show (toTree -> Node (toTree -> Leaf) v (toTree -> Leaf)) = "- " ++ show v ++ " -"
>     show (toTree -> Node (toTree -> Leaf) v r) = "- " ++ show v ++ " (" ++ show r ++ ")"
>     show (toTree -> Node l v (toTree -> Leaf)) = "(" ++ show l ++ ") " ++ show v ++ " -"
>     show (toTree -> Node l v r) = "( " ++ show l ++ ") " ++ show v ++ " (" ++ show r ++ ")"

> --Zad.6

>class BT t => BST t where
>    node :: t a -> a -> t a -> t a
>    leaf :: t a

>instance BST UTree where
>    node = UNode
>    leaf = ULeaf

>instance BST Unbalanced where
>    node l x r = Unbalanced $ Node l x r
>    leaf = Unbalanced Leaf

>class Set s where
>    empty :: s a
>    search :: Ord a => a -> s a -> Maybe a
>    insert :: Ord a => a -> s a -> s a
>    delMax :: Ord a => s a -> Maybe (a, s a)
>    delete :: Ord a => a -> s a -> s a

>instance BST s => Set s where
>    empty = leaf
>    search = searchBT
>    insert a (toTree -> Leaf) = node leaf a leaf
>    insert a t@(toTree -> Node l v r) 
>        | (a > v) = node l v (insert a r)
>        | (a < v) = node (insert a l) v r
>        | otherwise = t
>    delMax (toTree -> Leaf) = Nothing
>    delMax (toTree -> Node l v leaf) = Just (v, l)
>    delMax (toTree -> Node l v r) = Just (max, t1) where
>        t1 = node l v r1
>        Just (max, r1) = delMax r
>    delete a (toTree -> Leaf) = leaf
>    delete a t@(toTree -> Node l v leaf) 
>        | (a > v) = t
>        | (a < v) = node (delete a l) v leaf
>        | otherwise = l
>    delete a t@(toTree -> Node leaf v r)
>        | (a > v) = node leaf v (delete a r)
>        | (a < v) = t
>        | otherwise = r
>    delete a (toTree -> Node l v r)
>        | (a > v) = node l v (delete a r) 
>        | (a < v) =  node (delete a l) v r
>        | otherwise =  node t1 max r where
>            Just (max, t1) = delMax l

> --Zad.7

>data WBTree a = WBNode (WBTree a) a Int (WBTree a) | WBLeaf

>wbsize :: WBTree a -> Int
>wbsize (WBNode _ _ n _) = n
>wbsize WBLeaf = 0

>instance BT WBTree where
>    toTree WBLeaf = Leaf
>    toTree (WBNode l v _ r) = Node l v r

>instance BST WBTree where
>    leaf = WBLeaf
>    --funkcja napisana przy pomocy tekstu Stephena Adamsa.
>    node l v r 
>        | (wbsize l) <= 1 && (wbsize r) <= 1 = WBNode l v (1 + wbsize l + wbsize r) r
>        | (wbsize r) > 5 * (wbsize l) && (wbsize rl < wbsize rr) = single_rotl l v r
>        | (wbsize r) > 5 * (wbsize l) = double_rotl l v r
>        | (wbsize l) > 5 * (wbsize r) && (wbsize lr < wbsize ll) = single_rotr l v r
>        | (wbsize l) > 5 * (wbsize r) = double_rotr l v r
>        | otherwise = WBNode l v (1 + wbsize l + wbsize r) r where
>            WBNode rl _ _ rr=r
>            single_rotl x a (WBNode y b _ z)=node (node x a y) b z
>            double_rotl x a (WBNode (WBNode y1 b _ y2) c _ z) = node (node x a y1) b (node y2 c z)
>            WBNode ll _ _ lr=l
>            single_rotr (WBNode x a _ y) b z = node x a (node y b z)
>            double_rotr (WBNode x a _ (WBNode y1 b _ y2)) c z = node (node x a y1) b (node y2 c z)

> --Zad.8

>data HBTree a = HBNode (HBTree a) a Int (HBTree a) | HBLeaf

>hbheight :: HBTree a -> Int
>hbheight (HBNode _ _ h _) = h
>hbheight HBLeaf = 0

>instance BT HBTree where
>    toTree HBLeaf = Leaf
>    toTree (HBNode l v _ r) = Node l v r

>instance BST HBTree where
>    leaf = HBLeaf
>    --w smart konstruktorze niezmienniki przywracamy za pomocą rotacji drzew AVL (w zależności od tego które z poddrzew jest za wysokie). 
>    node l v r
>        | hbheight l <= 1 && hbheight r <= 1 = HBNode l v (1 + max (hbheight l) (hbheight r)) r
>        | (hbheight r) > (hbheight l ) + 1 && (hbheight rr > hbheight rl) = single_rotl l v r
>        | (hbheight r) > (hbheight l ) + 1 = double_rotl l v r
>        | (hbheight l) > (hbheight r ) + 1 && (hbheight ll > hbheight lr) = single_rotr l v r
>        | (hbheight l) > (hbheight r ) + 1 = double_rotr l v r
>        | otherwise = HBNode l v (1 + max (hbheight l) (hbheight r)) r where
>            HBNode rl _ _ rr=r
>            single_rotl x a (HBNode y b _ z)=node (node x a y) b z
>            double_rotl x a (HBNode (HBNode y1 b _ y2) c _ z) = node (node x a y1) b (node y2 c z)
>            HBNode ll _ _ lr=l
>            single_rotr (HBNode x a _ y) b z = node x a (node y b z)
>            double_rotr (HBNode x a _ (HBNode y1 b _ y2)) c z = node (node x a y1) b (node y2 c z)

>main :: IO ()
>main = return ()