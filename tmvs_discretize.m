function arrays = tmvs_discretize(interps, points = 100)
fields = fieldnames(interps);
arrays = struct();
for k = [1 : length(fields)]
  field = fields{k};
  interp = getfield(interps, field);
  fun = getfield(interp, 'function');
  lims = getfield(interp, 'limits');
  % TODO Ensure lims increasing and points positive.
  x = linspace(lims(1), lims(2), points)';
  y = fun(x);
  arrays = setfield(arrays, field, [x, y]);
end
end

%!test
%! assert(true);
