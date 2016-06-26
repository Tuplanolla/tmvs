function interps = tmvs_interpolate (arrays, method = 'linear')

names = fieldnames (arrays);

interps = struct ();
for i = 1 : length (names)
  name = names{i};

  array = arrays.(name);
  days = array(:, 1);
  x = array(:, 2);

  n = length (days);
  if n < 2
    error (sprintf ('not enough data points: %d'), n);
  end

  interps.(name) = struct ( ...
    'function', @(xi) interp1 (days, x, xi, method), ...
    'limits', [(min (days)), (max (days))]);
end

end
