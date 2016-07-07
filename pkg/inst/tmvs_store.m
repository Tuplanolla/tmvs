% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_store (@var{cname}, @var{aggr}, @var{varargin})
%
% Writes the aggregate @var{aggr} into the cache file @var{cname}.
% The optional storage parameters @var{varargin} can be chosen
% from the options supported by @code{save}.
% They default to the free HDF5 format @qcode{'-hdf5'},
% because partial loading is really fast.
% To save space also use @qcode{'-zip'}.
%
% This procedure is safe to use in the sense that
% it will not overwrite cache files it does not recognize.
% Use @code{unlink} to get rid of existing files if they are in the way.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_store ('/tmp/tmvs.tmp', tmvs_fetch ('excerpt/2012/118-0.csv'))}
% @end example
%
% @seealso{tmvs, tmvs_recall, tmvs_fetch, tmvs_purge, save}
%
% @end deftypefn

function tmvs_store (cname, aggr, varargin)

if ~exist (cname, 'file') || tmvs_checkcache (cname)
  if nargin <= 2
    options = {'-hdf5'};
  else
    options = varargin;
  end

  tmvs_version = tmvs_version ();
  tmvs_aggregate = aggr;
  save (options{:}, cname, 'tmvs_version', 'tmvs_aggregate');
else
  error ('not a writable cache file ''%s''', cname);
end

end
