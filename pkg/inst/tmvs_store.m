% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_store (@var{cname}, @var{a})
% @deftypefnx {Function File} {} tmvs_store (@var{cname}, @var{a}, @var{fmt})
% @deftypefnx {Function File} {} tmvs_store (@var{cname}, @var{a}, @var{fmt}, @var{compress})
%
% Writes the aggregate @var{a} into the cache file @var{cname}.
% The optional storage format @var{fmt} can be chosen
% from the formats supported by @var{save} and
% defaults to the MATLAB-compatible @qcode{'-mat'}.
% The other optional @var{compress} parameter determines
% whether the cache file should be compressed and defaults to @var{true}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_store ('/tmp/tmvs.tmp', tmvs_fetch ('excerpt/2011/120-0.csv'))}
% @end example
%
% @seealso{tmvs, tmvs_recall, tmvs_fetch, tmvs_purge, save}
%
% @end deftypefn

function tmvs_store (cname, a, fmt = '-mat', compress = true)

if exist (cname, 'file')
  try
    load (cname, 'tmvs_v').tmvs_v;
  catch
    error ('existing file ''%s'' is not a cache file', cname);
  end
end

tmvs_v = tmvs_version ();
tmvs_a = a;

if compress
  save (fmt, '-zip', cname, 'tmvs_v', 'tmvs_a');
else
  save (fmt, cname, 'tmvs_v', 'tmvs_a');
end

end
