% -*- texinfo -*-
% @deftypefn {Function File} {@var{delta} =} tmvs_uncertainty (@var{id})
% @deftypefnx {Function File} {@var{delta} =} tmvs_uncertainty (@var{id}, @var{x})
%
% Compute the uncertainty @var{delta} of the value @var{x}
% measured by the sensor with the identity @var{id}.
% If the uncertainty does not depend on value, @var{x} can be omitted.
% An accidental omission results an uncertainty of @code{nan}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_uncertainty (struct ('quantity', ...
%                           tmvs_quantity ('relative humidity')))}
% @result{} 10
% @code{tmvs_uncertainty (tmvs_fetch (tmvs_source ('test lab'), ...
%                               'excerpt/2011/120-0.csv')(1).id)}
% @result{} 10
% @end example
%
% @seealso{tmvs, tmvs_quantity, tmvs_fetch}
%
% @end deftypefn

function delta = tmvs_uncertainty (id, x = nan)

quantity = id.quantity;

% TODO Replace these educated guesses with accurate data.
switch tmvs_quantity (quantity)
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
  error (sprintf ('uncertainty for physical quantity %d not known', quantity));
end

end
