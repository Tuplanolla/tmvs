% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs (@var{dname})
%
% @example
% @code{,-----------------.
% |                 |\
% |                 | |
% `-----.     ,-----<.|  ,-----,----.    ,----.,-------.
%  \    |     |       \ /      \     \  /     /         \
%   `---|     |        '        |     \/     |    ------'\
%       |     |    .       ,    |\          / \        \  \
%       |     |    |\     /|    | \        /,-------    |-'
%       |     |    | `---' |    | |\      / \          / \
%       `-----'----' |\   \`----' | `----'   `--------'   |
%        \     \    \| `---'\    \|  \    \ / \        \ /
%         `-----`----'       `----'   `----'   `--------'}
% @end example
%
% Temperature and Moisture Visualization System or TMVS in short
% is a simple data analysis and visualization system.
% More words go here.
% Even though the system itself is quite pedestrian,
% the author has tried to impose some categorical structure on it.
%
% If you are in a hurry or do not enjoy reading technical manuals,
% jump straight to the examples at the end, try them out yourself and
% explore the other procedures listed under 'see also'.
% You can come back here and read the details
% in case you encounter something puzzling.
%
% Look at this space.
% Mention: all vars.
%
% The following example demonstrates basic usage.
%
% @example
% @code{
% fname = 'excerpt/2011/120-0.csv';
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

function aggr = tmvs (dname)

fname = canonicalize_file_name (dname);
if isempty (fname)
  error ('no such file or directory ''%s''', dname);
end

if ~isdir (fname)
  error ('not a directory ''%s''', fname);
end

buildings = tmvs_fetchall (sprintf ('%s/*/[0-9]*.csv', fname), ...
                           tmvs_source ('test lab'));
stations = tmvs_fetchall (sprintf ('%s/*/[a-z]*.csv', fname), ...
                          tmvs_source ('weather station'));
observatories = tmvs_fetchall (sprintf ('%s/*.csv', fname), ...
                               tmvs_source ('weather observatory'), ...
                               tmvs_region ('jyvaskyla'));
aggr = tmvs_merge (buildings, stations, observatories);

tmvs_visualize (aggr);

% tmvs_visualize (aggr, 1, 'T[0-9]+', 'Temperature [^oC]');
% tmvs_visualize (aggr, 2, 'RH[0-9]+', 'Relative Humidity [\%]');
% tmvs_visualize (aggr, 3, 'AH[0-9]+', 'Absolute Humidity [g/m^3]');

% tmvs_visualize (aggr, 1, '.ila', 'Temperature [^oC]');
% tmvs_visualize (aggr, 2, '.osteus', 'Relative Humidity [\%]');
% tmvs_visualize (aggr, 3, '.aine', 'Ambient Pressure [hPa]');
% tmvs_visualize (aggr, 4, '.uul', 'Wind Speed [m/s]');
% tmvs_visualize (aggr, 5, '.ade', 'Precipitation [mm/d]');

end

%!test
%! test tmvs_version

%!test
%! test tmvs_source
%! test tmvs_quantity
%! test tmvs_site
%! test tmvs_surface
%! test tmvs_room
%! test tmvs_section
%! test tmvs_material
%! test tmvs_region

%!test
%! test tmvs_brsearch
%! test tmvs_chauvenet
%! test tmvs_filters
%! test tmvs_filteru
%! test tmvs_foldl
%! test tmvs_foldr
%! test tmvs_mapl
%! test tmvs_mapr
%! test tmvs_progress
