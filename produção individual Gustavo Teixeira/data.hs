module Data where

data Player = Player 
    {
        name :: String,
        skill :: Int
    } deriving (Show) -- utilização do deriving para que o compilador implemente automaticamente as typeclasses, permitindo a impressão.

{- 
    DEFINIÇÃO DOS DADOS QUE SERÃO SALVOS NO PROGRAMA:
    Skill level: de 1 a 5, sendo 1 o nível mais baixo e 5 o mais alto
    Jogadores e skill level:
    Vitor, 1
    Gian, 1
    Arthur, 2
    Prestes, 2
    Canela, 3
    Caio, 3
    Righi, 3
    Fred, 3
    Biacchi, 3
    Juliano, 4
    Leo, 4
    Eduardo, 3
    Gustavo, 3
    Senna, 5
    Gabriel, 5
    Lorenzo, 5
    Guilherme, 4
    Pedro, 3

-}

player_list :: [Player]
player_list = 
    [   
        Player {name = "arthur", skill = 2},
        Player {name = "biacchi", skill = 3},
        Player {name = "canela", skill = 3},
        Player {name = "caio", skill = 3},
        Player {name = "eduardo", skill = 3},
        Player {name = "fred", skill = 3},
        Player {name = "gabriel", skill = 5},
        Player {name = "gian", skill = 1},
        Player {name = "guilherme", skill = 4},
        Player {name = "gustavo", skill = 3},
        Player {name = "juliano", skill = 4},
        Player {name = "leo", skill = 4},
        Player {name = "lorenzo", skill = 5},
        Player {name = "pedro", skill = 3},
        Player {name = "prestes", skill = 2},
        Player {name = "righi", skill = 3},
        Player {name = "senna", skill = 5},
        Player {name = "vitor", skill = 1}
    ]