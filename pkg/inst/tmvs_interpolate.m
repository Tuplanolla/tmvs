% -*- texinfo -*-
% @deftypefn {Function File} {@var{interp} =} tmvs_interpolate (@var{aggr}, @var{varargin})
%
% Convert an aggregate into an interpolator.
%
% This function converts the aggregate @var{aggr}
% into the interpolator @var{interp}.
% Should there be identifiers for which there are not enough data points,
% the resulting interpolators will have empty domains and codomains.
% Optional options can be passed in @var{varargin} and
% are the same as those supported by @var{interp1}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
% interp = tmvs_interpolate (aggr);}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{fieldnames (interp)}
% @result{} @{'id', 'meta', 'function', 'domain', 'codomain'@}(:)
% @end example
%
% @example
% @code{interp = tmvs_interpolate (tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla')), ...
%   'spline');}
% @code{ezplot (interp(3).function, interp(3).domain);}
% @end example
%
% @seealso{tmvs, tmvs_discretize, tmvs_evaluate}
%
% @end deftypefn

function interp = tmvs_interpolate (aggr, varargin)

interp = struct ( ...
  'id', {}, 'meta', {}, 'function', {}, 'domain', {}, 'codomain', {});
interp = resize (interp, size (aggr));

for i = 1 : numel (aggr)
  interp(i).id = aggr(i).id;
  interp(i).meta = aggr(i).meta;

  t = aggr(i).pairs(:, 1);

  if numel (t) < 2
    interp(i).function = @(x) nan (size (x));
    interp(i).domain = [];
    interp(i).codomain = [];
  else
    q = aggr(i).pairs(:, 2);

    interp(i).function = @(x) interp1 (t, q, x, varargin{:});
    interp(i).domain = [(min (t)), (max (t))];
    interp(i).codomain = [(min (q)), (max (q))];
  end
end

end
