{-
    Produção individual em Haskell - Paradigmas da Programação 2024/2
    Aluno: Gustavo Machado Teixeira
    Projeto: Separador de times de futebol baseado em habilidade
-}

module Data where

data Player = Player 
    {
        name :: String,
        pos :: (Int, Int),
        skill :: Int
    } deriving (Show) -- utilização do deriving para que o compilador implemente automaticamente as typeclasses, permitindo a impressão.

{- 
    DEFINIÇÃO DOS DADOS QUE SERÃO SALVOS NO PROGRAMA:
    Posições: 1 - Zagueiro, 2 - Ala, 3 - Meio-campista, 4 - Atacante, 0 - Sem posição secundária.
    Skill level: de 1 a 5, sendo 1 o nível mais baixo e 5 o mais alto
    Jogadores, suas posições(primaria, secundaria) e skill level:
    Vitor (1, 2), 1
    Gian (1, 4), 1
    Arthur, (1, 0), 2
    Prestes, (1, 0), 2
    Canela, (1, 2), 3
    Caio, (1, 2), 3
    Righi, (1, 2), 3
    Fred, (2, 1), 3
    Biacchi, (2, 1), 3
    Juliano, (2, 3), 4
    Leo, (2, 3), 4
    Eduardo(2, 4), 3
    Gustavo(2, 4), 3
    Senna(3, 2), 5
    Gabriel(3, 2), 5
    Lorenzo(3, 4), 5
    Guilherme(4, 3), 4
    Pedro(4, 2), 3

-}

player_list :: [Player]
player_list = 
    [   
        Player {name = "arthur", pos = (1, 0), skill = 2},
        Player {name = "biacchi", pos = (2, 1), skill = 3},
        Player {name = "canela", pos = (1, 2), skill = 3},
        Player {name = "caio", pos = (1, 2), skill = 3},
        Player {name = "eduardo", pos = (2, 4), skill = 3},
        Player {name = "fred", pos = (2, 1), skill = 3},
        Player {name = "gabriel", pos = (3, 2), skill = 5},
        Player {name = "gian", pos = (1, 4), skill = 1},
        Player {name = "guilherme", pos = (4, 3), skill = 4},
        Player {name = "gustavo", pos = (2, 4), skill = 3},
        Player {name = "juliano", pos = (2, 3), skill = 4},
        Player {name = "leo", pos = (2, 3), skill = 4},
        Player {name = "lorenzo", pos = (3, 4), skill = 5},
        Player {name = "pedro", pos = (4, 2), skill = 3},
        Player {name = "prestes", pos = (1, 0), skill = 2},
        Player {name = "righi", pos = (1, 2), skill = 3},
        Player {name = "senna", pos = (3, 2), skill = 5},
        Player {name = "vitor", pos = (1, 2), skill = 1}
    ]