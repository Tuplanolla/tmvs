% TODO This is shit.

function a = tmvs_merge (a1, a2)

a = a1;

n = rows (a2);

for i = 1 : n
  id = a2(i).id;
  meta = a2(i).meta;
  pairs = a2(i).pairs;

  z = 1;
  new = true;
  for z = 1 : length (a)
    if isequaln (a(z).id, id)
      new = false;

      break
    end
  end

  if new
    a(end + 1) = struct ('id', id, 'meta', meta, 'pairs', pairs);
  else
    a(z).pairs = [a(z).pairs; pairs];
  end
end

k = 1;
for i = 1 : length (a)
  [y, j] = unique (a(i).pairs(:, 1));
  a(i).pairs = a(i).pairs(j, :);
end

end
