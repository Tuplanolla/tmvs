% Find element or insertion position.

function [i, p] = tmvs_lookup (a, id, hash = tmvs_hash (id))

[i, j] = tmvs_search (a, hash);
p = false;

for k = i : j
  % TODO Dirty speed hack!
  % if isequaln (a(k).id, id)
  if a(k).hash == hash
    i = k;
    p = true;

    break
  end
end

end
