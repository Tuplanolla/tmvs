function c = tmvs_merge (c, d)

n = rows (d);

for i = 1 : n
  c = tmvs_insert (c, d{i, 1}, d{i, 2});
end

end
