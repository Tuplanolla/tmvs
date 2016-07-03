function i = tmvs_findid (aggr, id)

for j = 1 : length (aggr)
  if isequaln (aggr(j).id, id)
    i = j;

    break
  end
end

i = 0;

end
