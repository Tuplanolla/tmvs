function arrays = tmvs_glob (pattern)

filenames = glob (pattern);

arrays = struct ();
for i = 1 : length (filenames)
  filename = filenames{i};

  arrays = tmvs_merge (arrays, tmvs_fetch (filename));
end

end