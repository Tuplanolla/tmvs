% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_recall (@var{cname})
% @deftypefnx {Function File} {@var{aggr} =} tmvs_recall (@var{cname}, @var{force})
%
% Reads the aggregate @var{aggr} from the cache file @var{cname}.
% The storage format is detected automatically and
% the cache version is checked for compatibility.
% If the @var{force} parameter is supplied and nonzero,
% loading incompatible versions is also attempted.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_store ('/tmp/tmvs.tmp', tmvs_fetch ('excerpt/2012/118-0.csv'))}
% @code{aggr = tmvs_recall ('/tmp/tmvs.tmp');}
% @code{aggr = tmvs_recall ('/tmp/tmvs.tmp', true);}
% @end example
%
% Programming note: Race conditions!
%
% @seealso{tmvs, tmvs_store, tmvs_fetch, tmvs_purge, load}
%
% @end deftypefn

function aggr = tmvs_recall (cname, force = false)

[p, v] = tmvs_checkcache (cname);
if p
  [p, aggr] = tmvs_readcache (cname);
  if ~(p && (force || v(1 : 2) == tmvs_version ()(1 : 2)))
    error ('cache file ''%s'' has version ''%s'' instead of ''%s''', ...
      cname, v, tmvs_version ());
  end
else
  error ('not a readable cache file ''%s''', cname);
end

end
