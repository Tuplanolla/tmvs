% -*- texinfo -*-
% @deftypefn {Function File} {@var{delta} =} tmvs_uncertainty (@var{id})
% @deftypefnx {Function File} {@var{delta} =} tmvs_uncertainty (@var{id}, @var{q})
%
% Computes the uncertainty @var{delta} of the value @var{q}
% measured by the sensor with the identity @var{id}.
% If the uncertainty does not depend on value, @var{q} can be omitted.
% An accidental omission results an uncertainty of @code{nan}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_uncertainty (struct ('quantity', ...
%                           tmvs_quantity ('Relative Humidity')))}
% @result{} 10
% @code{aggr = tmvs_fetch (tmvs_source ('Test Lab'), ...
%                    'excerpt/2012/118-0.csv');}
% @code{tmvs_uncertainty (aggr(9).id, aggr(9).pairs(:, 2))}
% @result{} [1; 1; 1]
% @end example
%
% Programming note: The current uncertainties are educated guesses.
%
% @seealso{tmvs, tmvs_quantity, tmvs_fetch}
%
% @end deftypefn

function delta = tmvs_uncertainty (id, q = 0)

qty = tmvs_quantity (id.quantity);

% TODO Replace these educated guesses with accurate data.
switch qty
case 'Temperature'
  delta = 1 + 0 * q;
case 'Relative Humidity'
  delta = 10 + 0 * q;
case 'Absolute Humidity'
  delta = 1 + 0 * q;
case 'Pressure'
  delta = 1 + 0 * q;
case 'Wind Speed'
  delta = 0.1 + 0 * q;
case 'Precipitation'
  delta = 1 + 0 * q;
otherwise
  error ('uncertainty for physical quantity ''%s'' not known', qty);
end

end
