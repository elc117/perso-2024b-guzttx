module Main where

import Data
import Menu
import Data.IORef

main :: IO ()
main = do
    playerListRef <- newIORef player_list
    lastGameRoster <- newIORef []
    menu playerListRef lastGameRoster