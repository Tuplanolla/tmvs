module TMVS.Common where

data Placement =
  Horizontal Level | Vertical Wall
  deriving (Eq, Ord, Read, Show)

data Material =
  MineralWool | Polystyrene | Polyurethane
  deriving (Eq, Ord, Read, Show)

data Region =
  Autiolahti | Jyvaskyla
  deriving (Eq, Ord, Read, Show)

data Level =
  Floor | Ceiling
  deriving (Eq, Ord, Read, Show)

data Wall =
  BottomCorner | TopCorner
  deriving (Eq, Ord, Read, Show)

data Uncertain a = Uncertain
  {uncValue :: a,
   uncError :: a}
  deriving (Eq, Ord, Read, Show)
