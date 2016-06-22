% Enumeration constructor.
function i = tmvs_region(s)
switch tolower(s)
case 'autiolahti'
  j = 1;
case 'jyvaskyla'
  j = 2;
otherwise
  error(sprintf('region ''%s'' not known', s));
end

i = int8(j);
end
