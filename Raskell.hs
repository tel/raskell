{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Raskell (

  R, run,

  print, printStr,

  Var, new, get, put, modify, inc, dec,

  foreach, for, while, cond,

  ($), (<), (+), (-), (*), (/)

  ) where

import           Control.Applicative
import           Control.Monad       (void)
import           Data.Foldable       (Foldable)
import qualified Data.Foldable       as F
import qualified Data.IORef          as IORef
import qualified Data.Text           as T
import qualified Data.Text.IO        as Tio
import qualified Data.Traversable    as F
import           Prelude             (Bool (..), Eq, Functor, IO, Int, Monad,
                                      Show, return, undefined, ($), (*), (+),
                                      (-), (/), (<), (>), (>>), (>>=))
import qualified Prelude             as P



--- Basics
----------

newtype R a = R (IO a)
  deriving ( Functor, Applicative, Monad )

-- Sadly, we need to actually unwrap R to make `main` work.
run :: R a -> IO ()
run (R io) = void io



--- Types
---------

-- People expect fast, Utf8 strings. So we may as well wrap the real
-- thing.
newtype String = String (T.Text)



--- Effects
-----------

print :: Show a => a -> R ()
print a = R (P.print a)

printStr :: String -> R ()
printStr (String t) = R (Tio.putStr t)



--- Vars
--------

newtype Var a = Var (IORef.IORef a)
  deriving ( Eq )

new :: a -> R (Var a)
new a = Var <$> R (IORef.newIORef a)

get :: Var a -> R a
get (Var ref) = R (IORef.readIORef ref)

put :: a -> Var a -> R ()
put a (Var ref) = R (IORef.writeIORef ref a)

modify :: (a -> a) -> Var a -> R ()
modify f (Var ref) = R (IORef.modifyIORef' ref f)

inc :: Var Int -> R (Var Int)
inc v = modify (+1) v >> return v

dec :: Var Int -> R (Var Int)
dec v = modify (+ (-1)) v >> return v


--- Loops
---------

-- `Foldable` might look scary. Should we create a new class?

foreach :: Foldable enum => enum a -> (a -> R x) -> R ()
foreach = F.forM_

for :: (R (Var a), a -> Bool, Var a -> R z) -> (Var a -> R x) -> R ()
for (init, cont, step) go = init >>= loop where
  loop vi = do
    i <- get vi
    if cont i
      then go vi >> step vi >> loop vi
      else return ()


while :: R Bool -> R x -> R ()
while check go = do
  val <- check
  if val then go >> while check go else return ()



--- Utillities
--------------


-- Regular if is funky.

cond :: R Bool -> R a -> R a -> R a
cond check thn els = do
  val <- check
  if val then thn else els
