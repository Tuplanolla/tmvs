% Enumeration constructor.
function i = tmvs_quantity(s)
switch tolower(s)
case {'t', 'temperature'}
  j = 1;
case {'rh', 'relative humidity'}
  j = 2;
case {'ah', 'absolute humidity'}
  j = 3;
case {'p', 'pressure'}
  j = 4;
case {'v', 'wind speed'}
  j = 5;
case {'h', 'precipitation'}
  j = 6;
otherwise
  error(sprintf('quantity ''%s'' not known', s));
end

i = int8(j);
end
