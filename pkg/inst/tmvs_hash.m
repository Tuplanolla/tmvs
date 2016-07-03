function k = tmvs_hash (s)

c = sort (fieldnames (s));

% This must be a prime number.
n = 31;

k = 1;

for i = 1 : length (c)
  x = s.(c{i});

  if isnumeric (x) && isfinite (x)
    k = mod (n * k + double (x), flintmax ());
  end
end

end
