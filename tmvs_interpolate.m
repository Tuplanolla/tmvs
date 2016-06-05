function interps = tmvs_interpolate(arrays, method = 'linear')
fields = fieldnames(arrays);
interps = struct();
for k = [1 : length(fields)]
  field = fields{k};
  array = getfield(arrays, field);
  x = array(:, 1);
  y = array(:, 2);
  % TODO Ensure table not too short (zero or one element).
  n = length(x);
  if n < 2
    error(sprintf('not enough data points: %d'), n);
  end
  fun = @(time) interp1(x, y, time, method);
  bunch = struct('function', fun, 'limits', [min(x), max(x)]);
  interps = setfield(interps, field, bunch);
end
end

%!test
%! assert(true);
