function interp = tmvs_interpolate (aggr, varargin)

names = fieldnames (arrays);

interp = struct ();
for i = 1 : length (names)
  name = names{i};

  array = arrays.(name);
  days = array(:, 1);
  x = array(:, 2);

  n = length (days);
  if n < 2
    error (sprintf ('not enough data points: %d'), n);
  end

  interp.(name) = struct ( ...
    'function', @(xi) interp1 (days, x, xi, varargin{:}), ...
    'limits', [(min (days)), (max (days))]);
end

end
