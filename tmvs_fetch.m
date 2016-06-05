function arrays = tmvs_fetch(file, cache = sprintf('%s.tmp', file))
% TODO Check for races.
if exist(cache, 'file')
  % TODO Also check cache date!
  arrays = tmvs_recall(cache);
else
  arrays = tmvs_parse(file);
  tmvs_store(cache, arrays);
end
end

%!test
%! assert(true);
