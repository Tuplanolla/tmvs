% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_fetch (@var{fname}, @var{src}, @var{varargin})
%
% Read an aggregate from a source file, using a cache file by need.
%
% If you want to read several similarly named source files at once,
% try @code{tmvs_fetchall} instead.
%
% This procedure either parses the source file @var{fname} or
% reads its cache file to produce the aggregate @var{aggr}.
% The data source @var{src} and the options in @var{varargin}
% are passed through to @code{tmvs_import}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 12]
% @end example
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 5]
% @end example
%
% @seealso{tmvs, tmvs_import, tmvs_store, tmvs_recall, tmvs_purge}
%
% @end deftypefn

function aggr = tmvs_fetch (fname, src, varargin)

cname = tmvs_cachename (fname);

cached = true;

[cacheinfo, err, msg] = stat (cname);
if err == -1
  warning (sprintf ('cannot access cache file ''%s''', cname));
  warning ('reading the source file (this can take a while)');

  cached = false;
else
  [fileinfo, err, msg] = stat (fname);
  if err == -1
    warning (sprintf ('cannot access source file ''%s''', fname));
    warning ('falling back on the cache file');
  elseif cacheinfo.mtime < fileinfo.mtime
    warning ('cache file is stale');
    warning ('rereading the source file (this can take a while)');

    cached = false;
  end
end

if cached
  aggr = tmvs_recall (cname);
else
  aggr = tmvs_import (fname, src, varargin{:});
  tmvs_store (cname, aggr);
end

end
