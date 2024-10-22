module Main where

import Data
import Funcs

main :: IO ()
main = do
    let elenco = selectPlayers player_list
    
    let roster = sortList elenco

    let times = splitList roster

    putStrLn "Time Preto"
    let black :: [Player]
        black = fst times
    printPlayers black

    putStrLn "Time Amarelo"
    let yellow :: [Player]
        yellow = snd times
    printPlayers yellow