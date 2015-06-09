module FlavoursMVar.Once
   where

import Control.Monad

import FlavoursMVar.Barrier
import FlavoursMVar.Var


once :: IO a -> IO (IO a)
once act = do
   var <- newVar Nothing
   return $ join $ modifyVar var $ \v -> case v of
      Nothing -> do
         b <- newBarrier
         return
            ( Just b
            , do
               x <- act
               signalBarrier b x
               return x
            )
      Just b -> return (Just b, waitBarrier b)
