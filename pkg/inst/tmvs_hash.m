function k = tmvs_hash (s)

% This is a prime number.
n = 31;

c = sort (fieldnames (s));

k = 1;

for i = 1 : numel (c)
  x = s.(c{i});

  if isnumeric (x) && isfinite (x)
    k = mod (n * k + double (x), flintmax ());
  end
end

end
