module TMVS where

import Data.Array (Array)
import Data.Map (Map)
import Data.Set (Set)

type Collection = Map Id (Collected (Uncertain Double))

newtype Collected a = Collected
  {collPairs :: Array (Int, Int) (a, a)}
  deriving (Eq, Ord, Read, Show)

data Id = Id
  {idSource :: Source,
   idQuantity :: Quantity,
   idSite :: Maybe Char,
   idRoom :: Maybe Int,
   idDepth :: Maybe Double,
   idPlacement :: Maybe Placement,
   idMaterial :: Maybe Material,
   idRegion :: Maybe Region}
  deriving (Eq, Ord, Read, Show)

data Source =
  TestLab | SmallWeatherStation | LargeWeatherStation
  deriving (Eq, Ord, Read, Show)

data Quantity =
  Temperature | RelativeHumidity | AbsoluteHumidity |
  Pressure | WindSpeed | Precipitation
  deriving (Eq, Ord, Read, Show)

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
   tlpDepth :: Double,
   tlpPlacement :: Placement,
   tlpMaterial :: Material,
   tlpQuantity :: Quantified a}
  deriving (Eq, Ord, Read, Show)

data WSPointed a = WSPointed
  {wspRegion :: Region,
   wspQuantity :: Quantified a}
  deriving (Eq, Ord, Read, Show)

data Placement =
  Horizontal Level | Vertical Wall
  deriving (Eq, Ord, Read, Show)

data Material =
  MineralWool | Polystyrene | Polyurethane
  deriving (Eq, Ord, Read, Show)

data Region =
  Autiolahti | Jyvaskyla
  deriving (Eq, Ord, Read, Show)

data Quantified a =
  Temperatured a | RelativeHumid a | AbsoluteHumid a |
  Pressured a | WindSped a | Precipitated a
  deriving (Eq, Ord, Read, Show)

data Level =
  Floor | Ceiling
  deriving (Eq, Ord, Read, Show)

data Wall =
  TopCorner | BottomCorner
  deriving (Eq, Ord, Read, Show)

data Uncertain a = Uncertain
  {uncValue :: a,
   uncError :: a}
  deriving (Eq, Ord, Read, Show)
