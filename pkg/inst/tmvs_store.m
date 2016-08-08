% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_store (@var{cname}, @var{aggr}, @var{varargin})
%
% Write an aggregate into a cache file.
%
% This procedure writes the aggregate @var{aggr}
% into the cache file @var{cname}.
% Optional storage parameters can be passed in @var{varargin},
% are the same as those supported by @var{save}.
% They default to specifying the HDF5 storage format @qcode{'-hdf5'},
% because it makes partial loading really fast.
% Use @qcode{'-mat'} instead for MATLAB compatibility or
% @qcode{'-zip'} to save space (and waste time).
%
% This is safe to use in the sense that
% it will not overwrite cache files it does not recognize.
% Use @code{unlink} to get rid of unsuitable files if they get in the way.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));}
% @code{tmvs_store ('/tmp/tmvs.tmp', aggr);}
% @end example
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));}
% @code{tmvs_store ('/tmp/tmvs.tmp', aggr, '-binary', '-zip');}
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
