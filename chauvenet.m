% Chauvenet's criterion, returning indices of [inliers, outliers].
% Expects vector, returns same shape.
function [i, o] = chauvenet (x, mu = mean (x), sigma = std (x))

if ~isvector (x)
  error ('input is not a vector');
end

if sigma == 0
  i = ones (size (x));
  o = [];
else
  n = length (x);

  if iscolumn (x)
    i = nan (n, 1);
    o = nan (n, 1);
  else
    i = nan (1, n);
    o = nan (1, n);
  end

  k = 0;
  for j = 1 : n
    p = 2 * n * normcdf (-abs (x(j) - mu) / sigma);
    if p < 0.5
      o(j - k) = j;
    else
      k = k + 1;
      i(k) = j;
    end
  end

  if iscolumn (x)
    i = resize (i, k, 1);
    o = resize (o, j - k, 1);
  else
    i = resize (i, 1, k);
    o = resize (o, 1, j - k);
  end
end

end
