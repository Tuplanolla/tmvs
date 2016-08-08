% -*- texinfo -*-
% @deftypefn {Function File} {@var{cname} =} tmvs_cachename (@var{fname})
%
% Get the default cache file for a source file.
%
% This function returns the default cache file @var{cname}
% for the source file @var{fname}.
% The cache file is typically placed
% into the same directory as the source file,
% but with an altered by this function.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_cachename ('excerpt/2012/118-0.csv')}
% @result{} 'excerpt/2012/118-0.csv.tmp'
% @end example
%
% @seealso{tmvs, tmvs_checkcache, tmvs_readcache, tmvs_store, tmvs_recall, tmvs_purge}
%
% @end deftypefn

function cname = tmvs_cachename (fname)

cname = sprintf ('%s.tmp', fname);

end
