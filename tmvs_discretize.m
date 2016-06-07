function arrays = tmvs_discretize(interps, n = 100)
names = fieldnames(interps);

arrays = struct();
for i = [1 : length(names)]
  name = names{i};

  interp = interps.(name);

  limits = interp.limits;
  days = linspace(limits(1), limits(2), n)';
  arrays.(name) = [days, interp.function(days)];
end
end
