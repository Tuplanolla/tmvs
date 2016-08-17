% -*- texinfo -*-
% @deftypefn {Function File} {[@var{p}, @var{v}] =} tmvs_checkcache (@var{cname})
%
% Check whether a file is a cache file.
%
% This procedure sets @var{p} to a nonzero value and
% @var{v} to the appropriate version number vector
% if @var{cname} is a readable cache file.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_checkcache ('excerpt/2012/118-0.csv')}
% @result{} false
% @end example
%
% @example
% @code{[p, v] = tmvs_checkcache ('excerpt/2012/118-0.csv.tmp')}
% @result{} p = true
% @result{} v = [1, 0, 1]
% @end example
%
% @seealso{tmvs, tmvs_cachename, tmvs_readcache, tmvs_store, tmvs_recall, tmvs_purge}
%
% @end deftypefn

function [p, v] = tmvs_checkcache (cname)

v = [];
p = false;

try
  v = load (cname, 'tmvs_version').tmvs_version;
  p = true;
end

end
