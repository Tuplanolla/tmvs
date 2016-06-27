% -*- texinfo -*-
% @deftypefn {Function File} tmvs_fetch (@var{fname})
% @deftypefnx {Function File} tmvs_fetch (@var{fname}, @var{cname})
%
% Magic happens.
%
% The following example demonstrates basic usage.
%
% @example
% @code{??}
% @end example
%
% @seealso{tmvs, tmvs_store, tmvs_recall, tmvs_fetch, tmvs_purge}
% @end deftypefn

function arrays = tmvs_fetch (filename, cachename = sprintf ('%s.tmp', filename))

[cacheinfo, err, msg] = stat (cachename);
if err ~= 0
  warning (sprintf ('cannot access cache file ''%s''', cachename));
  warning ('reading the original file (this can take a while)');
  recall = false;
else
  [fileinfo, err, msg] = stat (filename);
  if err ~= 0
    warning (sprintf ('cannot access original file ''%s''', filename));
    warning ('falling back on the cache file');
    recall = true;
  elseif cacheinfo.mtime < fileinfo.mtime
    warning ('cache file is stale');
    warning ('rereading the original file (this can take a while)');
    recall = false;
  else
    recall = true;
  end
end

if recall
  arrays = tmvs_recall (cachename);
else
  arrays = tmvs_parse (filename);
  tmvs_store (cachename, arrays);
end

end
