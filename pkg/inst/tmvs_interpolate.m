% -*- texinfo -*-
% @deftypefn {Function File} {@var{interp} =} tmvs_interpolate (@var{aggr}, @var{varargin})
%
% Does things.
% Mention: all vars.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{fieldnames (interp)}
% @result{} @{'id', 'meta', 'function', 'limits'@}
% @code{interp = tmvs_interpolate (aggr, 'spline');
% t = linspace (num2cell (interp(3).limits){:});
% plot (t, interp(3).function(t));}
% @end example
%
% @seealso{tmvs, tmvs_discretize}
%
% @end deftypefn

function interp = tmvs_interpolate (aggr, varargin)

interp = struct ('id', {}, 'meta', {}, 'function', {}, 'limits', {});
interp = resize (interp, size (aggr));

for i = 1 : numel (aggr)
  t = aggr(i).pairs(:, 1);
  x = aggr(i).pairs(:, 2);

  if numel (t) < 2
    f = @(ti) nan;
    a = [];
  else
    f = @(ti) interp1 (t, x, ti, varargin{:});
    a = [(min (t)), (max (t))];
  end

  interp(i) = struct ('id', aggr(i).id, ...
                      'meta', aggr(i).meta, ...
                      'function', f, ...
                      'limits', a);
end

end
