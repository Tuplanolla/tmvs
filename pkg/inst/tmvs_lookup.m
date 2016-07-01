% Find element or insertion position.

function [i, p] = tmvs_lookup (cds, id)

[i, j] = tmvs_search (cds, tmvs_hash (id));
p = false;

for k = i : j
  if isequaln (cds(k).id, id)
    i = k;
    p = true;

    break
  end
end

end
