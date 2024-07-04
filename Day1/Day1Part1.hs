mostAmountCalories :: Int -> Int -> IO ()
mostAmountCalories currentAmount highestAmount = do
    input <- getLine
    if input == "stop"
        then putStrLn ("The elf with the most amount of calories is carrying a total of: " ++ (show highestAmount) ++ " calories.")
        else if input == ""
            then mostAmountCalories 0 highestAmount
            else mostAmountCalories (currentAmount + (read input :: Int)) (if (currentAmount + (read input :: Int)) > highestAmount then (currentAmount + (read input :: Int)) else highestAmount)

run :: IO ()
run = do
    mostAmountCalories 0 0
    