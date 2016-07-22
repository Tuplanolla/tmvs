% -*- texinfo -*-
% @deftypefn {Function File} {@var{interp} =} tmvs_interpolate (@var{aggr}, @var{varargin})
%
% Converts the aggregate @var{aggr} into the interpolator @var{interp}.
% The possible options in @var{varargin} are those supported by @var{interp1}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{fieldnames (interp)}
% @result{} @{'id', 'meta', 'function', 'domain'@}
% @code{interp = tmvs_interpolate (aggr, 'spline');
% t = linspace (num2cell (interp(3).domain)@{:@});
% plot (t, interp(3).function(t));}
% @end example
%
% @seealso{tmvs, tmvs_discretize, tmvs_evaluate}
%
% @end deftypefn

function interp = tmvs_interpolate (aggr, varargin)

interp = struct ('id', {}, 'meta', {}, ...
                 'function', {}, 'domain', {}, 'codomain', {});
interp = resize (interp, size (aggr));

for i = 1 : numel (aggr)
  interp(i).id = aggr(i).id;
  interp(i).meta = aggr(i).meta;

  t = aggr(i).pairs(:, 1);

  if numel (t) < 2
    interp(i).function = @(ti) nan;
    interp(i).domain = [];
    interp(i).codomain = [];
  else
    x = aggr(i).pairs(:, 2);

    interp(i).function = @(ti) interp1 (t, x, ti, varargin{:});
    interp(i).domain = [(min (t)), (max (t))];
    interp(i).codomain = [(min (x)), (max (x))];
  end
end

end
