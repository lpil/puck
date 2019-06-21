module Lib.Prelude
  ( module Protolude
  , map
  , concat
  , bind
  )
where

import Protolude hiding (concat, map)
import qualified Protolude as Hidden

-- Reclaim the good name
map :: Functor f => (a -> b) -> f a -> f b
map = Hidden.fmap

-- Reclaim the good name
concat :: Monoid a => [a] -> a
concat = Hidden.mconcat

-- A textual name for >>=
bind :: Monad m => (a -> m b) -> m a -> m b
bind f m = m >>= f
