grammar CSV;

Value : ~('\n' | '\r' | '|' | '"')+ ;
Delimiter : '|' ;
Quote : '"' ('""' | ~'"')* '"' ;
Break : '\r\n' | '\n' | '\r' ;

csv : record* ;
record : field (Delimiter field)* Break ;
field : Quote | Value? ;
