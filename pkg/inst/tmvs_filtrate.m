% TODO Maybe go higher-order here.
function faggr = tmvs_filtrate (aggr, f)
% f : double*double -> bool

names = fieldnames (arrays);

matches = struct ();
for i = 1 : length (names)
  name = names{i};

  if ~isempty (regexp (name, pat))
    matches.(name) = arrays.(name);
  end
end

end
