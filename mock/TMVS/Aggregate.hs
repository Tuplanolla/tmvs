module TMVS.Aggregate where

import Data.Array (Array)
import Data.Map (Map)
import TMVS.Common

type Aggregate = Map Id (Aggregated (Uncertain Double))

data Aggregated a = Aggregated
  {aggrMeta :: Meta,
   aggrPairs :: Array (Int, Int) (a, a)}
  deriving (Eq, Ord, Read, Show)

data Id = Id
  {idSource :: Source,
   idQuantity :: Quantity,
   idSite :: Maybe Char,
   idSurface :: Maybe Surface,
   idRoom :: Maybe Int,
   idSection :: Maybe Section,
   idOrdinal :: Maybe Int,
   idRegion :: Maybe Region}
  deriving (Eq, Ord, Read, Show)

data Meta = Meta
  {idPosition :: Maybe Double,
   idMaterial :: Maybe Material}
  deriving (Eq, Ord, Read, Show)

data Source =
  TestLab | SmallWeatherStation | LargeWeatherStation
  deriving (Eq, Ord, Read, Show)

data Quantity =
  Temperature | RelativeHumidity | AbsoluteHumidity |
  Pressure | WindSpeed | Precipitation
  deriving (Eq, Ord, Read, Show)

data Surface =
  Wall | Floor | Ceiling
  deriving (Eq, Ord, Read, Show)
