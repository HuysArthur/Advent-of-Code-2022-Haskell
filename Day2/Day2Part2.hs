data Moves = Rock | Paper | Scissors deriving Eq

decode :: Char -> Moves
decode 'A' = Rock
decode 'B' = Paper
decode 'C' = Scissors

win :: Moves -> Moves
win Rock = Paper
win Paper = Scissors
win Scissors = Rock

lose :: Moves -> Moves
lose Paper = Rock
lose Scissors = Paper
lose Rock = Scissors

scoreMove :: Moves -> Int
scoreMove Rock = 1
scoreMove Paper = 2
scoreMove Scissors = 3

calculateScore :: String -> Int
calculateScore (encryptedOpponentMove:(_:encryptedOwnMove:[])) = do
    if encryptedOwnMove == 'Y'
            then 3 + (scoreMove opponentMove)
            else if encryptedOwnMove == 'X'
                then 0 + (scoreMove (lose opponentMove))
                else 6 + (scoreMove (win opponentMove))
    where 
        opponentMove = decode encryptedOpponentMove

countScore :: Int -> IO ()
countScore score = do
    input <- getLine
    if input == "stop"
        then putStrLn (show score)
        else countScore (score + (calculateScore input))

run :: IO ()
run = do countScore 0