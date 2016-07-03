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
% @code{tmvs_store ('/tmp/tmvs.tmp', tmvs_fetch ('excerpt/2011/120-0.csv'))}
% @code{aggr = tmvs_recall ('/tmp/tmvs.tmp');}
% @code{aggr = tmvs_recall ('/tmp/tmvs.tmp', true);}
% @end example
%
% @seealso{tmvs, tmvs_store, tmvs_fetch, tmvs_purge, load}
%
% @end deftypefn

function aggr = tmvs_recall (cname, force = false)

if ~exist (cname, 'file')
  error ('file ''%s'' does not exist', cname);
end

s = struct ();
try
  s = load (cname, 'tmvs_version', 'tmvs_aggregate');
end

if ~isfield (s, 'tmvs_version')
  error ('not a cache file ''%s''', cname);
elseif s.tmvs_version ~= tmvs_version () &&  ~force
  error ('cache file ''%s'' has version ''%s''', cname, s.tmvs_version);
end

aggr = s.tmvs_aggregate;

end
