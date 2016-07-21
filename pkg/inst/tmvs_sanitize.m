% -*- texinfo -*-
% @deftypefn {Function File} {@var{saggr} =} tmvs_sanitize (@var{aggr})
%
% Produces the sanitized aggregate @var{saggr}
% by removing dubious data points from the aggregate @var{aggr}.
%
% What is dubious? Manual explains!
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr1 = tmvs_import ('excerpt/2012/118-0.csv', ...
%                      tmvs_source ('Test Lab'));
% aggr2 = tmvs_import ('excerpt/2011-2013-0.csv', ...
%                      tmvs_source ('Weather Observatory'), ...
%                      tmvs_region ('Jyvaskyla'));}
% @code{aggr = tmvs_merge (aggr1, aggr2);}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{size (aggr)}
% @result{} [1, 17]
% @end example
%
% @seealso{tmvs}
%
% @end deftypefn

function saggr = tmvs_sanitize (aggr)

for i = 1 : numel (aggr)
  z = aggr(i).pairs;

  switch tmvs_quantity (aggr(i).id.quantity)
  case 'Temperature'
    aggr(i).pairs = z(withinc (z(:, 2), [-100, 100]), :);
  case 'Relative Humidity'
    aggr(i).pairs = z(withinc (z(:, 2), [0, 0.99]), :);
  case 'Absolute Humidity'
    aggr(i).pairs = z(withinc (z(:, 2), [0, 1e+3]), :);
  case 'Pressure'
    aggr(i).pairs = z(withinc (z(:, 2), [20e+3, 200e+3]), :);
  case 'Wind Speed'
    aggr(i).pairs = z(withinc (z(:, 2), [0, 100]), :);
  case 'Precipitation'
    aggr(i).pairs = z(withinc (z(:, 2), [0, 1]), :);
  end
end

end
