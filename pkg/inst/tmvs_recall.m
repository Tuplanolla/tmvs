% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_recall (@var{name})
% @deftypefnx {Function File} {@var{aggr} =} tmvs_recall (@var{name}, @var{force})
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
% Programming note: Race conditions!
%
% @seealso{tmvs, tmvs_store, tmvs_fetch, tmvs_purge, load}
%
% @end deftypefn

function aggr = tmvs_recall (name, force = false)

read = false;

v = tmvs_checkcache (name);
if v
  cname = name;

  read = true;
else
  cname = tmvs_cachename (name);

  warning ('not a cache file ''%s'', trying ''%s''', name, cname);

  v = tmvs_checkcache (cname);
  if v
    read = true;
  end
end

if read
  s = struct ();
  try
    s = load (cname, 'tmvs_aggregate');
  end

  if isfield (s, 'tmvs_aggregate') && (v == tmvs_version () || force)
    aggr = s.tmvs_aggregate;
  else
    error ('cache file ''%s'' has version ''%s'' instead of ''%s''', ...
      cname, v, tmvs_version ());
  end
else
  error ('not a readable cache file ''%s''', cname);
end

end
