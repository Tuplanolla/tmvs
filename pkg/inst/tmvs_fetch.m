% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs_fetch (@var{fname})
% @deftypefnx {Function File} {@var{c} =} tmvs_fetch (@var{fname}, @var{cname})
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

function c = tmvs_fetch (src, fname, cname = tmvs_cache_for (fname))

[cacheinfo, err, msg] = stat (cname);
if err == -1
  warning (sprintf ('cannot access cache file ''%s''', cname));
  warning ('reading the original file (this can take a while)');

  wasfine = false;
else
  [fileinfo, err, msg] = stat (fname);
  if err == -1
    warning (sprintf ('cannot access original file ''%s''', fname));
    warning ('falling back on the cache file');

    wasfine = true;
  elseif cacheinfo.mtime < fileinfo.mtime
    warning ('cache file is stale');
    warning ('rereading the original file (this can take a while)');

    wasfine = false;
  else

    wasfine = true;
  end
end

if wasfine
  c = tmvs_recall (cname);
else
  c = tmvs_parse (src, fname);
  tmvs_store (cname, c);
end

end
