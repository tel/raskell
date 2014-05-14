{-# LANGUAGE NoImplicitPrelude #-}

module Test where

import           Raskell


main = run $ do
  i <- new 0
  for (new 0, (<20), inc) $ \j -> do
    inc i
    o <- get i
    print o
  o <- get i
  print o
