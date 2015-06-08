module FlavoursMVar.Barrier
   where

import Control.Concurrent.MVar


type Barrier a = MVar a


newBarrier :: IO (Barrier a)
newBarrier = newEmptyMVar


signalBarrier :: Barrier a -> a -> IO ()
signalBarrier = putMVar


waitBarrier :: Barrier a -> IO a
waitBarrier = readMVar
