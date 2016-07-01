function a = tmvs_insert (a, id, pairs)

hash = tmvs_hash (id);

[i, p] = tmvs_lookup (a, id, hash);

if p
  a(i).pairs = sortrows (vertcat (a(i).pairs, pairs));
else
  a(i + 1 : end + 1) = a(i : end);
  a(i) = struct ('hash', hash, 'id', id, 'pairs', pairs);
end

end
