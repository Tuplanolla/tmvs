% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs_recall (@var{cname})
%
% Reads the central data structure @var{c} from the cache file @var{cname}.
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

function c = tmvs_recall (cname)

if ~exist (cname, 'file')
  error ('cache file ''%s'' does not exist', cname);
end

s = struct ();
try
  s = load (cname, 'tmvs_v', 'tmvs_c');
end

if ~isfield (s, 'tmvs_v')
  warning ('cache file ''%s'' is unversioned', cname);
elseif s.tmvs_v ~= tmvs_version ()
  error ('cache file ''%s'' has incompatible version ''%s''', cname, s.tmvs_v);
end

c = s.tmvs_c;

end
