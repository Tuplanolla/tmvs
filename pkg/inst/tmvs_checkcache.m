% -*- texinfo -*-
% @deftypefn {Function File} {@var{v} =} tmvs_checkcache (@var{cname})
%
% Sets @var{v} to a nonzero value if @var{cname} is a readable cache file.
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

function v = tmvs_checkcache (cname)

v = false;

try
  v = load (cname, 'tmvs_version').tmvs_version;
end

end
