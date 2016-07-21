function i = tmvs_sparsen (v, n)

if isempty (v)
  i = [];
elseif isvector (v)
  [m, k] = max (size (v));

  i = [1 : (1 + floor (m / n)) : m];

  j = ones (1, ndims (v));
  j(k) = numel (i);

  i = reshape (i, j);
else
  error ('wrong shape %dx%d', size (v));
end

end
