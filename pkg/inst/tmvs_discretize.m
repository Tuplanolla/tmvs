function aggr = tmvs_discretize (interp, n = 100)

names = fieldnames (interp);

aggr = struct ();
for i = 1 : length (names)
  name = names{i};

  interp = interp.(name);

  limits = interp.limits;
  days = linspace (limits(1), limits(2), n)';
  aggr.(name) = [days, (interp.function (days))];
end

end
