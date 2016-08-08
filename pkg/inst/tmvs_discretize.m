% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_discretize (@var{interp})
% @deftypefnx {Function File} {@var{aggr} =} tmvs_discretize (@var{interp}, @var{n})
%
% Convert an interpolator into an aggregate by evaluating it over its domain.
%
% If you want to evaluate an aggregate at a specific point,
% take a look at @code{tmvs_evaluate}.
%
% This function converts the interpolator @var{interp}
% into the aggregate @var{aggr} by evaluating each function
% at @var{n} uniformly distributed points in its domain.
% By default @var{n} is @code{100}, as it is for @code{linspace}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
% interp = tmvs_interpolate (aggr);
% aggr = tmvs_discretize (interp);}
% @code{aggr(9).pairs(1 : 2, :)}
% @result{} [734691.059525, 20.100000; ...
% @result{}  734694.252407, 19.642266]
% @end example
%
% @example
% @code{interp = tmvs_interpolate (tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla')), ...
%   'spline');}
% @code{plot (num2cell (tmvs_discretize (interp)(3).pairs, 1)@{:@});}
% @end example
%
% @seealso{tmvs, tmvs_evaluate, tmvs_interpolate}
%
% @end deftypefn

function aggr = tmvs_discretize (interp, n = 100)

aggr = struct ('id', {}, 'meta', {}, 'pairs', {});
aggr = resize (aggr, size (interp));

for i = 1 : numel (interp)
  dom = interp(i).domain;

  if isempty (dom)
    t = [];
  else
    t = linspace (num2cell (dom){:}, n);
  end

  aggr(i) = tmvs_evaluate (interp(i), t);
end

end
