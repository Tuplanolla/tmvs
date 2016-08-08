% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_purge (@var{cname})
%
% Remove a cache file safely.
%
% If you want to remove several cache file, consider @code{tmvs_purgeall}.
%
% This procedure removes the cache file @var{cname}
% only if it is a cache file in order to prevent accidental data loss.
% To remove corrupted cache files or anything else that gets in the way,
% @code{unlink} will do nicely.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));}
% @code{tmvs_store ('/tmp/tmvs.tmp', aggr);
% tmvs_purge ('/tmp/tmvs.tmp');}
% @end example
%
% @example
% @code{tmvs_purge ('/tmp');}
% @error{} not a removable cache file '/tmp'
% @end example
%
% @seealso{tmvs, tmvs_store, tmvs_recall, tmvs_fetch, unlink}
%
% @end deftypefn

function tmvs_purge (cname)

if tmvs_checkcache (cname)
  [err, msg] = unlink (cname);
  if err == -1
    error ('failed to remove cache file ''%s'': %s', cname, msg);
  end
else
  error ('not a removable cache file ''%s''', cname);
end

end
