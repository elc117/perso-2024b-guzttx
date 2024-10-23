module Main where

import Data
import Funcs

main :: IO ()
main = do
    selecao <- selectPlayers player_list
    let elenco = selecao 
    
    --putStrLn "\n\nElenco do dia:"
    --printPlayers elenco
    
    let roster = sortList elenco
    putStrLn "\n\nElenco ordenado por habilidade:"
    printPlayers roster

    let times = splitList roster

    printMatch times

    let teams = createTeams times

    let (black, yellow) = teams
    printPlayers black
    printPlayers yellow
