% -*- texinfo -*-
% @deftypefn {Function File} {} plota (@var{f}, @var{x}, @var{y}, @var{varargin})
%
% Runs an animation.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{plota (2, ...
%   [1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4], ...
%   [2, 1, 1, 1; 1, 2, 1, 1; 1, 1, 2, 1; 1, 1, 1, 2])}
% @code{plota (2, ...
%   @{[1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4], ...
%    [1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4]@}, ...
%   @{[2, 1, 1, 1; 1, 2, 1, 1; 1, 1, 2, 1; 1, 1, 1, 2], ...
%    [1, 1, 1, 3; 1, 1, 3, 1; 1, 3, 1, 1; 3, 1, 1, 1]@})}
% @end example
%
% @seealso{plot}
%
% @end deftypefn

function plota (f, x, y, varargin)

dt = 1 / (24 * 60 * 60 * f);

if ~iscell (x) && ~iscell (y)
  x = {x};
  y = {y};
end

k = min (cellfun (@rows, x));
m = min (cellfun (@rows, y));
n = k(1);

if ~(k == n && m == n)
  error ('mismatching rows %d and %d', k, m);
end

i = 1;

f = @(i) @(x) x(i, :);

h = plot ([(mapl (f(i), x)); (mapl (f(i), y))]{:}, varargin{:});

t0 = now ();

while i < n
  t1 = now ();

  if t1 - t0 < dt
    sleep (dt - (t1 - t0));
  else
    i = i + 1;

    for j = 1 : numel (y)
      set (h(j), 'XData', f (i) (x{j}));
      set (h(j), 'YData', f (i) (y{j}));
    end

    t0 = t0 + dt;
  end
end

end
