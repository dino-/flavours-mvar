module FlavoursMVar.Lock
   where

import Control.Concurrent.MVar


type Lock = MVar ()


newLock :: IO Lock
newLock = newMVar ()


withLock :: Lock -> IO a -> IO a
withLock x = withMVar x . const
