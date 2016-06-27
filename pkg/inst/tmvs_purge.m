% -*- texinfo -*-
% @deftypefn {Function File} tmvs_purge (@var{cname})
% @deftypefnx {Function File} tmvs_purge (@var{fname})
%
% Removes the cache file @var{cname} or
% the cache file corresponding to the data file @var{fname}.
% If the cache file appears to be corrupted, it will not be removed
% (this is a safety mechanism that should prevent accidental data loss).
% To remove a corrupted cache file use @var{unlink} instead.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_store ('/tmp/tmvs.tmp', tmvs_fetch ('excerpt/2011/118-0.csv'))
% tmvs_purge ('/tmp/tmvs.tmp')}
% @end example
%
% @seealso{tmvs, tmvs_store, tmvs_recall, tmvs_fetch, unlink}
% @end deftypefn

function tmvs_purge (cname)

% TODO Check that file is actually cache file!
if exist (cname, 'file')
  [err, msg] = unlink (cname);
  if err ~= 0
    error (msg);
  end
end

end
