% Enumeration constructor.
function i = tmvs_material(s)
switch tolower(s)
case {'mw', 'mineral wool'}
  j = 1;
case {'pur', 'polyurethane'}
  j = 2;
case {'eps', 'polystyrene'}
  j = 3;
otherwise
  error(sprintf('material ''%s'' not known', s));
end

i = int8(j);
end
