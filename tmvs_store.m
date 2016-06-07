function tmvs_store(cachename, arrays, format = '-mat', zip = true)
tmvs = arrays;

if zip
  save(format, '-zip', cachename, 'tmvs');
else
  save(format, cachename, 'tmvs');
end
end
