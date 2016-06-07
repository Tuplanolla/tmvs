function matches = tmvs_filter(arrays, pat)
names = fieldnames(arrays);

matches = struct();
for i = 1 : length(names)
  name = names{i};

  if ~isempty(regexp(name, pat))
    matches.(name) = arrays.(name);
  end
end
end
