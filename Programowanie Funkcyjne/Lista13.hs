-- PF2018 Lista 13

import Prelude hiding ((++), (!!), head, tail, null, length)
import qualified Prelude ((++), (!!), head, tail, null, length)
import Data.Maybe (fromMaybe, fromJust, maybe)
import qualified Data.List (uncons)
import Control.Applicative ((<|>))
import Control.Monad (MonadPlus, mplus, msum, guard)

class List l where
   nil :: l a
   cons :: a -> l a -> l a
   head :: l a -> a
   tail :: l a -> l a
   (++) :: l a -> l a -> l a
   (!!) :: l a -> Int -> a
   toList :: [a] -> l a
   fromList :: l a -> [a]

class SizedList l where
   length :: l a -> Int
   null :: l a -> Bool
   null xs = length xs == 0

-- Zadanie 1
instance List [] where
   nil = []
   cons = (:)
   head = Prelude.head
   tail = Prelude.tail
   (++) = (Prelude.++)
   (!!) = (Prelude.!!)
   toList = id
   fromList = id

-- Zadanie 2
instance SizedList [] where
   length = Prelude.length
   null = Prelude.null

-- Zadanie 3
data SL l a = SL { len :: Int, list :: l a }

instance List l => List (SL l) where
   nil = SL 0 nil
   cons x xs = SL (len xs + 1) (cons x $ list xs)
   head = head . list
   tail xs =
      if len xs == 0
         then error "empty list"
         else SL (len xs - 1) (tail $ list xs)
   xs ++ ys = SL (len xs + len ys) (list xs ++ list ys)
   xs !! n =
      if len xs <= n || n < 0
         then error "index out of range"
         else list xs !! n
   toList xs = SL (length xs) (toList xs)
   fromList = fromList . list

instance List l => SizedList (SL l) where
   length = len

instance Show (l a) => Show (SL l a) where
   show = show . list

-- Zadanie 4
infixr 6 :+
data AppList a = Nil | Sngl a | AppList a :+ AppList a

instance List AppList where
   nil = Nil
   cons x xs = Sngl x :+ xs
   head = fromMaybe (error "empty list") . hd where
      hd Nil = Nothing
      hd (Sngl a) = Just a
      hd (xs :+ ys) = hd xs <|> hd ys
   tail = fromMaybe (error "empty list") . tl where
      tl Nil = Nothing
      tl (Sngl _)= Just Nil
      tl (xs :+ ys) = maybe (tl ys) (Just . (:+ ys)) (tl xs)
   (++) = (:+)
   xs !! n =
      either (const $ error "index out of range") id (index xs n) where
         index Nil _ = Left 0
         index (Sngl x) 0 = Right x
         index (Sngl _) n = Left (n-1)
         index (xs :+ ys) n = either (index ys) Right (index xs n)
   toList [] = Nil
   toList (x:xs) = cons x (toList xs)
   fromList xs = fl xs [] where
      fl Nil acc = acc
      fl (Sngl x) acc = x : acc
      fl (xs :+ ys) acc = fl xs (fl ys acc)

instance SizedList AppList where
   length Nil = 0
   length (Sngl _) = 1
   length (xs :+ ys) = length xs + length ys
   null Nil = True
   null (Sngl _) = False
   null (xs :+ ys) = null xs && null ys

instance Show a => Show (AppList a) where
   show = show . fromList

-- Zadanie 5
newtype DiffList a = DF ([a] -> [a])

instance List DiffList where
   nil = DF id
   cons x (DF f) = DF ((x:) . f)
   head (DF f) = head (f [])
   tail (DF f) = DF (tail . f)
   (DF f) ++ (DF g) = DF (f . g)
   (DF f) !! n = f [] !! n
   toList xs = DF (\ ys -> xs ++ ys)
   fromList (DF f) = f []

instance SizedList DiffList where
   length = length . fromList
   null = null . fromList

instance Show a => Show (DiffList a) where
   show = show . fromList

-- Zadanie 6
data RTL a = Empty | Zero (RTL (a,a)) | One a (RTL (a,a))

-- Odpowiednik Data.List.uncons dla typu RTL a – koszt O(log|xs|).
uncons :: RTL a -> (a, RTL a)
uncons Empty = error "empty list"
uncons (Zero xs) = (x, One x' xs') where ((x,x'),xs') = uncons xs
uncons (One x xs) = (x, Zero xs) 

instance List RTL where
   -- Utworzenie listy pustej nil — koszt O(1).
   nil = Empty
   -- Funkcja cons x xs — koszt O(log|xs|).
   cons x Empty = One x Empty
   cons x (Zero xs) = One x xs
   cons x (One x' xs) = Zero (cons (x,x') xs)
   -- Funkcja head xs — koszt O(log|xs|).
   head Empty = error "empty list"
   head (Zero xs) = fst $ head xs
   head (One x xs) = x
   -- Funkcja tail xs — koszt O(log|xs|).
   tail = snd . uncons
   -- Funkcja xs ++ ys — koszt O(|xs|).
   Empty ++ ys = ys
   xs ++ ys = cons x (xs' ++ ys) where (x,xs') = uncons xs
   -- Funkcja xs !! n — koszt O(log|xs|).
   xs !! n = idx (id, n) xs where
      lift f n = (f . if n `mod` 2 == 0 then fst else snd, n `div` 2)
      idx :: (a -> b, Int) -> RTL a -> b
      idx _ Empty = error "index out of range"
      idx (f,n) (Zero xs) = idx (lift f n) xs
      idx (f,0) (One x xs) = f x
      idx (f,n) (One _ xs) = idx (lift f (n-1)) xs
   -- Funkcja toList xs — koszt O(|xs|).
   toList xs = tol (fromJust . Data.List.uncons) (length xs) xs where
      lift f xs = ((x,x'),xs'') where
         (x,xs') = f xs
         (x',xs'') = f xs'
      tol :: ([a] -> (b,[a])) -> Int -> [a] -> RTL b
      tol f n xs
         | n == 0 = Empty
         | n `mod` 2 == 0 = Zero $ tol (lift f) (n `div` 2) xs
         | otherwise = One x $ tol (lift f) (n `div` 2) xs' where
              (x,xs') = f xs
   -- Funkcja fromList xs — koszt O(|xs|).
   fromList xs = frl (:) xs [] where
      lift :: (a -> [b] -> [b]) -> ((a,a) -> [b] -> [b])
      lift f (x,y) acc = f x (f y acc)
      frl :: (a -> [b] -> [b]) -> RTL a -> [b] -> [b]
      frl _ Empty acc = acc
      frl f (Zero xs) acc = frl (lift f) xs acc
      frl f (One x xs) acc = f x (frl (lift f) xs acc)

instance SizedList RTL where
   -- Funkcja length xs — koszt O(log|xs|).
   length Empty = 0
   length (Zero xs) = 2 * length xs
   length (One x xs) = 2 * length xs + 1
   -- Funkcja null xs — koszt O(1).
   null Empty = True
   null _ = False

instance Show a => Show (RTL a) where
   show = show . fromList

-- Zadanie 7
iperm, sperm :: MonadPlus m => [a] -> m [a]

iperm [] = return []
iperm (x:xs) = do
   zs <- iperm xs
   insert zs where
      insert [] = return [x]
      insert ys@(y:ys') = return (x:ys) `mplus` do
         zs <- insert ys'
         return$ y:zs

sperm [] = return []
sperm xs = do
   (y,ys) <- select xs
   zs <- sperm ys
   return$ y:zs where
      select [x] = return (x,[])
      select (x:xs) = return (x,xs) `mplus` do
         (y,ys) <- select xs
         return (y,x:ys)

-- Zadanie 8
queens :: MonadPlus m => Int -> m [Int]
queens n = put n where
   put :: MonadPlus m => Int -> m [Int]
   put 0 = return []
   put k = do
      board <- put (k-1)
      pos <- msum $ map return [1..n]
      guard$ check board 1 pos
      return$ pos:board where
         check [] _ _ = True
         check (q:board) delta pos =
            pos /= q && abs (pos-q) /= delta &&
            check board (delta+1) pos

