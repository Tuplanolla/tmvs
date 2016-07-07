% -*- texinfo -*-
% @deftypefn {Function File} {[@var{aggr}, @var{aggr}] =} tmvs_readcache (@var{cname})
%
% Sets @var{aggr} to a nonzero value if @var{cname} is a readable cache file.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_readcache ('excerpt/2012/118-0.csv')}
% @result{} false
% @code{tmvs_readcache ('excerpt/2012/118-0.csv.tmp')}
% @result{} true
% @end example
%
% @seealso{tmvs, tmvs_cachename, tmvs_store, tmvs_recall, tmvs_fetch, tmvs_purge}
%
% @end deftypefn

function [p, aggr] = tmvs_readcache (cname)

aggr = false;
p = false;

try
  aggr = load (cname, 'tmvs_aggregate').tmvs_aggregate;
  p = true;
end

end
