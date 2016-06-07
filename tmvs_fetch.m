function arrays = tmvs_fetch(filename, cachename = sprintf('%s.tmp', filename))
if exist(cachename, 'file')
  [cacheinfo, err, msg] = stat(cachename);
  if err ~= 0
    error(msg);
  end

  [fileinfo, err, msg] = stat(filename);
  if err ~= 0
    error(msg);
  end

  if cacheinfo.mtime < fileinfo.mtime
    arrays = tmvs_parse(filename);
    tmvs_store(cachename, arrays);
  else
    arrays = tmvs_recall(cachename);
  end
else
  arrays = tmvs_parse(filename);
  tmvs_store(cachename, arrays);
end
end
