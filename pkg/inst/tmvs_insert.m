function cds = tmvs_insert (cds, id, pairs)

[i, p] = tmvs_lookup (cds, id);

if p
  cds(i) = struct ('hash', tmvs_hash (id), 'id', id, ...
    'pairs', sortrows (vertcat (cds(i).pairs, pairs)));
else
  cds(i + 1 : end + 1) = cds(i : end);
  cds(i) = struct ('hash', tmvs_hash (id), 'id', id, 'pairs', pairs);
end

end
