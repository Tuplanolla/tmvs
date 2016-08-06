% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_purgeall (@var{pat})
% @deftypefnx {Function File} {} tmvs_purgeall (@var{pat}, @var{dname})
%
% Removes the cache files matching @var{pat} safely.
% The pattern @var{pat} can be written
% according the format supported by @code{glob}.
%
% Recursive with two arguments.
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
% @seealso{tmvs, tmvs_cachename, tmvs_purge}
%
% @end deftypefn

function tmvs_purgeall (pat, dname)

if nargin >= 2
  cellfun (@tmvs_purge, globr (pat, dname));
else
  cellfun (@tmvs_purge, glob (pat));
end

end
