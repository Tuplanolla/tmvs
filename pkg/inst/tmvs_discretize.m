% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_discretize (@var{interp})
% @deftypefnx {Function File} {@var{aggr} =} tmvs_discretize (@var{interp}, @var{n})
%
% Converts the interpolator @var{interp} into the aggregate @var{aggr}
% by evaluating each function at @var{n} uniformly distributed points
% in its domain.
% By default @var{n} is @code{100}, as it is for @code{linspace}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{daggr = tmvs_discretize (interp);
% plot (num2cell (daggr(3).pairs, 1)@{:@});}
% @end example
%
% @seealso{tmvs, tmvs_interpolate, tmvs_evaluate}
%
% @end deftypefn

function aggr = tmvs_discretize (interp, n = 100)

aggr = struct ('id', {}, 'meta', {}, 'pairs', {});
aggr = resize (aggr, size (interp));

for i = 1 : numel (interp)
  t = linspace (num2cell (interp(i).domain){:}, n);
  aggr(i) = tmvs_evaluate (interp(i), t(:));
end

end
