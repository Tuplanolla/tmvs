module TMVS where

import Data.Map (Map)
import Data.Set (Set)
import Data.Vector (Vector)

type Collection = Map Id (Collected (Uncertain Double))

data Collected a = Collected
  {collTimes :: Vector a,
   collQuantities :: Vector a}
  deriving (Eq, Ord, Read, Show)

data Id = Id
  {idSource :: Source,
   idSite :: Maybe Char,
   idRoom :: Maybe Int,
   idDepth :: Maybe Double,
   idPlacement :: Maybe Placement,
   idMaterial :: Maybe Material,
   idCity :: Maybe City}
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
  {wspCity :: City,
   wspQuantity :: Quantified a}
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
