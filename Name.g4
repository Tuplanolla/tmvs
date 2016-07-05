grammar Name ;

Character : ~[\t ] ;
Space : [\t ]+ ;
Break : [\r\n]+ ;

id : (building | station) ;

building : buildingCoarse separator buildingFine ;
station : stationCoarse separator stationFine ;

buildingCoarse : name site surface room (Space 'Meta')? ;
separator : Space '-' Space ;
buildingFine :
  shortQuantity room Space section ordinal Space
  position (Space element)? | special ;
stationCoarse : region Space kind ;
stationFine : longQuantity (Space garbage)? ;

name : testLab ;
site : letter ;
surface : wall | floor | ceiling ;
room : number ;
shortQuantity :
  shortTemperature | shortRelativeHumidity | shortAbsoluteHumidity ;
section : verticalSection | horizontalSection ;
ordinal : number ;
position : number millimetre ;
element : number Space? material ;
special : magicNumber ;
region : autiolahti | jyvaskyla ;
kind : weatherStation ;
longQuantity :
  (longPrefix Space?)*
  (longTemperature | longRelativeHumidity | longAbsoluteHumidity |
   longPressure | longWindSpeed | longPrecipitation)
  (Space? longSuffix)* ;
garbage : .+? ;

testLab : 'KoeRak' ;
letter :
  'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G' | 'H' | 'I' |
  'J' | 'K' | 'L' | 'M' | 'N' | 'O' | 'P' | 'Q' | 'R' |
  'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z' ;
wall : 'S' ;
floor : 'L' ;
ceiling : 'K' ;
number : ('0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9')+ ;
shortTemperature : 'T' ;
shortRelativeHumidity : 'RH' ;
shortAbsoluteHumidity : 'AH' ;
verticalSection : bottomCorner | topCorner ;
horizontalSection : centerFloor | centerCeiling ;
millimetre : 'mm' ;
material : mineralWool | polystyrene | polyurethane ;
magicNumber : 'lisa140' ;
autiolahti : ('A' | 'a') 'utiolah' ('ti' | 'den') ;
jyvaskyla : ('J' | 'j') 'yv' . 'skyl' . 'n'? ;
weatherStation : ('S' | 's') . . Space? (('A' | 'a') 'sema')? ;
longPrefix :
  ('I' | 'i') 'lman' | ('U' | 'u') 'lko' |
  ('V' | 'v') 'allitseva' | ('Y' | 'y') 'mp' . 'rist' . 'n' ;
longTemperature : ('L' | 'l') . 'mp' . Space? ('T' | 't') 'ila' ;
longRelativeHumidity :
  (('S' | 's') 'uhteellinen' Space?)? ('K' | 'k') 'osteus'
  (Space? ('P' | 'p') 'rosentti')? ;
longAbsoluteHumidity : ('A' | 'a') 'bsoluuttinen' Space? ('K' | 'k') 'osteus' ;
longPressure : ('P' | 'p') 'aine' ;
longWindSpeed : ('T' | 't') 'uul' ('i' | 'en') (Space? ('N' | 'n') 'opeus')? ;
longPrecipitation :
  ('S' | 's') ('ade' | 'ateen') (Space? ('M' | 'm') . . 'r' .)? ;
longSuffix : ('A' | 'a') 'rvo' | ('M' | 'm') 'ittaus' ;

bottomCorner : 'A' ;
topCorner : 'Y' ;
centerFloor : 'L' 'at'? ;
centerCeiling : 'K' 'at'? ;
mineralWool : ('V' | 'v') 'illa' ;
polystyrene : 'EPS' ;
polyurethane : 'PUR' ;
