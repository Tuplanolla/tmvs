% -*- texinfo -*-
% @deftypefn {Function File} {@var{a} =} tmvs_recall (@var{cname})
%
% Reads the aggregate @var{a} from the cache file @var{cname}.
% The storage format is detected automatically.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_store ('/tmp/tmvs.tmp', tmvs_fetch ('excerpt/2011/118-0.csv'))
% tmvs_recall ('/tmp/tmvs.tmp')}
% @end example
%
% @seealso{tmvs, tmvs_store, tmvs_fetch, tmvs_purge, load}
% @end deftypefn

function a = tmvs_recall (cname)

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
  error ('cache file ''%s'' has incompatible version ''%s''', cname, s.tmvs_v);
end

a = s.tmvs_a;

end
