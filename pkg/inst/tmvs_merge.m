function a = tmvs_merge (a1, a2)

a = a1;

n = rows (a2);

for i = 1 : n
  id = a2(i).id;

  j = tmvs_findid (a, id);

  if j
    a(j).pairs = [a(j).pairs; a2(i).pairs];
  else
    a(end + 1) = struct ('id', id, 'meta', a2(i).meta, 'pairs', a2(i).pairs);
  end
end

i = 1;
for j = 1 : length (a)
  [~, k] = unique (a(j).pairs(:, 1));
  a(j).pairs = a(j).pairs(k, :);
end

end
