function aggr = tmvs_merge (varargin)

aggr = struct ('id', {}, 'meta', {}, 'pairs', {});

for i = 1 : numel (varargin)
  aggri = varargin{i};

  for j = 1 : numel (aggri)
    id = aggri(j).id;

    k = tmvs_findid (aggr, id);

    if k
      aggr(k).pairs = [aggr(k).pairs; aggri(j).pairs];
    else
      aggr(end + 1) = struct ('id', id, ...
                              'meta', aggri(j).meta, ...
                              'pairs', aggri(j).pairs);
    end
  end
end

for i = 1 : numel (aggr)
  [~, k] = unique (aggr(i).pairs(:, 1));
  aggr(i).pairs = aggr(i).pairs(k, :);
end

end
