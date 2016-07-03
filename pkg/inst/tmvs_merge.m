function aggr = tmvs_merge (aggr1, aggr2)

aggr = aggr1;

n = length (aggr2);

for i = 1 : n
  id = aggr2(i).id;

  j = tmvs_findid (aggr, id);

  if j
    aggr(j).pairs = [aggr(j).pairs; aggr2(i).pairs];
  else
    aggr(end + 1) = struct ('id', id, ...
                            'meta', aggr2(i).meta, ...
                            'pairs', aggr2(i).pairs);
  end
end

for i = 1 : length (aggr)
  [~, j] = unique (aggr(i).pairs(:, 1));
  aggr(i).pairs = aggr(i).pairs(j, :);
end

end
