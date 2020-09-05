--Zad.1
infix 6 :*, :/
infix 5 :+, :-
infix 4 :=
data Cryptarithm = Expression := Expression
data Expression = N String
	| Expression :+ Expression
	| Expression :- Expression
	| Expression :* Expression
	| Expression :/ Expression
instance Show Expression where
	show (N s)=s
	show (el :+ er) = (show el) ++ " :+ " ++ (show er)
	show (el :- er) = (show el) ++ " :- " ++ (show er)
	show (el :* er) = (show el) ++ " :* " ++ (show er)
	show (el :/ er) = (show el) ++ " :/ " ++ (show er)
instance Show Cryptarithm where
	show (el := er) = (show el) ++ " := " ++ (show er)
{-solve (el := er) = checkList (iperm (letters el)) where 
	insEverywhere :: a -> [a] -> [[a]]
	insEverywhere y [] = [[y]]
	insEverywhere y xs'@(x:xs) = (y:xs') : map (x:) (insEverywhere y xs)
	iperm :: [a] -> [[a]]
	iperm [] = [[]]
	iperm (x:xs) = concatMap (insEverywhere x) (iperm xs)
	checkList ps=case ps of
		[] -> error "Not solve for cryptharhitm"
		ph:pt -> if (check ph) then return ph else checkList pt
	member :: (Eq a) => a -> [a] -> Bool
	member x [] = False
	member x (y:ys) | x==y = True
                | otherwise = member x ys
	signs="+":"-":"*":"/":"=":[]
	letters e = case e of
		N s -> concat (strMap (\c -> [c]) s)
		(el :+ er) -> (letters el) ++ (letters er)
		(el :- er) -> (letters el) ++ (letters er)
		(el :* er) -> (letters el) ++ (letters er)
		(el :/ er) -> (letters el) ++ (letters er)
	findPair c arr = case arr of
		[] -> error "Not char in list"
		(c1 , i):t -> if (ci==c) then i else findPair c t
	convert arr s = 
		strMap (\c -> findPair c arr) s
	elss=filter (\s -> (member s signs)) words (show el)
	els=filter (\s -> not (member s signs)) words (show el)
	ers=words(show er)
	counting arr sa ssa i acc=
		if (i==length  sa) 
			then acc
			else (acc (ssa !! i) (sa !! i))
	check arr = let eli = (counting arr els elss 0 []) in
		let eri=convert arr ers in (eli==eri)-}
--Zad.2
parse :: String -> Either String Cryptarithm
parse s=parse_words w 0 (N "") where
	member :: (Eq a) => a -> [a] -> Bool
	member x [] = False
	member x (y:ys) | x==y = True
                | otherwise = member x ys
	w=words s
	signs="+":"-":"*":"/":"=":[]
	parse_words :: [String] -> Int -> Expression -> Either String Cryptarithm
	parse_words w i acc = case w !! i of
		"+" -> if member (w !! (i+1)) signs
				then Left ("Unexpected operator " ++ (w !! (i+1)))
				else parse_words w (i+1) (acc :+ N (w !! (i+1)))
		"-" -> if member (w !! (i+1)) signs
				then Left ("Unexpected operator " ++ (w !! (i+1)))
				else parse_words w (i+1) (acc :- N (w !! (i+1)))
		"*" -> if member (w !! (i+1)) signs
				then Left ("Unexpected operator " ++ (w !! (i+1)))
				else parse_words w (i+1) (acc :* N (w !! (i+1)))
		"/" -> if member (w !! (i+1)) signs
				then Left ("Unexpected operator " ++ (w !! (i+1)))
				else parse_words w (i+1) (acc :/ N (w !! (i+1)))
		"=" -> if member (w !! (i+1)) signs
				then Left ("Unexpected operator " ++ (w !! (i+1)))
				else Right (acc := N (w !! (i+1)))
		_ -> if member (w !!(i+1)) signs 
			then parse_words w (i+1) (if (i==0)
				then (N (w !! 0))
				else acc)
			else Left ("Expected operator instead of " ++ (w !! (i+1)))
main :: IO()
main = print (parse "SEND + MORE = MONEY")
