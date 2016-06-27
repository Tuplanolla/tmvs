% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs_recall (@var{cname})
%
% Reads the central data structure @var{c} from the cache file @var{cname}.
% The storage format is detected automatically.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_store ('/tmp/tmvs.tmp', tmvs_fetch ('excerpt/2011/118-0.csv'))
% tmvs_recall ('/tmp/tmvs.tmp')}
% @end example
%
% @seealso{tmvs, tmvs_store, tmvs_fetch, tmvs_purge}
% @end deftypefn

function arrays = tmvs_recall (cachename)

arrays = load (cachename, 'tmvs').tmvs;

end
