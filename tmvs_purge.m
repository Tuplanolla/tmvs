function tmvs_purge(file, cache = sprintf('%s.tmp', file))
if exist(cache, 'file')
  [err, msg] = unlink(cache);
  if err ~= 0
    error(err);
  end
end
end

%!test
%! assert(true);
