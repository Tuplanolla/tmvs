% The formal grammar is presented in the file @code{Id.g4}.

function c = tmvs_identify (str)

any = '.{1,2}';
space = '[\t ]+';
number = '[0-9]+';

pat = strcat('^', ...
  '(?<id>', ...
  '(?<buildingCoarse>', ...
  '(?<testLab>KoeRak)', ...
  '(?<site>[A-Z])(?:', ...
  '(?<horizontal>L)|', ...
  '(?<vertical>S))', ...
  '(?<room1>', number, ')(?:', space, 'Meta)?)', space, '-', space, ...
  '(?<buildingFine>(?:', ...
  '(?<shortTemperature>T)|', ...
  '(?<shortRelativeHumidity>RH)|', ...
  '(?<shortAbsoluteHumidity>AH))', ...
  '(?<room2>', number, ')', space, '(?:(?:', ...
  '(?<floor>L)|', ...
  '(?<ceiling>K))(?:at)?|', ...
  '(?<bottomCorner>A)|', ...
  '(?<topCorner>Y))', ...
  '(?<ordinal>', number, ')', space, ...
  '(?<position>', number, ')mm(?:', space, ...
  '(?<element>', number, '(?:', space, ')?', '(?:', ...
  '(?<mineralWool>villa)|', ...
  '(?<polystyrene>EPS)|', ...
  '(?<polyurethane>PUR))?))?|', ...
  '(?<magicNumber>lisa140))|', ...
  '(?<stationCoarse>(?:', ...
  '(?<autiolahti>Autiolah(?:ti|den))|', ...
  '(?<jyvaskyla>Jyv', any, 's?kyl', any, 'n?))', space, ...
  '(?<weatherStation>s', any, any, '(?:', space, ')?(?:asema)?))', space, '-', space, ...
  '(?<stationFine>', '(?:(?:ilman|ulko|vallitseva|ymp', any, 'rist', any, 'n)(?:', space, ')?)*(?:', ...
  '(?<longTemperature>l', any, 'mp', any, '(?:', space, ')?tila)|', ...
  '(?<longRelativeHumidity>(?:suhteellinen(?:', space, ')?)?kosteus(?:', space, '?prosentti)?)|', ...
  '(?<longAbsoluteHumidity>absoluuttinen(?:', space, ')?kosteus)|', ...
  '(?<longPressure>paine)|', ...
  '(?<longWindSpeed>tuul(?:i|en)(?:(?:', space, ')?nopeus)?)|', ...
  '(?<longPrecipitation>s(?:ade|ateen)(?:(?:', space, ')?m', any, any, 'r', any, ')?))', '(?:', space, '?arvo|mittaus)*', '(?:', space, ...
  '(?<garbage>(?:', any, ')+?))?))', ...
  '$');

[~, ~, ~, ~, ~, nm] = regexpi (str, pat);

if ~isempty (nm.testLab)
  if ~isempty (nm.shortTemperature)
    quantity = 'temperature';
  elseif ~isempty (nm.shortRelativeHumidity)
    quantity = 'relative humidity';
  elseif ~isempty (nm.shortAbsoluteHumidity)
    quantity = 'absolute humidity';
  end

  if ~isempty (nm.site)
    site = nm.site;
  end

  if ~isempty (nm.room1) && ~isempty (nm.room2) && nm.room1 == nm.room2
    room = nm.room1;
  end

  if ~isempty (nm.position)
    position = str2double (nm.position);
  end

  if ~isempty (nm.horizontal)
    if ~isempty (nm.floor)
      placement = 'level floor';
    elseif ~isempty (nm.ceiling)
      placement = 'level ceiling';
    end
  elseif ~isempty (nm.vertical)
    if ~isempty (nm.bottomCorner)
      placement = 'wall bottom corner';
    elseif ~isempty (nm.topCorner)
      placement = 'wall top corner';
    end
  end

  if ~isempty (nm.mineralWool)
    material = 'mineral wool';
  elseif ~isempty (nm.polystyrene)
    material = 'polystyrene';
  elseif ~isempty (nm.polyurethane)
    material = 'polyurethane';
  end

  c = struct ('source', tmvs_source ('test lab'), ...
              'quantity', tmvs_quantity (quantity), ...
              'site', tmvs_site (site), ...
              'room', tmvs_room (room), ...
              'position', position, ...
              'placement', tmvs_placement (placement), ...
              'material', tmvs_material (material));
elseif ~isempty (nm.weatherStation)
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

  if ~isempty (nm.autiolahti)
    region = 'autiolahti';
  elseif ~isempty (nm.jyvaskyla)
    region = 'jyvaskyla';
  end

  c = struct ('source', tmvs_source ('weather station'), ...
              'quantity', tmvs_quantity (quantity), ...
              'region', tmvs_region (region));
else
  error (sprintf ('unrecognized identifier ''%s''', str));
end

end
