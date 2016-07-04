% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} tmvs_iscache (@var{cname})
%
% Sets @var{p} to a nonzero value if @var{cname} is a readable cache file.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_iscache ('excerpt/2011/120-0.csv')}
% @result{} false
% @code{tmvs_iscache ('excerpt/2011/120-0.csv.tmp')}
% @result{} true
% @end example
%
% @seealso{tmvs, tmvs_cachename, tmvs_store, tmvs_recall, tmvs_fetch, tmvs_purge}
%
% @end deftypefn

function p = tmvs_iscache (cname)

s = struct ();
try
  s = load (cname, 'tmvs_version');
end

p = isfield (s, 'tmvs_version');

end
