% Enumeration constructor.
function i = tmvs_source(s)
switch tolower(s)
case {'tl', 'test lab'}
  j = 1;
case {'sws', 'small weather station'}
  j = 2;
case {'lws', 'large weather station'}
  j = 3;
otherwise
  error(sprintf('source ''%s'' not known', s));
end

i = int8(j);
end
