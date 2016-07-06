% -*- texinfo -*-
% @deftypefn {Function File} {[@var{p}, @var{ver}] =} tmvs_checkcache (@var{cname})
%
% Sets @var{ver} to a nonzero value if @var{cname} is a readable cache file.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_checkcache ('excerpt/2011/120-0.csv')}
% @result{} false
% @code{tmvs_checkcache ('excerpt/2011/120-0.csv.tmp')}
% @result{} true
% @end example
%
% @seealso{tmvs, tmvs_cachename, tmvs_store, tmvs_recall, tmvs_fetch, tmvs_purge}
%
% @end deftypefn

function [p, ver] = tmvs_checkcache (cname)

ver = '';
p = false;

try
  ver = load (cname, 'tmvs_version').tmvs_version;
  p = true;
end

end
