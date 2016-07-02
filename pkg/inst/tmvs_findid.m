function i = tmvs_findid (a, id)

for j = 1 : length (a)
  if isequaln (a(j).id, id)
    i = j;

    break
  end
end

i = 0;

end
