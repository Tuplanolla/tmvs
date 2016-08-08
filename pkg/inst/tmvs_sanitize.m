% -*- texinfo -*-
% @deftypefn {Function File} {@var{saggr} =} tmvs_sanitize (@var{aggr})
%
% Remove spurious data points from an aggregate.
%
% This function produces the sanitized aggregate @var{saggr}
% by removing spurious data points from the aggregate @var{aggr}.
% Values are considered spurious if they are
% way outside the physically possible realm of the ranges of the sensors.
% Examples include negative humidities and sonic wind speeds.
%
% The following example demonstrates basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));}
% @code{saggr = tmvs_sanitize (aggr);}
% @end example
%
% @seealso{tmvs, tmvs_uncertainty}
%
% @end deftypefn

function saggr = tmvs_sanitize (aggr)

saggr = aggr;

for i = 1 : numel (saggr)
  z = saggr(i).pairs;

  switch tmvs_quantity (saggr(i).id.quantity)
  case 'Temperature'
    saggr(i).pairs = z(withino (z(:, 2), [-100, 100]), :);
  case 'Relative Humidity'
    saggr(i).pairs = z(withinr (z(:, 2), [0, 1]), :);
  case 'Absolute Humidity'
    saggr(i).pairs = z(withinr (z(:, 2), [0, 1e+3]), :);
  case 'Pressure'
    saggr(i).pairs = z(withino (z(:, 2), [20e+3, 200e+3]), :);
  case 'Wind Speed'
    saggr(i).pairs = z(withinr (z(:, 2), [0, 300]), :);
  case 'Precipitation'
    saggr(i).pairs = z(withinr (z(:, 2), [0, 1]), :);
  end
end

end
