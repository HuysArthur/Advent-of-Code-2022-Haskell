data Moves = Rock | Paper | Scissors deriving Eq

decode :: Char -> Moves
decode 'A' = Rock
decode 'X' = Rock
decode 'B' = Paper
decode 'Y' = Paper
decode 'C' = Scissors
decode 'Z' = Scissors

win :: Moves -> Moves -> Bool
win Rock Paper = False
win Rock Scissors = True
win Paper Scissors = False
win Paper Rock = True
win Scissors Rock = False
win Scissors Paper = True

scoreMove :: Moves -> Int
scoreMove Rock = 1
scoreMove Paper = 2
scoreMove Scissors = 3

calculateScore :: String -> Int
calculateScore (encryptedOpponentMove:(_:encryptedOwnMove:[])) = do
    if opponentMove == ownMove
        then 3 + (scoreMove ownMove)
        else if win ownMove opponentMove
            then 6 + (scoreMove ownMove)
            else 0 + (scoreMove ownMove)
    where 
        opponentMove = decode encryptedOpponentMove
        ownMove = decode encryptedOwnMove

countScore :: Int -> IO ()
countScore score = do
    input <- getLine
    if input == "stop"
        then putStrLn (show score)
        else countScore (score + (calculateScore input))

run :: IO ()
run = do countScore 0