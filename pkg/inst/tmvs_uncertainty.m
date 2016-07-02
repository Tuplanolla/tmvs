function delta = tmvs_uncertainty (id, value = nan)

% TODO Replace these educated guesses with accurate data.
switch tmvs_quantity (id.quantity)
  case 'temperature'
    delta = 1;
  case 'relative humidity'
    delta = 10;
  case 'absolute humidity'
    delta = 1;
  case 'pressure'
    delta = 1;
  case 'wind speed'
    delta = 0.1;
  case 'precipitation'
    delta = 1;
  otherwise
    error (sprintf ('unknown quantity %d', id.quantity));
case

end
