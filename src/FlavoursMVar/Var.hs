module FlavoursMVar.Var
   where

import Control.Concurrent.MVar


type Var a = MVar a


newVar :: a -> IO (Var a)
newVar = newMVar


modifyVar :: Var a -> (a -> IO (a, b)) -> IO b
modifyVar = modifyMVar


modifyVar_ :: Var a -> (a -> IO a) -> IO ()
modifyVar_ = modifyMVar_


readVar :: Var a -> IO a
readVar = readMVar
