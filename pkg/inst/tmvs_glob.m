function arrays = tmvs_glob (src, pattern)

filenames = glob (pattern);

arrays = cell ();
for i = 1 : length (filenames)
  filename = filenames{i};

  arrays = tmvs_merge (arrays, tmvs_fetch (src, filename));
end

end
