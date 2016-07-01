function k = tmvs_hash (id)

c = sort (fieldnames (id));

n = 31;
k = 1;

for i = 1 : length (c)
  x = id.(c{i});

  if isnumeric (x) && isfinite (x)
    k = mod (n * k + double (x), flintmax ());
  end
end

end
