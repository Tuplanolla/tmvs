% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_purgeall (@var{pat})
%
% Removes the cache files matching @var{pat} safely.
% The pattern @var{pat} can be written
% according the format supported by @code{glob}.
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

function tmvs_purgeall (pat)

cellfun (@tmvs_purge, glob (pat));

end
