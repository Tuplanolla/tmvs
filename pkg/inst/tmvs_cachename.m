% -*- texinfo -*-
% @deftypefn {Function File} {@var{cname} =} tmvs_cachename (@var{fname})
%
% Returns the cache name @var{cname} for the original file @var{fname}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_cachename ('excerpt/2012/118-0.csv')}
% @result{} 'excerpt/2012/118-0.csv.tmp'
% @end example
%
% @seealso{tmvs, tmvs_checkcache, tmvs_store, tmvs_recall, tmvs_fetch, tmvs_purge}
%
% @end deftypefn

function cname = tmvs_cachename (fname)

cname = sprintf ('%s.tmp', fname);

end
