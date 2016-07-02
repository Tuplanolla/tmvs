function a = tmvs_glob (src, pattern)

fnames = glob (pattern);

a = struct ('id', {}, 'meta', {}, 'pairs', {});

for i = 1 : length (fnames)
  a = tmvs_merge (a, tmvs_fetch (src, fnames{i}));
end

end
