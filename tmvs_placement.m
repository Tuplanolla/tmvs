% Enumeration constructor.
function i = tmvs_placement(s1, s2)
switch tolower(s1)
case {'w', 'wall'}
  switch tolower(s2)
  case {'tc', 'top corner'}
    j = 1;
  case {'bc', 'bottom corner'}
    j = 2;
  otherwise
    error(sprintf('wall placement ''%s'' not known', s2));
  end
case {'l', 'level'}
  switch tolower(s2)
  case {'f', 'floor'}
    j = 3;
  case {'c', 'ceiling'}
    j = 4;
  otherwise
    error(sprintf('level placement ''%s'' not known', s2));
  end
otherwise
  error(sprintf('placement ''%s'' not known', s1));
end

i = int8(j);
end
