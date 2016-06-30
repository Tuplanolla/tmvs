% -*- texinfo -*-
% @deftypefn {Function File} {@var{m} =} tmvs_id (@var{str})
%
% Parses the string @var{str} containing a record identifier and
% produces the metadata structure @var{m}.
% The formal grammar is presented in the file @qcode{'Id.g4'}.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_id ('KoeRakPS120 - RH120 A1 180mm 160 EPS')}
% @result{} struct ('source', 1, 'quantity', 2, 'site', 16, ...
%            'surface', 1, 'room', 120, 'section', 1, ...
%            'ordinal', 1, 'position', 180, 'material', 3)
% @code{tmvs_id ('Autiolahden s??asema - Ilmankosteus')}
% @result{} struct ('source', 2, 'quantity', 2, 'region', 1)
% @end example
%
% @seealso{tmvs_parse, tmvs_csv, textscan, regexp}
% @end deftypefn

function m = tmvs_id (str)

% This implementation is somewhat fragile
% due to the way @code{regexp} handles named tokens.
% The catch is that
% @code{regexp ('matching', '(?<outer>(?<inner>match)ing)', 'names')}
% produces @code{struct ('outer', 'matching', 'inner', 'match')}
% while @code{regexp ('matching', '(?<outer>(?<inner>matching))', 'names')}
% merely produces @code{struct ('outer', 'matching', 'inner', '')}.

any = '.{1,4}';
space = '[\t ]+';
number = '[0-9]+';

pat = strcat('^', ...
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
  '(?<garbage>(?:', any, ')+?))?)', ...
  '$');

nm = regexpi (str, pat, 'names');

if ~isempty (nm.testLab)
  source = 'test lab';
elseif ~isempty (nm.weatherStation)
  source = 'weather station';
end

if ~isempty (nm.shortTemperature)
  quantity = 'temperature';
elseif ~isempty (nm.shortRelativeHumidity)
  quantity = 'relative humidity';
elseif ~isempty (nm.shortAbsoluteHumidity)
  quantity = 'absolute humidity';
end

if ~isempty (nm.longTemperature)
  quantity = 'temperature';
elseif ~isempty (nm.longRelativeHumidity)
  quantity = 'relative humidity';
elseif ~isempty (nm.longAbsoluteHumidity)
  quantity = 'absolute humidity';
elseif ~isempty (nm.longPressure)
  quantity = 'pressure';
elseif ~isempty (nm.longWindSpeed)
  quantity = 'wind speed';
elseif ~isempty (nm.longPrecipitation)
  quantity = 'precipitation';
end

if ~isempty (nm.site)
  site = nm.site;
end

if ~isempty (nm.wall)
  surface = 'wall';
elseif ~isempty (nm.floor)
  surface = 'floor';
elseif ~isempty (nm.ceiling)
  surface = 'ceiling';
end

% The second condition is equivalent to
% @code{~isempty (nm.room2) -> nm.room1 == nm.room2}
% by material implication.
if ~isempty (nm.room1) && (isempty (nm.room2) || nm.room1 == nm.room2)
  room = nm.room1;
end

if ~isempty (nm.bottomCorner)
  section = 'bottom corner';
elseif ~isempty (nm.topCorner)
  section = 'top corner';
end

if ~isempty (nm.position)
  position = str2double (nm.position);
end

if ~isempty (nm.ordinal)
  ordinal = int8 (str2double (nm.ordinal));
end

position = nm.position;

if ~isempty (nm.mineralWool)
  material = 'mineral wool';
elseif ~isempty (nm.polystyrene)
  material = 'polystyrene';
elseif ~isempty (nm.polyurethane)
  material = 'polyurethane';
end

% TODO Find more information about this special sensor.
if ~isempty (nm.magicNumber)
  quantity = 'temperature';
  surface = 'floor';
  position = nan;
else

if ~isempty (nm.autiolahti)
  region = 'autiolahti';
elseif ~isempty (nm.jyvaskyla)
  region = 'jyvaskyla';
end

% To summarize,
% all alternatives have @qcode{'source'} and @qcode{'quantity'} in common while
% the first two only differ by @qcode{'section'} and @qcode{'material'}.
if ~isempty (nm.testLab) && ~isempty (nm.wall)
  m = struct ('source', tmvs_source (source), ...
              'quantity', tmvs_quantity (quantity), ...
              'site', tmvs_site (site), ...
              'surface', tmvs_surface (surface), ...
              'room', tmvs_room (room), ...
              'section', tmvs_section (section), ...
              'ordinal', ordinal, ...
              'position', position, ...
              'material', tmvs_material (material));
elseif ~isempty (nm.testLab) && ~isempty (nm.floor)
  m = struct ('source', tmvs_source (source), ...
              'quantity', tmvs_quantity (quantity), ...
              'site', tmvs_site (site), ...
              'surface', tmvs_surface (surface), ...
              'room', tmvs_room (room), ...
              'ordinal', ordinal, ...
              'position', position);
elseif ~isempty (nm.weatherStation)
  m = struct ('source', tmvs_source (source), ...
              'quantity', tmvs_quantity (quantity), ...
              'region', tmvs_region (region));
else
  error (sprintf ('unrecognized identifier ''%s''', str));
end

end
