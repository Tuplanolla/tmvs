% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_purgeall (@var{pat})
% @deftypefnx {Function File} {} tmvs_purgeall (@var{pat}, @var{dname})
%
% Remove several cache files safely.
%
% If you want to remove just one cache file, consider @code{tmvs_purge}.
%
% This procedure removes the cache files matching the pattern @var{pat},
% but only if they are cache files in order to prevent accidental data loss.
% The pattern @var{pat} can be written
% according the format supported by @code{glob}.
% If the directory @var{dname} is specified,
% the removal starts from there and proceeds recursively.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_purgeall ('excerpt/2012/*.tmp');}
% @end example
%
% @example
% @code{tmvs_purgeall ('*.tmp', 'excerpt');}
% @end example
%
% @seealso{tmvs, tmvs_purge, glob, globr}
%
% @end deftypefn

function tmvs_purgeall (pat, dname)

if nargin >= 2
  cellfun (@tmvs_purge, globr (pat, dname));
else
  cellfun (@tmvs_purge, glob (pat));
end

end
