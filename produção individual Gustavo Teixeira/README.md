# perso-2024b-guzttx
perso-2024b-guzttx created by GitHub Classroom

# Separador de times baseado em habilidade utilizando listas em haskell
## _by Gustavo Teixera, em Haskell_

##### Produção individual - Paradigmas da Programação
##### Professora: Andrea Schwertner Charão


## Features

- Utilização de tipo de dados customizado "Player"
- Utilização de "Banco de dados" integrado ao programa
- Separação lógica dos times baseada no nível de habilidade dos jogadores
- Manipulação de listas
- Manipulação e decomposição de tuplas
- Recursão, muita recursão

## Início do projeto

O início da minha implementação se deu em dois passos base:
- Definir o tipo de dado "Player" que seria usado no programa
- Definir o "banco de dados" integrado ao programa

Esses foram passos bem simples, só adicionei a apresentação para mostrar a estruturação do dado mesmo
```sh
data Player = Player 
    {
        name :: String,
        skill :: Int
    } deriving (Show) -- utilização do deriving para que o compilador implemente automaticamente as typeclasses, permitindo a impressão.
```
```sh
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
```

## Principais entraves

Algumas das dificuldades mais impactantes foram:

- Como passar uma lista unica como entrada, para que o programa conseguisse reconhecer as informações do banco de dados?
- Como implementar os loops?
- Como separar os times de maneira justa?
- Como fazer um menu switch/case em haskell?


#### Passando a lista como entrada

A primeira grande dúvida que tive, foi como passar a lista de jogadores do dia de maneira única e de forma que o programa conseguisse filtrar as informações de maneira direta do banco de dados. Aqui, ao pesquisar encontrei a função words, que divide uma string em uma lista de palavras, além de filtrar espaços vazios entre elas. Com isso, implementei a função selectPlayers, usando words, filter e elem. A função seleciona os jogadores no banco de dados a partir dos nomes fornecidos como entrada pelo usuario.

```sh
selectPlayers :: [Player] -> IO [Player]
selectPlayers list = do
    putStrLn "Insira a lista de jogadores de hoje, com letras minusculas e seus nomes separados por espaço:"
    players_names <- getLine
    let players = words players_names
    let roster = filter(\pl -> elem (name pl) players) player_list
    
    putStrLn "Elenco do dia:"
    printPlayers roster
    
    return roster
````

#### Como implementar loops em haskell?
Aqui passei meu primeiro perrengue. Para dividir os times, inicialmente eu havia pensado em distribuir os jogadores de maneira alternada entre eles. Entao implementei a função splitList, que utiliza da recursão para transformar a lista em de elementos em uma lista de tuplas. Entretanto, até entender como utilizar da recursão e como escrever o código para que funcionasse da maneira que eu queria, demorei um certo tempo, já que envolvia a manipulação de uma lista.
```sh
splitList :: [Player] -> [(Player, Player)]
splitList (x:y:xs) = (x, y) : splitList xs
splitList _ = []
```
Após a lista de tuplas ser criada, eu utilizava das funções map, fst e snd para separar os times e armazená-los em outras variáveis com a função createTeams
```sh
createTeams :: [(Player, Player)] -> ([Player], [Player]) -- funcao vai ser alterada, pois a lógica de divisão não é justa com o segundo time
createTeams list = (blk, ylw) 
    where
        blk = map fst list
        ylw = map snd list
````
Após, usava da decomposição de tuplas para que fosse possível manipular os times no escopo principal:
```sh
 let teams = createTeams times
 let (black, yellow) = teams
````

Com isso, o protótipo incial do programa estava pronto, mas ao testar encontrei um grande problema. Os times não ficavam equilibrados de maneira consistente.

#### Como separar os times de maneira justa e consistente?
A minha primeira ideia para separar as equipes de maneira justa foi ordenar a lista de maneira decrescente baseado no nivel de skill, e alternar os jogadores entre as equipes, entretanto, ao testar eu reparava que as diferenças nos niveis de habilidade ficavam muito grande algumas vezes

```sh
Elenco ordenado por habilidade:
lorenzo - 5
senna - 5
juliano - 4 
biacchi - 3
gustavo - 3
arthur - 2

Time preto:
lorenzo - 5
juliano - 4 -- soma 12
gustavo - 3

Time amarelo
senna - 5
biacchi - 3 -- soma 10
arthur - 2
```
Como podemos ver, a soma das habilidades tinha uma diferença maior que 1, que é a diferença máxima estipulada para um jogo ser parelho. Isso acontecia por que o segundo time sempre recebia um jogador mais fraco que o primeiro, como podemos ver na linha 2 e 3 ce cada time, onde o time preto recebe um atleta nivel 4 e o amarelo um nivel 3, acontecendo a mesma diferença na linha seguinte. A solução que pensei inicialmente foi forçar o último jogador a ir para o time 1. Tentei fazer isso empurrando ele para o início e assim dividindo os times por par. No entanto nada que eu fazia funcionava adequadamente, então resolvi tentar outra coisa.

A lógica adequada que eu encontrei para resolver o problema foi separar os times da seguinte maneira:
Primeira separação: Time preto recebe 1 jogador, time amarelo recebe os dois seguintes
Segunda separação: Time preto recebe os 2 jogadores seguintes, time amarelo recebe o próximo 
e alternar dessa maneira até os 14 jogadores estarem separados adequadamente

Assim, cheguei nesse corpo de função

```sh
createTeams :: [Player] -> ([Player], [Player])
createTeams [] = ([], [])
createTeams (p1:p2 : xs) =
    let(teamBlack, teamYellow) = createTeams xs
    in  if length teamBlack == ((length teamYellow) + 1)
        then (p1:teamYellow, p2:teamBlack)
        else (p1:teamBlack, p2:teamYellow)
````

No entanto, ela não funcionava da maneira desejada, e apenas separava de maneira alternada. Tentei voltar para a lógica de separar os pares alternadamente como anteriormente, alternando o then para:
```sh
        then (p1:teamBlack, p2:teamBlack)
        else (p1:teamYellow, p2:teamYellow)
````
Mas aí a função funcionava ainda pior, então acabei mantendo a função alternando os jogadores entre os times, e essa foi a versão final:
```sh
createTeams :: [Player] -> ([Player], [Player]) -- func que separa os times. tentei fazer de maneira alternada 1<-, 2->, 3->, 4 <... mas nao deu certo, estava funcionando de maneira alternada entao deixei assim
createTeams [] = ([], [])
createTeams (p : xs) =
    let (teamBlack, teamYellow) = createTeams xs
    in if length teamBlack <= length teamYellow
       then (p:teamBlack, teamYellow)
       else (teamBlack, p:teamYellow)
````
A resolução que eu consegui pensar foi criar uma função que trocasse os jogadores recursivamente da parte de baixo das listas caso eles tivessem niveis de skill diferentes para equilibrar os times. Com isso, pensei na skillDiffSwap
```sh
skillDiffSwap [] [] = ([], [])
skillDiffSwap blk ylw
    | skill (last blk) /= skill (last ylw) =  
        (init blk ++ [last ylw], init ylw ++ [last blk])
    | otherwise =
        let (newBlk, newYlw) = skillDiffSwap (init blk) (init ylw) 
        in (newBlk ++ [last blk], newYlw ++ [last ylw])
````
Entretanto, para fazer isso de maneira eficiente eu deveria fazer uma verificação de se os times tinham diferenças de skill level maiores do que a ideal entre si, então, com a ajuda do GPT a função ficou assim:
```sh
sumSkills :: [Player] -> Int -- somar as skills dos jogadores
sumSkills [] = 0
sumSkills players = sum (map skill players)


skillDiffSwap :: [Player] -> [Player] -> ([Player], [Player]) -- func que compara elementos das listas de baixo pra cima, trocando os primeiros que houver diferença de skill após isso, checa se a diferença de skill diminuiu
skillDiffSwap [] [] = ([], [])após isso, checa se a diferença de skill diminuiu
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
````
Aqui pedi ajuda para a IA pois estava tendo bastante dificuldade em compreender como fazer algo que fosse parecido com um "while" usando haskell.
Após isso, os maiores problemas estavam resolvidos, restava apenas fazer o menu.

#### Adição de funcionalidade.
Antes de fazer o menu, me lembrei de uma situação muito comum nas partidas, que é a presença de jogadores de fora do time, dessa maneira, decidi implementar soluções para isso. Criei as funções createPlayer e addPlayer
```sh
createPlayer :: String -> Int -> Player
createPlayer name skill = Player {name = name, skill = skill}

addPlayer :: [Player] -> Player -> [Player]
addPlayer list player = player : list
````
Testei as funções e elas estavam funcionando, assim, prossegui para o menu.

#### Crição do Menu.
Aqui eu estava confuso pois achava que nao tinha nada parecido com switch em haskell, mas foi algo bem simples de achar e se fazer.Assim, usando case eu estruturei o menu do meu programa.

```sh
menu :: [Player] -> IO ()
menu playerListRef lastGameRoster = do
    putStrLn "\n\nBem-vindo ao separador de times do Futebruxos!"
    putStrLn "\nEscolha uma opção:"
    putStrLn "\n1 - Dividir os times por habilidade"
    putStrLn "2 - Printar elenco original"
    putStrLn "3 - Printar elenco do ultimo jogo"
    putStrLn "4 - Sair"
    
    opcao <- getLine
    case opcao of
````

Aqui, tudo parecia finalizado. No entanto, ao testar, nada funcionava, pois eu não achava maneira apropriada de adicionar um jogador criado a lista de jogadores para usá-la no resto do programa, então fui pesquisar. Assim, descobri o IORef, que permite utilizar de uma lista que seja manipulável durante a execução do programa e fique disponível "globalmente". Com isso, fiz as alterações necessárias e tudo correu bem.
```sh
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
        putStrLn "Há algum jogador de fora do Futebruxos? (s/n)"
        opcao <- getLine

        if opcao == "s"
            then do
                putStrLn "Digite o nome do jogador:"
                nome <- getLine
                putStrLn "Digite a habilidade do jogador:"
                habilidade <- getLine
                let newGuy = createPlayer nome (read habilidade :: Int)
                
                addPlayer playerListRef newGuy
                putStrLn "Jogador adicionado com sucesso!"
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
````

Gostei bastante de fazer o trabalho, mesmo tendo quebrado a cabeça inúmeras vezes para resolver os problemas, pois as vezes parecia que nada fosse possível de resolver os erros de execução. Desafiador e divertido!


