function i = tmvs_findid (aggr, id)

i = 0;

for j = 1 : numel (aggr)
  if isequaln (aggr(j).id, id)
    i = j;

    break
  end
end

end
