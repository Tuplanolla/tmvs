module TMVS.Aggregate where

import Data.Array (Array)
import Data.Map (Map)
import TMVS.Common

type Aggregate = Map Id (Aggregated (Uncertain Double))

newtype Aggregated a = Aggregated
  {aggrPairs :: Array (Int, Int) (a, a)}
  deriving (Eq, Ord, Read, Show)

data Id = Id
  {idSource :: Source,
   idQuantity :: Quantity,
   idSite :: Maybe Char,
   idRoom :: Maybe Int,
   idPlacement :: Maybe Placement,
   idOrdinal :: Maybe Int,
   idPosition :: Maybe Double,
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
