module TMVS where

import Data.Set (Set)

type TMVS = Set (Measurement (Uncertain Double))

data Measurement a = Measurement
  {msmtTime :: a,
   msmtSource :: Source a}
  deriving (Eq, Ord, Read, Show)

data Source a =
  TestLab (TLPoint a) |
  SmallWeatherStation (WSPoint a) | LargeWeatherStation (WSPoint a)
  deriving (Eq, Ord, Read, Show)

data TLPoint a = TLPoint
  {tlpSite :: Char,
   tlpRoom :: Int,
   tlpDepth :: a,
   tlpPlacement :: Placement,
   tlpMaterial :: Material,
   tlpQuantity :: Quantity a}
  deriving (Eq, Ord, Read, Show)

data WSPoint a = WSPoint
  {wspCity :: City,
   wspQuantity :: Quantity a}
  deriving (Eq, Ord, Read, Show)

data Placement =
  Horizontal Level | Vertical Wall
  deriving (Eq, Ord, Read, Show)

data Material =
  MineralWool | Polystyrene | Polyurethane
  deriving (Eq, Ord, Read, Show)

data City =
  Autiolahti | Jyvaskyla
  deriving (Eq, Ord, Read, Show)

data Quantity a =
  Temperature a | RelativeHumidity a | AbsolutHumidity a |
  Pressure a | WindSpeed a | Precipitation a
  deriving (Eq, Ord, Read, Show)

data Level =
  Floor | Ceiling
  deriving (Eq, Ord, Read, Show)

data Wall =
  TopCorner | BottomCorner
  deriving (Eq, Ord, Read, Show)

data Uncertain a = Uncertain
  {uncnValue :: a,
   uncnError :: a}
  deriving (Eq, Ord, Read, Show)
