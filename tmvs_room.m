% Enumeration constructor.
function i = tmvs_room(s)
n = str2double(s);
if ~isindex(n)
  error(sprintf('room ''%s'' not known', s));
else
  j = n;
end

i = int8(j);
end
