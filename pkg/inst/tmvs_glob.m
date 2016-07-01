function a = tmvs_glob (src, pattern)

filenames = glob (pattern);

a = struct ('hash', {}, 'id', {}, 'pairs', {});
for i = 1 : length (filenames)
  filename = filenames{i};

  a = tmvs_merge (a, tmvs_fetch (src, filename));
end

end
