% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_purge (@var{name})
%
% Removes the cache file @var{cname} or
% the cache file corresponding to the original file @var{fname}.
% If the given file is not a cache file or
% appears to be a corrupted cache file, it will not be removed
% (this is a safety mechanism that should prevent accidental data loss).
% To remove a corrupted cache file use @code{unlink} instead.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{c = tmvs_fetch ('excerpt/2011/120-0.csv');}
% @code{tmvs_purge ('excerpt/2011/120-0.csv')}
% @code{tmvs_store ('/tmp/tmvs.tmp', c)
% tmvs_purge ('/tmp/tmvs.tmp')}
% @end example
%
% @seealso{tmvs, tmvs_store, tmvs_recall, tmvs_fetch, unlink}
%
% @end deftypefn

function tmvs_purge (name)

remove = false;

if tmvs_checkcache (name)
  cname = name;

  remove = true;
else
  cname = tmvs_cachename (name);

  warning ('not a cache file ''%s'', trying ''%s''', name, cname);

  if tmvs_checkcache (cname)
    remove = true;
  end
end

if remove
  [err, msg] = unlink (cname);
  if err == -1
    error ('failed to remove cache file ''%s'': %s', cname, msg);
  end
else
  error ('not a removable cache file ''%s''', cname);
end

end
