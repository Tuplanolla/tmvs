% -*- texinfo -*-
% @deftypefn {Function File} tmvs_store (@var{cname}, @var{c})
% @deftypefnx {Function File} tmvs_store (@var{cname}, @var{c}, @var{fmt})
% @deftypefnx {Function File} tmvs_store (@var{cname}, @var{c}, @var{fmt}, @var{zip})
%
% Writes the central data structure @var{c} into the cache file @var{cname}.
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

function tmvs_store (cname, c, fmt = '-mat', zip = true)

if exist (cname, 'file')
  try
    load (cname, 'tmvs_version').tmvs_version;
  catch
    error ('existing file ''%s'' is not a cache file', cname);
  end
end

tmvs_version = '1';
tmvs = c;

if zip
  save (fmt, '-zip', cname, 'tmvs_version', 'tmvs');
else
  save (fmt, cname, 'tmvs_version', 'tmvs');
end

end
