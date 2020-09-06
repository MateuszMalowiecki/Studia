import Control.Parallel
--Zadanie 1
nthPrime :: Int -> Int
nthPrime x = startFrom x 2 where
    isPrime n = tw `par` (f `pseq` all f tw) where
        tw=takeWhile (\k -> k*k <= n) small
        f=(\k -> n `mod` k /= 0)
    small = 2 : [n | n <- [3,5..], isPrime n]
    startFrom 0 n
        | isPrime n = n
        | otherwise = nplusone `par` startFrom 0 nplusone where
            nplusone = n + 1
    startFrom k n = nplusone `par` (startFrom ((k - 1) `par` (isp `pseq` if isp then k - 1 else k)) nplusone) where
        isp=isPrime n
        nplusone = n + 1
--Zadanie 2
{-swap :: ST s Int a -> Int -> Int -> ST s ()
swap arr i j = do
    elem1 <- readArray arr i
    elem2 <- readArray arr j
    writeArray arr j elem1
    writeArray arr i elem2
partitionLoop :: (Ord a) => STArray s Int a -> a -> Int -> StateT Int (ST s) ()
partitionLoop arr pivotElement i = do
    pivotIndex <- get
    thisElement <- lift $ readArray arr i
    when (thisElement <= pivotElement) $ do
        lift $ swap arr i pivotIndex
        put (pivotIndex + 1)
partition :: (Ord a) => STArray s Int a -> Int -> Int -> ST s Int
partition arr start end = do
    pivotElement <- readArray arr start
    let pivotIndex_0 = start + 1
    finalPivotIndex <- execStateT
        (mapM (partitionLoop arr pivotElement) [(start+1)..(end-1)])
        pivotIndex_0
    swap arr start (finalPivotIndex - 1)
    return $ finalPivotIndex - 1
quicksort2Helper :: (Ord a) => Int -> Int -> STArray s Int a -> ST s ()
quicksort2Helper start end stArr = when (start + 1 < end) $ do
    pivotIndex <- partition stArr start end
    quicksort2Helper start pivotIndex stArr
    quicksort2Helper (pivotIndex + 1) end stArr
quicksort2 :: (Ord a) => Array Int a -> Array Int a
quicksort2 inputArr = runSTArray $ do
    stArr <- thaw inputArr
    let (minIndex, maxIndex) = bounds inputArr
    quicksort2Helper minIndex (maxIndex + 1) stArr
    return stArr-}

qsort :: [(Int, a)] -> [(Int, a)]
qsort = qsort_aux [] where
    qsort_aux :: [(Int, a)] -> [(Int, a)] -> [(Int, a)]
    qsort_aux a [] = a
    qsort_aux a ((k, v):xs) = qsort_aux ((k, v) : qsort_aux a [(k1, v1) | (k1, v1) <- xs, k1 >= k]) [(k1, v1) | (k1, v1) <- xs, k1 < k]
bucketSort :: [(Int, a)] -> [(Int, a)]
bucketSort xs = runSTArray $ do
    arr <- create_array xs
    arr2 <- mapM qsort arr
    concat_array arr div_len [] where
    create_array :: [(Int, a)] -> STArray Int [(Int, a)]
    create_array xs = (0, div_len) [(i, xs) | i <- [0..div_len], xs <- divided]
    div_len=length divided
    divided=divide (length) xs (max_key za)
    divide :: Int -> [(Int, a)] -> Int -> [[(Int, a)]]
    divide n [] max = replicate n []
    divide n ((k, v):xs) max = insert_into_bucket (k, v) (k * n / max) (divide n xs max)
    max_key :: [(Int, a)] -> Int
    max_key [] = error "Empty list doesn't have maximum."
    max_key [(k, _)] = k
    max_key ((k, _):xs) =max k $ max_key xs
    concat_array :: STArray Int [(Int, a)] -> Int -> [(Int, a)] -> [(Int, a)]
    concat_array _ 0 acc = acc
    concat_array arr i acc = concat_array arr (i - 1) ((readArray arr i):acc)
--Zadanie 3
data Union-Find a = UF (STArray s a ((Union-Find a), Int, Int)) 
data Graph a = Graph [a] [(a, a, Int)]
minSpanningTree :: (Graph a) -> (Graph a)
minSpanningTree (Graph v e) = makeGraph $ kruskal [] (qsort2 e) (map disjoin_to_sets v) where
    disjoin_to_sets :: a -> Union-Find a
    disjoin_to_sets a = let x=(array (a, a) [a, (x, 0, 1)]) in x
    qsort2 :: [(a, a, Int)] -> [(a, a, Int)]
    qsort2 = qsort_aux [] where
        qsort_aux :: [(a, a, Int)] -> [(a, a, Int)] -> [(a, a, Int)]
        qsort_aux a [] = a
        qsort_aux a ((v1, v2, w):xs) = qsort_aux ((v1, v2, w) : qsort_aux a [(v1prim, v2prim, wprim) | (v1prim, v2prim, wprim) <- xs, wprim >= w]) [(v1prim, v2prim, wprim) | (v1prim, v2prim, wprim) <- xs,wprim < w]
    kruskal :: [(a, a, Int)] -> [(a, a, Int)] -> [Union-Find a] -> ([Union-Find a], [(a, a, Int)])
    kruskal e1 [] xs = (xs, e)
    kruskal e1 (e:es) xs = ...	
main=return ()