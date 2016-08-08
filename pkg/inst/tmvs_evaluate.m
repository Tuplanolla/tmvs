% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_evaluate (@var{interp}, @var{t})
%
% Convert an interpolator into an aggregate by evaluating it at certain points.
%
% If you want to evaluate an aggregate at several uniformly distributed points,
% take a look at @code{tmvs_evaluate}.
%
% This function converts the interpolator @var{interp}
% into the aggregate @var{aggr} by evaluating each function at @var{t}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
% interp = tmvs_interpolate (aggr);
% aggr = tmvs_evaluate (interp, datenum (2012, 1, 1));}
% @code{aggr(9).pairs}
% @result{} [734869, 7.695934]
% @end example
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));
% interp = tmvs_interpolate (aggr);
% aggr = tmvs_evaluate (interp, logspace ( ...
%   log10 (datenum (2012, 1, 1)), ...
%   log10 (datenum (2013, 1, 1))));}
% @code{aggr(3).pairs(1 : 2, :)}
% @result{} [734869.000000, 99172.738095; ...
% @result{}  734876.467566, 98921.152232]
% @end example
%
% @seealso{tmvs, tmvs_discretize, tmvs_interpolate}
%
% @end deftypefn

function aggr = tmvs_evaluate (interp, t)

t = t(:);

aggr = struct ('id', {}, 'meta', {}, 'pairs', {});
aggr = resize (aggr, size (interp));

for i = 1 : numel (interp)
  dom = interp(i).domain;

  if numel (dom) < 2
    z = [];
  else
    z = [t, (interp(i).function (t))];
  end

  aggr(i) = struct ('id', interp(i).id, 'meta', interp(i).meta, 'pairs', z);
end

end
