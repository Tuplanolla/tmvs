% Enumeration constructor.
function y = tmvs_room(x)
if ischar(x)
  n = str2double(x);
  if ~isindex(n)
    error(sprintf('room ''%s'' not known', x));
  else
    y = n;
  end

  y = int8(y);
elseif isindex(x)
  y = sprintf('%d', x);
else
  error(sprintf('wrong type ''%s''', class(x)));
end
end
