function v = tmvs_getfield (s, k, d)

if isfield (s, k)
  v = getfield (s, k);
else
  v = d;
end

end
