module Menu where

import Data
import Data.List
import Data.Ord
import Data.IORef
import Funcs



menu :: IORef [Player] -> IORef [Player] -> IO ()
menu playerListRef lastGameRoster = do
    putStrLn "\n\nBem-vindo ao separador de times do Futebruxos!"
    putStrLn "\nEscolha uma opção:"
    putStrLn "\n1 - Dividir os times por habilidade"
    putStrLn "2 - Printar elenco original"
    putStrLn "3 - Printar elenco do ultimo jogo"
    putStrLn "4 - Sair"
    
    opcao <- getLine
    case opcao of
      "1" -> do
        putStrLn "Há algum jogador de fora do Futebruxos?s/n"
        opcao <- getLine

        if opcao == "s"
            then do
                putStrLn "Quantos?"
                n <- getLine
                addOutsiders playerListRef (read n :: Int)
            else
                putStrLn "Ok, separando lista."

        playerList <- selectPlayers playerListRef
        let roster = sortList playerList
        
        putStrLn "\nElenco ordenado por habilidade:"
        printPlayers roster
        
        let skills = sumSkills roster
        putStrLn $ "\nSoma das habilidades: " ++ show skills

        let (black, yellow) = createTeams roster
        let skillsBlack = sumSkills black
        let skillsYellow = sumSkills yellow

        if abs (skillsYellow - skillsBlack) <= 1
            then do
                putStrLn "\nTimes equilibrados:"
                putStrLn "\nTime Preto:"
                printPlayers black
                putStrLn "\nTime Amarelo:"
                printPlayers yellow
            else do
                putStrLn "\nTimes desequilibrados:"
                putStrLn "\nTime Preto:"
                printPlayers black
                putStrLn "\nTime Amarelo:"
                printPlayers yellow

                let (newBlack, newYellow) = skillDiffSwap black yellow
                putStrLn "\nTimes reorganizados:"
                putStrLn "\nTime Preto:"
                printPlayers newBlack
                putStrLn "\nTime Amarelo:"
                printPlayers newYellow

        writeIORef lastGameRoster roster

        menu playerListRef lastGameRoster

      "2" -> do
        putStrLn "\nPrintando jogadores do banco de dados:\n"
        playerList <- readIORef playerListRef
        printPlayers (sortList playerList)
        menu playerListRef lastGameRoster

      "3" -> do
        putStrLn "\nPrintando jogadores do último jogo:\n"
        ultimoJogo <- readIORef lastGameRoster
        printPlayers ultimoJogo
        menu playerListRef lastGameRoster


      "4" -> putStrLn "Saindo!"

      _ -> do
        putStrLn "Opção inválida!"
        menu playerListRef lastGameRoster
