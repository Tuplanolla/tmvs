% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_work (@var{dname})
%
% This requires a certain direcotry structure!
%
% Mention: all vars.
%
% The following example demonstrates basic usage.
%
% @example
% @code{
% fname = 'excerpt/2012/118-0.csv';
% imported = tmvs_import (fname);
% fetched = tmvs_fetch (fname);
% merged = tmvs_merge (imported, fetched);
% interpolated = tmvs_interpolate (merged);
% discretized = tmvs_discretize (interpolated);
% tmvs_visualize (discretized);
% }
% @end example
%
% This procedure performs the commands shown in the previous example.
%
% @example
% @code{tmvs ('excerpt')}
% @end example
%
% @seealso{tmvs_import, tmvs_interpolate, tmvs_discretize, tmvs_merge, tmvs_visualize, tmvs_export, tmvs_store, tmvs_recall, tmvs_fetch, tmvs_purge}
%
% @end deftypefn

function aggr = tmvs_work (dname)

if ~isdir (dname)
  error ('not a directory ''%s''', dname);
end

labs = tmvs_fetchall (sprintf ('%s/*/[0-9]*.csv', dname), ...
                      tmvs_source ('Test Lab'));
stations = tmvs_fetchall (sprintf ('%s/*/[a-z]*.csv', dname), ...
                          tmvs_source ('Weather Station'));
observatories = tmvs_fetchall (sprintf ('%s/*.csv', dname), ...
                               tmvs_source ('Weather Observatory'), ...
                               tmvs_region ('Jyvaskyla'));
aggr = tmvs_merge (labs, stations, observatories);

end
