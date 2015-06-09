import Control.Concurrent
import Data.Time

import FlavoursMVar.Barrier
import FlavoursMVar.Lock
import FlavoursMVar.Once
import FlavoursMVar.Var


main :: IO ()
main = do
   tryLock
   tryVar
   tryBarrier
   tryOnce


-- No interleaved output even with buffering still allowed
tryLock :: IO ()
tryLock = do
   lock <- newLock
   let output = withLock lock . putStrLn
   forkIO $ do output "hello"
   forkIO $ do output "world"

   -- Keep program from exiting a little longer
   threadDelay 2000

   return ()


-- Thread-safe mutable variable
tryVar :: IO ()
tryVar = do
   hits <- newVar 0
   forkIO $ do modifyVar_ hits (return . (+ 1))

   -- Wait for the forked thread to do something
   threadDelay 2000

   i <- readVar hits
   print ("HITS", i)

   return ()


-- Blocking for completion
tryBarrier :: IO ()
tryBarrier = do
   bar <- newBarrier
   forkIO $ do
      threadDelay 1000000
      signalBarrier bar "foo"
   print =<< waitBarrier bar

   return ()


-- An action that gets performed exactly once
tryOnce :: IO ()
tryOnce = do
   oneTime <- once getCurrentTime

   print =<< oneTime
   print =<< oneTime
   print =<< oneTime

   return ()
