module Funcs where

import Data
import Data.List
import Data.Ord
import Data.IORef


printPlayers :: [Player] -> IO () -- printa os jogadores de uma lista, botei pra printar a skill tb para testes, mas decidi deixar assim
printPlayers list = do
    putStrLn $ intercalate "\n" (map (\p -> name p ++ " - " ++ show (skill p)) list)

sortList :: [Player] -> [Player] -- func que ordena a lista de jogadores por skill, do maior para o menor
sortList [] = []
sortList list = sortOn (Down . skill) list 

selectPlayers :: IORef [Player] -> IO [Player] -- funcao que pega a lista de jogadores de hoje do banco de dados comparando com a lista de jogadores de hoje fornecida pelo usuario
selectPlayers playerListRef = do
    putStrLn "Insira a lista de jogadores de hoje, com letras minusculas e seus nomes separados por espaço:"
    players_names <- getLine
    let players = words players_names
    player_list <- readIORef playerListRef
    let roster = filter(\pl -> elem (name pl) players) player_list
    
    return roster

createTeams :: [Player] -> ([Player], [Player]) -- func que separa os times. tentei fazer de maneira alternada 1<-, 2->, 3->, 4 <... mas nao deu certo, estava funcionando de maneira alternada entao deixei assim
createTeams [] = ([], [])
createTeams (p : xs) =
    let (teamBlack, teamYellow) = createTeams xs
    in if length teamBlack <= length teamYellow
       then (p:teamBlack, teamYellow)
       else (teamBlack, p:teamYellow)


sumSkills :: [Player] -> Int -- somar as skills dos jogadores
sumSkills [] = 0
sumSkills players = sum (map skill players)


skillDiffSwap :: [Player] -> [Player] -> ([Player], [Player]) -- func que compara elementos das listas de baixo pra cima, trocando os primeiros que houver diferença de skill
skillDiffSwap [] [] = ([], []) -- após isso, checa se a diferença de skill diminuiu
skillDiffSwap blk ylw
    | abs (sumSkills blk - sumSkills ylw) <= 1 = (blk, ylw)  -- se a diferença for <= 1, para
    | skill (last blk) /= skill (last ylw) =  
        let newBlk = init blk ++ [last ylw]
            newYlw = init ylw ++ [last blk]
            diffBefore = abs (sumSkills blk - sumSkills ylw)
            diffAfter = abs (sumSkills newBlk - sumSkills newYlw)
        in if diffAfter < diffBefore  -- so troca se a diferença diminuir
           then skillDiffSwap newBlk newYlw
           else skillDiffSwap (init blk) (init ylw)  -- Continua recursivamente
    | otherwise =
        let (newBlk, newYlw) = skillDiffSwap (init blk) (init ylw)  -- Vai para os elementos anteriores
        in (newBlk ++ [last blk], newYlw ++ [last ylw])


createPlayer :: String -> Int -> Player
createPlayer name skill = Player {name = name, skill = skill}

addPlayer :: IORef [Player] -> Player -> IO () -- adiciona um jogador a uma lista de jogadores
addPlayer playerListRef player = modifyIORef playerListRef (player :)

-- funcoes que foram implementadas procurando soluções, mas não foram mais utilizadas

splitList :: [Player] -> [(Player, Player)] -- func que separa a lista de jogadores em tuplas de 2, não foi mais usada
splitList (x:y:xs) = (x, y) : splitList xs
splitList _ = []

printMatch :: [(Player, Player)] -> IO () -- funcao de teste para ver se a lista de tuplas estava sendo separada corretamente, nao foi mais usada
printMatch = mapM_ printPair
    where 
        printPair (a, b) = putStrLn $ "("++name a++","  ++ name b++")"

moveRight :: [Player] -> [Player] -- nao foi mais usada
moveRight list = last list : init list