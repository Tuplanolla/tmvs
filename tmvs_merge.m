function arrays = tmvs_merge(x, y)
names = [fieldnames(x); fieldnames(y)];

arrays = struct();
for i = 1 : length(names)
  name = names{i};

  arrays.(name) = sortrows([x.(name); y.(name)]);
end
end
