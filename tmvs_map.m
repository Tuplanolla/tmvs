function results = tmvs_map(func, arrays)
names = fieldnames(arrays);

results = struct();
for i = 1 : length(names)
  name = names{i};

  results.(name) = func(arrays.(name));
end
end
