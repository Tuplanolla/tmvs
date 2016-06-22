module TMVS where

import Data.Time

data Measurement = Measurement
  {source :: Source,
   quantity :: Quantity,
   time :: Observation UTCTime,
   observation :: Observation Double}
  deriving (Eq, Ord, Read, Show)

data Source = Building Laboratory | Station Location
  deriving (Eq, Ord, Read, Show)

data Laboratory = Laboratory
  {site :: Char,
   room :: Int,
   orientation :: Orientation,
   material :: Material,
   depth :: Double}
  deriving (Eq, Ord, Read, Show)

data Orientation = Horizontal Level | Vertical Wall
  deriving (Eq, Ord, Read, Show)

data Level = Floor | Ceiling
  deriving (Eq, Ord, Read, Show)

data Wall = High | Low
  deriving (Eq, Ord, Read, Show)

data Material = Wool | Styrene | Urethane
  deriving (Eq, Ord, Read, Show)

data Location = Autiolahti | Jyvaskyla
  deriving (Eq, Ord, Read, Show)

data Quantity = Temp | RelHum | AbsHum | Pressure | WindSpeed | Precip
  deriving (Eq, Ord, Read, Show)

data Observation a = Observation
  {value :: a,
   uncertainty :: a}
  deriving (Eq, Ord, Read, Show)
