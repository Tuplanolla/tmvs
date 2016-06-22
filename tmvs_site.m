% Enumeration constructor.
function i = tmvs_site(s)
c = tolower(s);
if c < 'a' || c > 'z'
  error(sprintf('site ''%s'' not known', s));
else
  j = c - 'a';
end

i = int8(j);
end
