insertList :: Int -> [Int] -> [Int]
insertList x [] = [x]
insertList x (head:tail) = 
    if x < head
        then (x:(head:tail))
        else (head:(insertList x tail))

sortList :: [Int] -> [Int]
sortList [] = []
sortList (head:tail) = insertList head (sortList tail)

top3MostAmountCalories :: Int -> [Int] -> IO ()
top3MostAmountCalories currentAmount (head:tail) = do
    input <- getLine
    if input == "stop"
        then putStrLn ("The top three elves with the most amount of calories are carrying a total of: " ++ (show (sum (head:tail))) ++ " calories.")
        else if input == ""
            then top3MostAmountCalories 0 (head:tail)
            else top3MostAmountCalories
            (currentAmount + (read input :: Int))
            (sortList ((if (currentAmount + (read input :: Int)) > head
                then (currentAmount + (read input :: Int))
                else head):tail))

run :: IO ()
run = do
    top3MostAmountCalories 0 [0, 0, 0]
    