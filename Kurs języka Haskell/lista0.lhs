>import Data.List
>import Data.Char
>import Data.Maybe

>explode :: Integer -> [Integer]
>explode = reverse . unfoldr (\b -> if b <= 0 then Nothing else Just(b `mod` 10, b `div` 10))

>implode :: [Integer] -> Integer
>implode = foldl (\state x -> 10*state+x) 0 

>rot13 :: String -> String
>rot13 = map rotchar where
>    rotchar c = case (lookup c $ transp lc) of
>        Just x -> x -- success! replace letter
>        Nothing -> fromMaybe c (lookup c $ transp uc) -- Nothing means we failed... lookup in upper case letters, or leave letter as is
>    transp x = zip x ((drop 13 x) ++ (take 13 x))
>    lc = ['a' .. 'z']
>    uc = ['A' .. 'Z']

>subsequences :: [a] -> [[a]]
>subsequences [] = [[]]
>subsequences (x:xs) = [x:sublists | sublists <- Main.subsequences xs] ++ Main.subsequences xs 

>inits :: [a] -> [[a]]
>inits [] = [[]]
>inits (x:xs) = []:[x:init | init <- Main.inits xs]

>tails :: [a] -> [[a]]
>tails [] = [[]]
>tails y@(x:xs) = y:Main.tails xs

>segments :: [a] -> [[a]]
>segments [] = [[]]
>segments (x:[]) = [[], [x]]
>segments ys@(x:xs) = (tail (Main.inits ys)) ++ Main.segments xs

>permutations :: [a] -> [[a]]
>permutations [] = [[]]
>permutations (x:xs) = concatMap (insert x) (Main.permutations xs)
>    where
>        insert :: a -> [a] -> [[a]]
>        insert x [] = [[x]]
>        insert x (y:ys) = (x:y:ys) : map (y:) (insert x ys)

>merge :: Ord a => [a] -> [a] -> [a]
>merge [] xs = xs
>merge xs [] = xs
>merge f@(h:first) s@(c:second) 
>    | h <= c = h:merge first s
>    | h > c = c:merge f second

>msortPrefix :: Ord a => Int -> [a] -> [a]
>msortPrefix i xs = helper (take i xs) where
>    helper [] = []
>    helper xsprim = merge (helper cs) (helper bs) where
>       bs = drop k xs
>       cs = take k xs
>       k = length xsprim `div` 2

>msort :: Ord a => [a] -> [a]
>msort xs = msortPrefix (length xs) xs

>isort :: Ord a => [a] -> [a]
>isort [] = []
>isort (x:xs) = insert x (Main.isort xs) where
>    insert :: Ord a => a -> [a] -> [a]
>    insert x [] = [x]
>    insert x (y:ys) = if x < y then x:y:ys else y:insert x ys

>qsort :: Ord a => [a] -> [a]
>qsort []	= []
>qsort (x:xs) = Main.qsort small ++ mid ++ Main.qsort large where
>    small = [y | y<-xs, y<x]
>    mid   = [y | y<-xs, y==x] ++ [x]
>    large = [y | y<-xs, y>x]

>ssort :: Ord a => [a] -> [a]
>ssort xs= selectionSort [] xs where
>    selectionSort :: Ord a => [a] -> [a] -> [a]
>    selectionSort sorted [] = sorted
>    selectionSort sorted unsorted = selectionSort (max:sorted) (delete max unsorted)
>        where max = maximum unsorted

>elem :: Eq a => a -> [a] -> Bool
>elem _ [] = False
>elem a (x:xs) 
>    | a == x = True
>    | otherwise= Main.elem a xs

>intersperse :: a -> [a] -> [a]
>intersperse a [] = []
>intersperse a y@(x:[]) = y
>intersperse a (x:xs) = x:a:Main.intersperse a xs

>main :: IO ()
>main = print $ Main.segments [1, 5, 3, 4, 2]