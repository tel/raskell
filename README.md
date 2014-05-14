Raskell
=======

Impera-Haskell, Raskell.

Nwf noted at a recent Baltimore Haskell Meetup that there's a big difference between Haskell-the-language and Haskell-the-language-and-the-Standard-Prelude. In fact, it's been long said that Haskell might be one of the very best *imperative* languages ever written, though it's a bit of a challenge to see it at first.

So enter *Raskell*.

Raskell is a new "language" based loosely on Haskell+Prelude but aiming to emphasize the imperative nature of base Haskell. Everything lives in a monad, mutable cells run wild, `for` is more common than `map`. There may even be some kind of exception or continuation-based program flow rejiggering like `redo` or `yield`. Who knows?

The idea should be that all a user needs to do in order to enter bizarro-world Haskell is

```haskell
{-# LANGUAGE NoImplicitPrelude #-}

module Bizarro where

import Raskell

main = run $ do
  {- program here ... -}
```
