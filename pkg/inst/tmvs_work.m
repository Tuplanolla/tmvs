% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_work (@var{dname})
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

if ~isdir (fname)
  error ('not a directory ''%s''', fname);
end

buildings = tmvs_fetchall (sprintf ('%s/*/[0-9]*.csv', fname), ...
                           tmvs_source ('Test Lab'));
stations = tmvs_fetchall (sprintf ('%s/*/[a-z]*.csv', fname), ...
                          tmvs_source ('Weather Station'));
observatories = tmvs_fetchall (sprintf ('%s/*.csv', fname), ...
                               tmvs_source ('Weather Observatory'), ...
                               tmvs_region ('Jyvaskyla'));
aggr = tmvs_merge (buildings, stations, observatories);

% tmvs_visualize (aggr, 'T[0-9]+', 'Temperature [^oC]');
% tmvs_visualize (aggr, 'RH[0-9]+', 'Relative Humidity [\%]');
% tmvs_visualize (aggr, 'AH[0-9]+', 'Absolute Humidity [g/m^3]');

% tmvs_visualize (aggr, '.ila', 'Temperature [^oC]');
% tmvs_visualize (aggr, '.osteus', 'Relative Humidity [\%]');
% tmvs_visualize (aggr, '.aine', 'Ambient Pressure [hPa]');
% tmvs_visualize (aggr, '.uul', 'Wind Speed [m/s]');
% tmvs_visualize (aggr, '.ade', 'Precipitation [mm/d]');

end
