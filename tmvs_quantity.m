% Enumeration constructor.
function y = tmvs_quantity(x)
if ischar(x)
  switch tolower(x)
  case {'t', 'temperature'}
    y = 1;
  case {'rh', 'relative humidity'}
    y = 2;
  case {'ah', 'absolute humidity'}
    y = 3;
  case {'p', 'pressure'}
    y = 4;
  case {'v', 'wind speed'}
    y = 5;
  case {'h', 'precipitation'}
    y = 6;
  otherwise
    error(sprintf('quantity ''%s'' not known', x));
  end

  y = int8(y);
elseif isindex(x)
  switch x
  case 1
    y = 'temperature';
  case 2
    y = 'relative humidity';
  case 3
    y = 'absolute humidity';
  case 4
    y = 'pressure';
  case 5
    y = 'wind speed';
  case 6
    y = 'precipitation';
  otherwise
    error(sprintf('quantity %d not known', x));
  end
else
  error(sprintf('wrong type ''%s''', class(x)));
end
end
