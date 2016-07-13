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
% is a simple data exploration and analysis tool built for JAMK.
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
% Short Octave primer:
% put configs in @qcode{'~/.octaverc'},
% for nice integration try
% @code{suppress_verbose_help_message(true);
% graphics_toolkit('gnuplot');
% setenv('GNUTERM', 'wxt noraise');}
% use @code{help} and @code{whos} frequently,
% hit Control C to abort,
%
% Look at this space.
% Mention: all vars.
%
% Notational conventions:
%
% @itemize @bullet
% @item the variable @var{aggr} is a structure
% with the fields @qcode{'id'}, @qcode{'meta'} and @qcode{'pairs'},
% @item the variable @var{c} is a cell vector or array,
% @item the variable @var{fid} is a stream handle,
% @item the variable @var{fname} is a path to a regular file,
% @item the variable @var{cname} is a path to a cache file,
% @item the variable @var{dname} is a path to a directory,
% @item the variables @var{f}, @var{g} and @var{h} are functions or procedures,
% @item the variable @var{id} is a structure
% with varying fields like @qcode{'source'} or @qcode{'quantity'},
% @item the variable @var{interp} is a structure
% with the fields @qcode{'id'}, @qcode{'meta'},
% @item @qcode{'function'} and @qcode{'limits'},
% @item the variables @var{i}, @var{j} and @var{k} are index scalars or vectors,
% @item the variable @var{meta} is a structure
% with varying fields like @qcode{'position'} or @qcode{'material'},
% @item the variable @var{mu} is a mean scalar,
% @item the variable @var{sigma} is a standard deviation scalar,
% @item the variable @var{n} is a natural number,
% @item the variable @var{pat} is a regular expression or glob pattern string,
% @item the variable @var{p} is a truth value,
% @item the variable @var{str} is a string,
% @item the variable @var{s} is a structure,
% @item the variable @var{varargin} is a variable argument cell vector,
% @item the variable @var{ver} is a version number string,
% @item the variable @var{v} is a vector,
% @item the variables @var{x}, @var{y} and @var{z} are polymorphic,
% @end itemize
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

% Remove moist.
% maggr = tmvs_mapl (@(s) setfield (s, 'pairs', s.pairs(s.pairs(:, 2) < 99)), aggr);
% Remove other outliers.
% maggr = tmvs_mapl (@(s) setfield (s, 'pairs', s.pairs(tmvs_chauvenet (s.pairs(:, 2)), :)), aggr);
% Etc.
% aggr = tmvs_recall ('../data/2012/118-0.csv.tmp');
% maggr = tmvs_mapl (@(s) setfield (s, 'pairs', s.pairs(tmvs_chauvenet (s.pairs(:, 2)), :)), aggr);
% faggr = tmvs_filteru (@(s) s.id.quantity == 1 && s.id.site == 17 && s.id.surface == 1 && s.id.section == 1, maggr);
% eaggr = tmvs_evaluate (tmvs_interpolate (faggr), 734.7e+3);
% z = sortrows ([(arrayfun (@(s) s.meta.position, eaggr')), (arrayfun (@(s) s.pairs(2), eaggr'))]);
% plot (num2cell (z, 1){:});

function aggr = tmvs (dname)

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

% tmvs_visualize (aggr, 'T[0-9]+', 'Temperature [^oC]');
% tmvs_visualize (aggr, 'RH[0-9]+', 'Relative Humidity [\%]');
% tmvs_visualize (aggr, 'AH[0-9]+', 'Absolute Humidity [g/m^3]');

% tmvs_visualize (aggr, '.ila', 'Temperature [^oC]');
% tmvs_visualize (aggr, '.osteus', 'Relative Humidity [\%]');
% tmvs_visualize (aggr, '.aine', 'Ambient Pressure [hPa]');
% tmvs_visualize (aggr, '.uul', 'Wind Speed [m/s]');
% tmvs_visualize (aggr, '.ade', 'Precipitation [mm/d]');

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
