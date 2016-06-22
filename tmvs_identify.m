function y = tmvs_identify(str)
% TODO Ha ha! Regular expressions!
pat = ['^(KoeRak(?<site>[A-Z])(?<level>L|S)(?<room1>[0-9]+)( Meta)? - ((?<quantity1>T|RH|AH)(?<room2>[0-9]+) (?<placement>L(at)?|A|Y)(?<number>[0-9]+) (?<depth>[0-9]+)mm.*|lisa140)|', ...
       '(?<region>Autiolah|Jyv)[^-]* - [^ ]*(?<quantity2>tila|kosteus|paine|tuul|sade).*)$'];
[~, ~, ~, ~, ~, nm] = regexpi(str, pat);

if ~isempty(nm.quantity1)
  source = 'test lab';

  switch tolower(nm.quantity1)
  case 't'
    quantity = 'temperature';
  case 'rh'
    quantity = 'relative humidity';
  case 'ah'
    quantity = 'absolute humidity';
  end

  site = nm.site;

  if nm.room1 ~= nm.room2
    error('malformed identifier');
  end
  room = nm.room1;

  depth = str2double(nm.depth);

  switch tolower(nm.placement)
  case {'l', 'lat'}
    placement = 'level floor';
  case 'a'
    placement = 'wall bottom corner';
  case 'y'
    placement = 'wall top corner';
  end

  % TODO This.
  material = 'mineral wool';

  y = struct('source', tmvs_source(source), ...
             'quantity', tmvs_quantity(quantity), ...
             'site', tmvs_site(site), ...
             'room', tmvs_room(room), ...
             'depth', depth, ...
             'placement', tmvs_placement(placement), ...
             'material', tmvs_material(material));
elseif ~isempty(nm.quantity2)
  source = 'small weather station';

  switch tolower(nm.quantity2)
  case 'tila'
    quantity = 'temperature';
  case 'kosteus'
    quantity = 'relative humidity';
  case 'paine'
    quantity = 'pressure';
  case 'tuul'
    quantity = 'wind speed';
  case 'sade'
    quantity = 'precipitation';
  end

  switch tolower(nm.region)
  case 'autiolah'
    region = 'Autiolahti';
  case 'jyv'
    region = 'Jyvaskyla';
  end

  y = struct('source', tmvs_source(source), ...
             'quantity', tmvs_quantity(quantity), ...
             'region', tmvs_region(region));
else
  error('malformed identifier');
end
end
