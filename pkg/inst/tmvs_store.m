% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_store (@var{cname}, @var{a})
% @deftypefnx {Function File} {} tmvs_store (@var{cname}, @var{a}, @var{fmt})
% @deftypefnx {Function File} {} tmvs_store (@var{cname}, @var{a}, @var{fmt}, @var{zip})
%
% Writes the aggregate @var{a} into the cache file @var{cname}.
%
% The optional storage format @var{fmt} can be chosen
% from the formats supported by @var{save} and
% defaults to the MATLAB-compatible @qcode{'-mat'}.
% The other optional @var{zip} parameter determines
% whether the cache file should be compressed and defaults to @var{true}.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_store ('/tmp/tmvs.tmp', tmvs_fetch ('excerpt/2011/118-0.csv'))}
% @end example
%
% @seealso{tmvs, tmvs_recall, tmvs_fetch, tmvs_purge, save}
% @end deftypefn

function tmvs_store (cname, a, fmt = '-mat', zip = true)

if exist (cname, 'file')
  try
    load (cname, 'tmvs_v').tmvs_v;
  catch
    error ('existing file ''%s'' is not a cache file', cname);
  end
end

tmvs_v = tmvs_version ();
tmvs_a = a;

if zip
  save (fmt, '-zip', cname, 'tmvs_v', 'tmvs_a');
else
  save (fmt, cname, 'tmvs_v', 'tmvs_a');
end

end
