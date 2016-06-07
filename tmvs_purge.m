function tmvs_purge(filename, cachename = sprintf('%s.tmp', filename))
if exist(cachename, 'file')
  [err, msg] = unlink(cachename);
  if err ~= 0
    error(msg);
  end
end
end
