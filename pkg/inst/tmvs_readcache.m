% -*- texinfo -*-
% @deftypefn {Function File} {[@var{p}, @var{aggr}] =} tmvs_readcache (@var{cname})
%
% Check whether a file is a readable cache file.
%
% This procedure sets @var{p} to a nonzero value and
% produces the aggregate @var{aggr} if @var{cname} is a readable cache file.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_readcache ('excerpt/2012/118-0.csv')}
% @result{} false
% @end example
%
% @example
% @code{tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
% [p, aggr] = tmvs_readcache ('excerpt/2012/118-0.csv.tmp');}
% @code{p}
% @result{} true
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 12]
% @end example
%
% @seealso{tmvs, tmvs_cachename, tmvs_checkcache, tmvs_store, tmvs_recall, tmvs_purge}
%
% @end deftypefn

function [p, aggr] = tmvs_readcache (cname)

aggr = [];
p = false;

try
  aggr = load (cname, 'tmvs_aggregate').tmvs_aggregate;
  p = true;
end

end
