% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs_fetch (@var{fname}, @var{src})
% @deftypefnx {Function File} {@var{c} =} tmvs_fetch (@var{fname}, @var{src}, @var{reg})
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

function c = tmvs_fetch (fname, varargin)

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
  c = tmvs_recall (cname);
else
  c = tmvs_import (fname, varargin{:});
  tmvs_store (cname, c);
end

end
