module Funcs where

import Data
import Data.List
import Data.Ord


printPlayers :: [Player] -> IO ()
printPlayers list = do
    putStrLn $ intercalate "\n" (map name list)

sortList :: [Player] -> [Player]
sortList list = sortOn (Down . skill) list

splitList :: [Player] -> ([Player], [Player])
splitList (x:y:xs) = (x : a, y : b)
    where (a, b) = splitList xs

selectPlayers :: [Player] -> IO [Player]
selectPlayers list = do
    putStrLn "Insira a lista de jogadores de hoje, com letras minusculas e seus nomes separados por espaço:"
    players_names <- getLine
    let players = words players_names
    let roster = filter(\pl -> elem (name pl) players) player_list
    
    putStrLn "Elenco do dia:"
    printPlayers roster
    
    return roster


