% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_fetch (@var{fname}, @var{src})
% @deftypefnx {Function File} {@var{aggr} =} tmvs_fetch (@var{fname}, @var{src}, @var{varargin})
%
% Magic happens.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{??}
% @end example
%
% @seealso{tmvs, tmvs_import, tmvs_store, tmvs_recall, tmvs_purge}
%
% @end deftypefn

function aggr = tmvs_fetch (fname, src, varargin)

cname = tmvs_cache_for (fname);

[cacheinfo, err, msg] = stat (cname);
if err == -1
  warning (sprintf ('cannot access cache file ''%s''', cname));
  warning ('reading the original file (this can take a while)');

  cached = false;
else
  [fileinfo, err, msg] = stat (fname);
  if err == -1
    warning (sprintf ('cannot access original file ''%s''', fname));
    warning ('falling back on the cache file');

    cached = true;
  elseif cacheinfo.mtime < fileinfo.mtime
    warning ('cache file is stale');
    warning ('rereading the original file (this can take a while)');

    cached = false;
  else
    cached = true;
  end
end

if cached
  aggr = tmvs_recall (cname);
else
  aggr = tmvs_import (fname, src, varargin{:});
  tmvs_store (cname, aggr);
end

end
