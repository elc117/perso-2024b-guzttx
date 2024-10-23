module Funcs where

import Data
import Data.List
import Data.Ord


printPlayers :: [Player] -> IO ()
printPlayers list = do
    putStrLn $ intercalate "\n" (map name list)

sortList :: [Player] -> [Player]
sortList list = sortOn (Down . skill) list

splitList :: [Player] -> [(Player, Player)] -- correção na tipagem da função splitlist
splitList (x:y:xs) = (x, y) : splitList xs
splitList _ = []

selectPlayers :: [Player] -> IO [Player]
selectPlayers list = do
    putStrLn "Insira a lista de jogadores de hoje, com letras minusculas e seus nomes separados por espaço:"
    players_names <- getLine
    let players = words players_names
    let roster = filter(\pl -> elem (name pl) players) player_list
    
    return roster

createTeams :: [(Player, Player)] -> ([Player], [Player]) -- funcao vai ser alterada, pois a lógica de divisão não é justa com o segundo time
createTeams list = (blk, ylw) 
    where
        blk = map fst list
        ylw = map snd list

printMatch :: [(Player, Player)] -> IO () -- funcao de teste para ver se a lista de tuplas estava sendo separada corretamente
printMatch = mapM_ printPair
    where 
        printPair (a, b) = putStrLn $ name a ++ " x " ++ name b