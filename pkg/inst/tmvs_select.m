function saggr = tmvs_select (aggr, f)
% f : id*meta -> bool

names = fieldnames (arrays);

matches = struct ();
for i = 1 : length (names)
  name = names{i};

  if ~isempty (regexp (name, pat))
    matches.(name) = arrays.(name);
  end
end

end
