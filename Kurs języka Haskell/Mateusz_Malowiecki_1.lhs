>{-# LANGUAGE ParallelListComp #-}
> --Mateusz Małowiecki 300774 
> --kurs języka Haskell 
> --lista nr.1, 05.03.2020
>import Data.List
>import Data.Ratio
>import Control.Monad
>import Data.Char

> --Zad.1
>intercalate :: [a] -> [[a]] -> [a]
>intercalate _ [] = []
>intercalate _ (xs:[]) = xs
>intercalate y (xs:xss) = xs ++ y ++ Main.intercalate y xss

> --listy funkcji transpose moga miec rozna dlugosc
>transpose :: [[a]] -> [[a]]
>transpose [] = []
>transpose ([]:xss) = Main.transpose xss
>transpose xss = ([h | (h:_) <- xss]) : Main.transpose ([t | (_:t) <- xss])

>concat :: [[a]] -> [a]
>concat [] = []
>concat (xs:xss) = xs ++ Main.concat xss

>and :: [Bool] -> Bool
>and [] = True
>and (False:bs) = False
>and (True:bs) = Main.and bs

>all :: (a -> Bool) -> [a] -> Bool
>all f xs = Main.and (Data.List.map f xs)

>maximum :: [Integer] -> Integer
>maximum [] = Data.List.maximum []
>maximum (x:[]) = x
>maximum (x:xs) = max_of_two x (Main.maximum xs) where
>   max_of_two :: Integer -> Integer -> Integer
>   max_of_two x y
>       | x <= y = y
>       | otherwise = x

> --Zad.2
>newtype Vector a = Vector {fromVector :: [a]}

>scaleV :: Num a => a -> Vector a -> Vector a
>scaleV x v = Vector $ mult_by_num x (fromVector v) where
>    mult_by_num :: Num a => a -> [a] -> [a]
>    mult_by_num x xs = map (\y -> x*y) xs

>norm :: Floating a => Vector a -> a
>norm v = sqrt $ scalarProd v v

>scalarProd :: Num a => Vector a -> Vector a -> a
>scalarProd v1 v2 = sc_prod (fromVector v1) (fromVector v2) where
>    sc_prod :: Num a => [a] -> [a] -> a
>    sc_prod [] [] = 0
>    sc_prod (x:xs) (y:ys) = x*y + sc_prod xs ys
>    sc_prod _ _ = error "Vectors have different lengths"

>sumV :: Num a => Vector a -> Vector a -> Vector a
>sumV v1 v2 = Vector $ sum_vect (fromVector v1) (fromVector v2) where
>    sum_vect :: Num a => [a] -> [a] -> [a]
>    sum_vect [] [] = []
>    sum_vect (x:xs) (y:ys) = (x+y):sum_vect xs ys
>    sum_vect _ _ = error "Vectors have different lengths"

> --Zad.3
>newtype Matrix a = Matrix {fromMatrix :: [[a]]}

>sumM :: Num a => Matrix a -> Matrix a -> Matrix a
>sumM m1 m2 = Matrix $ sum_matr (fromMatrix m1) (fromMatrix m2) where
>    sum_matr :: Num a => [[a]] -> [[a]] -> [[a]]
>    sum_matr [] [] = []
>    sum_matr (xs:xss) (ys:yss) = sum_vect xs ys : sum_matr xss yss where
>        sum_vect :: Num a => [a] -> [a] -> [a]
>        sum_vect [] [] = []
>        sum_vect (x:xs) (y:ys) = (x+y):sum_vect xs ys
>        sum_vect _ _ = error "Matrices have different sizes"
>    sum_matr _ _ = error "Matrices have different sizes"

> -- Iloczyn macierzy: poniewaz element na pozycji (i, j) macierzy A*B jest iloczynem skalarnym i-tego wiersza macierzy A
> -- oraz j-tej kolumny macierzy B (j-tego wiersza transpozycji B), bierzemy wszystkie iloczyny skalarne 
>prodM :: Num a => Matrix a -> Matrix a -> Matrix a
>prodM m1 m2 = Matrix $ prod_matr (fromMatrix m1) (fromMatrix m2) where
>    prod_matr :: Num a => [[a]] -> [[a]] -> [[a]]
>    prod_matr m1 m2 =
>        [[sc_prod m1r m2c | m2c <- Main.transpose m2] | m1r <- m1 ] where
>        sc_prod :: Num a => [a] -> [a] -> a
>        sc_prod [] [] = 0
>        sc_prod (x:xs) (y:ys) = x*y + sc_prod xs ys
>        sc_prod _ _ = error "Matrices have wrong sizes"

> --wyznacznik obliczony rozwinieciem LaPlace'a
>det :: Num a => Matrix a -> a
>det m = det1 (fromMatrix m) where
>    det1 :: Num a => [[a]] -> a
>    det1 [[x]] = x
>    det1 x 
>        | (length x) <= 1 || (length (head x)) <= 1 = error "Matrix is not squared"  
>        | otherwise = sum (Data.List.zipWith (*)
>            (Data.List.zipWith (*) detmatrix sign) (Data.List.head x)) where
>            detmatrix = [det1 subm | subm <- (head (submat x))]
>            sign=take(length(head x)) (iterate ((-1) *) 1)
>            --funkcja sub dla listy dlugosci n, zwraca wszystkie podlisty dlugosci n-1
>            sub :: [a] -> [[a]]
>            sub [x] = [[]]
>            sub (x:xs) = xs: (Data.List.map (x:) (sub xs))
>            --submat zwraca liste podmacierzy powstalych przez usuniecie wiersza i kolumny
>            submat :: Num a => [[a]] -> [[[[a]]]]
>            submat [[x]] = [[[[]]]]
>            submat x = [Main.transpose (map sub subm) | subm<-(sub x)]

> --Zad.4
>isbn13_check :: String -> Bool
>isbn13_check s = isb_check (leave_numbers s) where
>    --najpierw usuwamy wszystkie znaki nie bedace liczbami
>    leave_numbers :: String -> String
>    leave_numbers s = Data.List.filter (\l -> l >= '0' && l <= '9') s
>    --nastepnie sprawdzamy zgodnie ze wzorem
>    isb_check :: String -> Bool
>    isb_check s = c `mod` 10 == 0 where
>        c :: Int
>        c = sum (Data.List.zipWith (*) s1 [1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1])
>        s1 :: [Int]
>        s1 = map digitToInt s

> --Zad.5
>newtype Natural = Natural { fromNatural :: [Word] }
>base :: Word
>base = (floor . sqrt . fromIntegral) mb + 1 where
>    --musimy zrzutowac wczesniej na word
>    mb :: Word
>    mb = maxBound

> --Zad.6
>instance Num Natural where
>    -- dodawanie pismene
>    a + b = Natural $ addNumbers 0 (fromNatural a) (fromNatural b) where
>        addNumbers :: Word -> [Word] -> [Word] -> [Word]
>        --zmienna mov to przeniesienie
>        addNumbers mov (x:xs) (y:ys) = ((x+y+mov) `mod` base):(addNumbers ((x+y+mov) `div` base) xs ys)
>        addNumbers mov [] (y:ys) = ((y+mov) `mod` base):(addNumbers ((y+mov) `div` base) [] ys)
>        addNumbers mov (x:xs) [] = ((x+mov) `mod` base):(addNumbers ((x+mov) `div` base) xs [])
>        addNumbers mov [] [] | (mov == 0) = [] | otherwise = [mov]
>    a * b = Natural $ multNumbers (fromNatural a) (fromNatural b) where
>       multNumbers :: [Word] -> [Word] -> [Word]
>       -- jezeli druga lista jest pusta to wynik jest rowny zero
>       multNumbers _ [] = []
>       -- jezeli druga lista jest niepusta i rowna x + base * xs, to obliczamy wartosc (x + base * xs) * ys = (x * ys) + (base * xs * ys)
>       multNumbers ys (x:xs) = fromNatural ((Natural (multbydigit 0 x ys)) + (Natural (0:(multNumbers ys xs))))
>       -- funkcja ktora mnozy liczbe przez pojedyncza cyfre, mov to przeniesienie 
>       multbydigit :: Word -> Word -> [Word] -> [Word]
>       multbydigit mov _ [] | (mov == 0) = [] | otherwise = [mov]
>       multbydigit mov x (y:ys) = ((x * y + mov) `mod` base) : (multbydigit ((x * y + mov) `div` base) x ys) 
>    abs a = a
>    --lista pusta to zero, lista niepusta to liczba dodatnia
>    signum m = sig1 (fromNatural m) where
>       sig1 :: Num a => [Word] -> a
>       sig1 [] = 0
>       sig1 _ = 1
>    --odejmowanie pismene
>    a - b = Natural $ subNumbers 0 (fromNatural a) (fromNatural b) where
>        subNumbers :: Word -> [Word] -> [Word] -> [Word]
>        --zmienna mov to przeniesienie
>        subNumbers mov (x:xs) (y:ys) = ((x-y+mov) `mod` base):(subNumbers ((x-y+mov) `div` base) xs ys)
>        subNumbers mov [] (y:ys) = error "First argument should be bigger than second"
>        subNumbers mov (x:xs) [] = ((x+mov) `mod` base):(subNumbers ((x+mov) `div` base) xs [])
>        subNumbers mov [] [] = []
>    --funkcja fromInteger konwertuje miedzy reprezentacjami, niestety jest problem z konwersja miedzy word i integer
>    --fromInteger i =  Natural $ count_nat i where
>      --  count_nat :: Integer -> [Word]
>      --  count_nat n
>        --      | n == 0 = []
>        --      | otherwise = (n `mod` base) : count_nat (n `div` base)

> --Zad.7
>instance Eq Natural where
>    a == b = (fromNatural a) == (fromNatural b)

>instance Ord Natural where
>    a <= b = le_list (fromNatural a) (fromNatural b) where
>        le_list :: [Word] -> [Word] -> Bool
>        -- 0 <= 0
>        le_list [] [] = True
>        --jesli m, n > 0, a m0 i n0 to odpowiednio ich najnizsze slowa to prawdziwa jest implikacja
>        -- m - m0 > n - n0 => m > n <=> m <= n => m - m0 <= n - n0, stad najpierw sprawdzamy wykonujemy wywolanie rekurencyjne,
>        --a nastepnie sprawdzamy czy a - a0 < b - b0 lub a - a0 == b - b0 oraz a0 <= b0
>        le_list (x:xs) (y:ys) = (le_list xs ys) && (xs /= ys || x <= y ) 
>        -- jesli n > 0, to 0 <= n
>        le_list [] _ = True
>        -- jesli n > 0, to ~(n <= 0)
>        le_list _ [] = False

> --Zad.8
>instance Real Natural where
>    toRational n = (toInteger n) % 1
>instance Enum Natural where
>    fromEnum n = fromIntegral n
>    toEnum n = fromIntegral n
>instance Integral Natural where
>    --funkcja quotRem polega na znalezieniu najmniejszego i takiego ze i * a > b.
>    --takie i jest rowne floor(a/b) + 1. Latwo znalezc z tego a mod b. 
>    --Funkcja dziala o ile floor(a/b) < base
>    quotRem a b = (Natural x, Natural y) where
>       (x, y) = find_div 1 (fromNatural a) (fromNatural b)
>       find_div :: Word -> [Word] -> [Word] -> ([Word] , [Word])
>       find_div i ys xs 
>           | mbd > ys = (i - 1:[], fromNatural $ (Natural ys) - (Natural mbd1)) 
>           | otherwise = find_div (i + 1) xs ys where 
>               mbd = multbydigit 0 i xs
>              	mbd1 = multbydigit 0 (i - 1) xs
>    -- funkcja ktora mnozy liczbe przez pojedyncza cyfre, mov to przeniesienie 
>       multbydigit :: Word -> Word -> [Word] -> [Word]
>       multbydigit mov _ [] | (mov == 0) = [] | otherwise = [mov]
>       multbydigit mov x (y:ys) = ((x * y + mov) `mod` base) : (multbydigit ((x * y + mov) `div` base) x ys)  
>    --funkcja toInteger konwertuje miedzy reprezentacjami, niestety jest problem z konwersja miedzy word i integer
>    --toInteger n = count_value (fromNatural n) where
>      --count_value :: [Word] -> Integer
>      --count_value xs = sum (zipWith (*) xs (take (length xs) (iterate (base*) 1)))

> --Zad.9
>instance Show Natural where
>   show n = show (fromNatural n)

> --Zad.10
>val1 :: (a -> b -> c) -> a -> (d -> b) -> d -> c
>val1 =(.)(.)

>val2 :: (a -> c -> b) -> a -> c -> b
>val2 = (.)($)

>val3 :: (b -> c) -> (a -> b) -> a -> c
>val3 = ($)(.)

>val4 :: b -> (a -> b -> c) -> a -> c
>val4 = flip flip

>val5 :: (b -> c) -> (d -> a -> b) -> d -> a -> c
>val5 = (.)(.)(.)

>val6 :: (b -> c) -> (a -> b) -> a -> c
>val6 = (.)($)(.)

>val7 :: (a -> b -> c) -> a -> b -> c
>val7 = ($)(.)($)

>val8 :: (a -> ((b -> c -> d) -> c -> b -> d) -> e) -> a -> e 
>val8 = flip flip flip

>val9 :: [String]
>val9 = tail $ map tail [[],['a']]

>val10 :: a
>val10 = let x = x in x x

>val11 :: Char
>val11 = (\ _ -> 'a') (head [])

>val12 :: Char
>val12 = (\ (_, _) -> 'a') (head [])

>val13 :: [a -> b] -> [[a] -> [b]]
>val13 = map map

>val14 :: [a -> b -> c] -> [b -> a -> c]
>val14 = map flip

>val15 :: [a] -> (a -> b) -> [b]
>val15 = flip map

>main :: IO()
>main = return ()
