import Control.Concurrent

import FlavoursMVar.Lock

main :: IO ()
main = do
   tryLock

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
