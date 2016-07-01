function a = tmvs_merge (a1, a2)

n = rows (a2);

for i = 1 : n
  a1 = tmvs_insert (a1, a2(i).id, a2(i).pairs);
end

a = a1;

end
