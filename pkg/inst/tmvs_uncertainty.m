% -*- texinfo -*-
% @deftypefn {Function File} {@var{delta} =} tmvs_uncertainty (@var{id})
% @deftypefnx {Function File} {@var{delta} =} tmvs_uncertainty (@var{id}, @var{q})
%
% Find the uncertainties of measurements.
%
% This function computes the uncertainties @var{delta} of the values @var{q}
% measured by the sensor with the identity @var{id}.
% If the uncertainties do not depend on the values, @var{q} can be omitted.
% An accidental omission may result in an uncertainty
% that is unnecessarily large or even @code{nan}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_uncertainty ( ...
%   struct ('quantity', tmvs_quantity ('Relative Humidity')))}
% @result{} 0.1
% @end example
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));}
% @code{tmvs_uncertainty (aggr(9).id, aggr(9).pairs(:, 2))}
% @result{} [1; 1; 1]
% @end example
%
% Programming note: The current uncertainties are educated guesses.
%
% @seealso{tmvs, tmvs_quantity, tmvs_sanitize}
%
% @end deftypefn

function delta = tmvs_uncertainty (id, q = 0)

qty = tmvs_quantity (id.quantity);

% TODO Replace these educated guesses with accurate data.
switch qty
case 'Temperature'
  delta = 1 + 0 * q;
case 'Relative Humidity'
  delta = 0.1 + 0 * q;
case 'Absolute Humidity'
  delta = 1e-3 + 0 * q;
case 'Pressure'
  delta = 10e+3 + 0 * q;
case 'Wind Speed'
  delta = 1 + 0 * q;
case 'Precipitation'
  delta = 1e-3 + 0 * q;
otherwise
  error ('unknown uncertainty for physical quantity ''%s''', qty);
end

end
