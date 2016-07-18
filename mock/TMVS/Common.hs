module TMVS.Common where

data Material =
  MineralWool | Polystyrene | Polyurethane
  deriving (Eq, Ord, Read, Show)

data Region =
  Autiolahti | Jyvaskyla
  deriving (Eq, Ord, Read, Show)

data Section =
  BottomCorner | TopCorner
  deriving (Eq, Ord, Read, Show)

data Uncertain a = Uncertain
  {uncValue :: a,
   uncError :: a}
  deriving (Eq, Ord, Read, Show)
