% -*- texinfo -*-
% @deftypefn {Function File} {@var{a} =} tmvs_recall (@var{cname})
% @deftypefnx {Function File} {@var{a} =} tmvs_recall (@var{cname}, @var{force})
%
% Reads the aggregate @var{a} from the cache file @var{cname}.
% The storage format is detected automatically and
% the cache version is checked for compatibility.
% If the @var{force} parameter is supplied and nonzero,
% loading incompatible versions is also attempted.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_store ('/tmp/tmvs.tmp', tmvs_fetch ('excerpt/2011/120-0.csv'))}
% @code{a = tmvs_recall ('/tmp/tmvs.tmp');}
% @code{a = tmvs_recall ('/tmp/tmvs.tmp', true);}
% @end example
%
% @seealso{tmvs, tmvs_store, tmvs_fetch, tmvs_purge, load}
% @end deftypefn

function a = tmvs_recall (cname, force = false)

if ~exist (cname, 'file')
  error ('file ''%s'' does not exist', cname);
end

s = struct ();
try
  s = load (cname, 'tmvs_v', 'tmvs_a');
end

if ~isfield (s, 'tmvs_v')
  error ('not a cache file ''%s''', cname);
elseif s.tmvs_v ~= tmvs_version ()
  if force
    f = @warning;
  else
    f = @error;
  end
  f ('cache file ''%s'' has version ''%s''', cname, s.tmvs_v);
end

a = s.tmvs_a;

end
