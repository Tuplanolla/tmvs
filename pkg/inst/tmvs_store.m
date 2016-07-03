% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_store (@var{cname}, @var{aggr}, @var{varargin})
%
% Writes the aggregate @var{aggr} into the cache file @var{cname}.
% The optional storage parameters @var{varargin} can be chosen
% from the options supported by @var{save}.
% They default to the compressed MATLAB-compatible format
% @code{@{'-mat', '-zip'@}}.
%
% This procedure is safe to use in the sense that
% it will not overwrite cache files it does not recognize.
% Use @code{unlink} to get rid of existing files if they are in the way.
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

function tmvs_store (cname, aggr, varargin)

if exist (cname, 'file')
  try
    load (cname, 'tmvs_version').tmvs_version;
  catch
    error ('existing file ''%s'' is not a cache file', cname);
  end
end

if nargin <= 2
  varargin = {'-mat', '-zip'};
end

tmvs_version = tmvs_version ();
tmvs_aggregate = aggr;
save (varargin{:}, cname, 'tmvs_version', 'tmvs_aggregate');

end
