% -*- texinfo -*-
% @deftypefn {Function File} {[@var{id}, @var{meta}] =} tmvs_parsename (@var{str})
%
% Parses the string @var{str} containing a record name and
% produces the identifying structure @var{id} and
% the metadata structure @var{meta}.
% The formal grammar is presented in the file @qcode{'Name.g4'}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{[id, meta] = tmvs_parsename ('KoeRakPS120 - RH120 A1 180mm 160 EPS')}
% @result{} id = struct ('source', 1, 'quantity', 2, 'site', 16, ...
%                 'surface', 1, 'room', 120, 'section', 1, 'ordinal', 1)
%    meta = struct ('position', 180, 'material', 3)
% @code{tmvs_parsename ('Autiolahden s??asema - Ilmankosteus')}
% @result{} struct ('source', 2, 'quantity', 2, 'region', 1)
% @end example
%
% @seealso{tmvs, tmvs_fetch, textscan, regexp}
%
% @end deftypefn

function [id, meta] = tmvs_parsename (str)

% This implementation is somewhat fragile
% due to the way @code{regexp} handles named tokens.
% The catch is that
% @code{regexp ('matching', '(?<outer>(?<inner>match)ing)', 'names')}
% produces @code{struct ('outer', 'matching', 'inner', 'match')}
% while @code{regexp ('matching', '(?<outer>(?<inner>matching))', 'names')}
% merely produces @code{struct ('outer', 'matching', 'inner', '')}.

persistent pat
if isempty (pat)
  any = '.{1,4}';
  space = '[\t ]+';
  number = '[0-9]+';

  pat = strcat( ...
    '^', ...
    '(?<id>', ...
    '(?<testLab>KoeRak)', ...
    '(?<site>[A-Z])(?:', ...
    '(?<wall>S)|', ...
    '(?<floor>L)|', ...
    '(?<ceiling>K))', ...
    '(?<room1>', number, ')(?:', space, 'Meta)?', space, '-', space, '(?:(?:', ...
    '(?<shortTemperature>T)|', ...
    '(?<shortRelativeHumidity>RH)|', ...
    '(?<shortAbsoluteHumidity>AH))', ...
    '(?<room2>', number, ')', space, '(?:(?:', ...
    '(?<centerFloor>L)|', ...
    '(?<centerCeiling>K))(?:at)?|', ...
    '(?<bottomCorner>A)|', ...
    '(?<topCorner>Y))', ...
    '(?<ordinal>', number, ')', space, ...
    '(?<position>', number, ')mm(?:', space, ...
    '(?<element>', number, '(?:', space, ')?', '(?:', ...
    '(?<mineralWool>villa)|', ...
    '(?<polystyrene>EPS)|', ...
    '(?<polyurethane>PUR))?))?|', ...
    '(?<magicNumber>lisa140))|', '(?:', ...
    '(?<autiolahti>Autiolah(?:ti|den))|', ...
    '(?<jyvaskyla>Jyv', any, 's?kyl', any, 'n?))', space, ...
    '(?<weatherStation>s', any, '(?:', any, ')?(?:', space, ')?(?:asema)?)', space, '-', space, ...
    '(?:(?:ilman|ulko|vallitseva|ymp', any, 'rist', any, 'n)(?:', space, ')?)*(?:', ...
    '(?<longTemperature>l', any, 'mp', any, '(?:', space, ')?tila)|', ...
    '(?<longRelativeHumidity>(?:suhteellinen(?:', space, ')?)?kosteus(?:', space, '?prosentti)?)|', ...
    '(?<longAbsoluteHumidity>absoluuttinen(?:', space, ')?kosteus)|', ...
    '(?<longPressure>paine)|', ...
    '(?<longWindSpeed>tuul(?:i|en)(?:(?:', space, ')?nopeus)?)|', ...
    '(?<longPrecipitation>s(?:ade|ateen)(?:(?:', space, ')?m', any, any, 'r', any, ')?))', ...
    '(?:', space, '?arvo|mittaus)*', '(?:', space, ...
    '(?<garbage>(?:', any, ')+?))?)$');
end

nm = regexpi (str, pat, 'names');

if ~isempty (nm.testLab)
  source = 'Test Lab';
elseif ~isempty (nm.weatherStation)
  source = 'Weather Station';
end

if ~isempty (nm.shortTemperature)
  quantity = 'Temperature';
elseif ~isempty (nm.shortRelativeHumidity)
  quantity = 'Relative Humidity';
elseif ~isempty (nm.shortAbsoluteHumidity)
  quantity = 'Absolute Humidity';
end

if ~isempty (nm.longTemperature)
  quantity = 'Temperature';
elseif ~isempty (nm.longRelativeHumidity)
  quantity = 'Relative Humidity';
elseif ~isempty (nm.longAbsoluteHumidity)
  quantity = 'Absolute Humidity';
elseif ~isempty (nm.longPressure)
  quantity = 'Pressure';
elseif ~isempty (nm.longWindSpeed)
  quantity = 'Wind Speed';
elseif ~isempty (nm.longPrecipitation)
  quantity = 'Precipitation';
end

if ~isempty (nm.site)
  site = nm.site;
end

if ~isempty (nm.wall)
  surface = 'Wall';
elseif ~isempty (nm.floor)
  surface = 'Floor';
elseif ~isempty (nm.ceiling)
  surface = 'Ceiling';
end

% The second condition is equivalent to
% @code{~isempty (nm.room2) -> nm.room1 == nm.room2}
% by material implication.
if ~isempty (nm.room1) && (isempty (nm.room2) || nm.room1 == nm.room2)
  room = nm.room1;
end

if ~isempty (nm.bottomCorner)
  section = 'Bottom Corner';
elseif ~isempty (nm.topCorner)
  section = 'Top Corner';
end

if ~isempty (nm.position)
  position = str2double (nm.position) * 1e-3;
end

if ~isempty (nm.ordinal)
  ordinal = str2double (nm.ordinal);
end

if ~isempty (nm.mineralWool)
  material = 'Mineral Wool';
elseif ~isempty (nm.polystyrene)
  material = 'Polystyrene';
elseif ~isempty (nm.polyurethane)
  material = 'Polyurethane';
end

% TODO Find more information about this special sensor.
if ~isempty (nm.magicNumber)
  quantity = 'Temperature';
  surface = 'Floor';
  position = nan;
  ordinal = 1;
end

if ~isempty (nm.autiolahti)
  region = 'Autiolahti';
elseif ~isempty (nm.jyvaskyla)
  region = 'Jyvaskyla';
end

% To summarize,
% all alternatives have @qcode{'source'} and @qcode{'quantity'} in common while
% the first two only differ by @qcode{'section'} and @qcode{'material'}.
if ~isempty (nm.testLab) && ~isempty (nm.wall)
  id = struct ('source', tmvs_source (source), ...
               'quantity', tmvs_quantity (quantity), ...
               'site', tmvs_site (site), ...
               'surface', tmvs_surface (surface), ...
               'room', tmvs_room (room), ...
               'section', tmvs_section (section), ...
               'ordinal', ordinal);
  meta = struct ('position', position, ...
                 'material', tmvs_material (material));
elseif ~isempty (nm.testLab) && ~isempty (nm.floor)
  id = struct ('source', tmvs_source (source), ...
               'quantity', tmvs_quantity (quantity), ...
               'site', tmvs_site (site), ...
               'surface', tmvs_surface (surface), ...
               'room', tmvs_room (room), ...
               'ordinal', ordinal);
  meta = struct ('position', position);
elseif ~isempty (nm.weatherStation)
  id = struct ('source', tmvs_source (source), ...
               'quantity', tmvs_quantity (quantity), ...
               'region', tmvs_region (region));
  meta = struct ();
else
  error ('failed to parse identifier ''%s''', str);
end

end
