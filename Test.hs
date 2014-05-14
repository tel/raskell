{-# LANGUAGE NoImplicitPrelude #-}

module Test where

import           Raskell


main = run $ do
  i <- new 0
  
  -- This syntax is weird, but we can't bind a name 
  -- in the variable initialization "slot" and so instead need to pass the
  -- "variable" in via a lambda binding. Also, note the difference between 
  -- `(<2)` and `inc` right now: one runs in `R` and the other doesn't. By 
  -- imperative standard they should *both* run nicely in `R` but then we
  -- have *even more* excess bindings. At least this looks fairly clean.
  for (new 0, (<20), inc) $ \j -> do
    inc i
    o <- get i
    print o
  o <- get i
  print o
