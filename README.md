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

Contributing
------------

Have any idea that will help make the code in `Test.hs` look more familiar to a `C` or 
`Ruby` programmer? Cool! Let's try it out! Please send a PR and if your contribution is 
sufficiently twisted I'll give you a commit bit posthaste.

Why?
----

(a.k.a. *oh sweet god, why would you do such a thing?*)

Raskell is not supposed to be a *good* language. It's not even supposed to be a way 
to learn Haskell.

To be honest, it's not even a *thing*. Just a thought experiment, really.

It's what happens when you strip away a lot of the power and generality that
Haskell allows and has explored via the standard libraries and ecosystem. In its place
we build the trappings of a pretty standard imperative language. Learning Raskell as 
someone familiar with C or Ruby might feel like learning "purity" and "immutability" 
directly, without also having to learn "functional".

Haskell-the-language does not really force you to use higher-order functions and fancy types
to get your work done. It's more the case that those tools are very powerful when you become 
familiar with them. But someone can still learn a lot from Haskell-the-language before they ever
start to learn those things. Maybe by building Raskell we can highlight those parts.
