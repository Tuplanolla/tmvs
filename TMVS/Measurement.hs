module TMVS.Measurement where

import Data.Set (Set)
import TMVS.Common

type Measurement = Set (Measured (Uncertain Double))

data Measured a = Measured
  {measTime :: a,
   measSource :: Sourced a}
  deriving (Eq, Ord, Read, Show)

data Sourced a =
  TestLabbed (TLPointed a) |
  SmallWeatherStationed (WSPointed a) | LargeWeatherStationed (WSPointed a)
  deriving (Eq, Ord, Read, Show)

data TLPointed a = TLPointed
  {tlpSite :: Char,
   tlpRoom :: Int,
   tlpPlacement :: Placement,
   tlpOrdinal :: Int,
   tlpPosition :: Double,
   tlpMaterial :: Maybe Material,
   tlpQuantity :: Quantified a}
  deriving (Eq, Ord, Read, Show)

data WSPointed a = WSPointed
  {wspRegion :: Region,
   wspQuantity :: Quantified a}
  deriving (Eq, Ord, Read, Show)

data Quantified a =
  Temperatured a | RelativeHumid a | AbsoluteHumid a |
  Pressured a | WindSped a | Precipitated a
  deriving (Eq, Ord, Read, Show)
