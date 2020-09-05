import Data.List
--Zad.1
class List (l :: * -> *) where
	nil :: l a
	cons :: Ord a => a -> l a -> l a
	head :: Ord a => l a -> a
	tail :: Ord a => l a -> l a
	(++) :: Ord a => l a -> l a -> l a
	(!!) :: (Eq a, Ord a) => l a -> Int -> a
	toList :: Ord a => [a] -> l a
	fromList :: (Ord a, Eq a) => l a -> [a]
instance List [] where
	nil = []
	cons a l=a:l
	head (x:xs)=x
	head _ = error "No head in list"
	tail (x:xs)=xs
	tail _ = []
	(x:xs) ++ l2 = x:(xs Main.++ l2)
	[] ++ l2 =l2
	xs !! n | n<0 = error "Negative index"
	[] !! _ = error "Index is bigger than size of list"
	(x:_) !! 0 = x
	(_:xs) !! n = (xs Main.!! (n-1))
	toList l = l
	fromList xs = xs
--Zad.2
class List l => SizedList l where
	length :: Ord a => l a -> Int
	null :: (Eq a, Ord a) => l a -> Bool
	null l = Main.length l == 0
instance SizedList [] where
	length [] = 0
	length (_:xs)=1+(Main.length xs)
	null l = l==[]
--Zad.3
data SL l a = SL { len :: Int, list :: l a }
instance List l => List (SL l) where
	nil = SL 0 Main.nil
	cons a (SL l xs) = SL (l+1) (Main.cons a xs)
	head (SL _ xs) = Main.head xs
	tail (SL l xs) = SL (l-1) (Main.tail xs)
	(SL l1 xs) ++ (SL l2 ys)=(SL (l1 + l2) (xs Main.++ ys))
	(SL l1 xs) !! ind=(xs Main.!! ind)
	toList xs = SL (Prelude.length xs) (Main.toList xs)
	fromList (SL l xs)=(Main.fromList xs)
instance List l => SizedList (SL l) where
	length (SL l xs)=l
	null (SL l xs)= l == 0
--Zad.4
infixr 6 :+
data AppList a = Nil | Sngl a | AppList a :+ AppList a
instance (Show a, Eq a) => Show (AppList a) where
	show (a1 :+ a2)=(show a1) Prelude.++ (show a2)
	show (Sngl a) = (Prelude.show a)
	show Nil = ""
instance List AppList where
	nil = Nil
	cons a (a1 :+ a2)=(cons a a1) :+ a2
	cons a (Sngl a1)=(Sngl a) :+ (Sngl a1)
	cons a Nil=Sngl a
	head (a1 :+ a2) | Main.null a1 = Main.head a2 | otherwise = Main.head a1
	head (Sngl a1)=a1
	head Nil=error "No head in list"
	tail (a1 :+ a2)=(Main.tail a1) :+ a2 
	tail _ = Nil
	a1 ++ a2 = a1 :+ a2
	_ !! n | n < 0 = error "Negative index"
	(a1 :+ a2) !! i = if i > (Main.length a1) then a2 Main.!! (i-(Main.length a1)) else a1 Main.!! i
	(Sngl a) !! n | n==0 = a | otherwise = error "Index is bigger than size of list"
	Nil !! _ = error "Index is bigger than size of list"
	fromList (a1 :+ a2) = (fromList a1) Main.++ (fromList a2)
	fromList (Sngl a) = [a]
	fromList Nil = []
	toList (x:xs)=(Sngl x) :+ (toList xs)
	toList [] = Nil
instance SizedList AppList where	
	length (Nil)=0
	length (Sngl a)=1
	length (a1 :+ a2) = (Main.length a1) + (Main.length a2)
	null (Nil)=True
	null _ = False
--Zad.5
newtype DiffList a = DL ([a] -> [a])
instance (Show a, Eq a, Ord a) => Show (DiffList a) where
	show d = Prelude.show(Main.fromList d)
instance List DiffList where
	nil = DL (\xs -> xs)
	cons a (DL f) = DL (\xs -> a:(f xs))
	head d = Prelude.head (Main.fromList d)
	tail d = DL (\xs -> (Prelude.tail (Main.fromList d)) Prelude.++ xs)
	d1 ++ d2 = DL (\xs -> (Main.fromList d1) Prelude.++ (Main.fromList d2) Prelude.++ xs)
	d !! i | i < 0 = error "Negative index"
	d !! _ | Main.null d = error "Index is bigger than size of list"
	d !! 0 = Main.head d
	d !! i = (Main.tail d) Main.!! (i-1)
	toList xs = DL (\ys -> xs Prelude.++ ys)
	fromList (DL f) = f []
instance SizedList DiffList where
	length d=Prelude.length (Main.fromList d)
	null d = (Main.fromList d) == []
--Zad.6
data RAL a = Empty | Zero (RAL (a,a)) | One a (RAL (a,a)) deriving Eq
instance Show a => Show (RAL a) where
	show (One a r) = (Prelude.show a) Prelude.++ (show r)
	show (Zero r) = (show r)
	show Empty = ""
main :: IO()
main = return ()
