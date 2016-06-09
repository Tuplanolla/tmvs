function arrays = tmvs_merge(x, y)
names = [fieldnames(x); fieldnames(y)];

arrays = struct();
for i = 1 : length(names)
  name = names{i};

  a = isfield(x, name);
  b = isfield(y, name);

  if a && b
    arrays.(name) = sortrows([x.(name); y.(name)]);
  elseif a
    arrays.(name) = x.(name);
  elseif b
    arrays.(name) = y.(name);
  else
    error('law of excluded middle failed');
  end
end
end
