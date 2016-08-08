% -*- texinfo -*-
% @deftypefn {Function File} {} plots (@var{f}, @var{x}, @var{y}, @var{varargin})
%
% Animate a sequence of plots.
%
% Plots each row of @var{x} versus @var{y} at @var{f} frames per second.
% The options in @var{varargin} are passed through to @code{plot}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{plots (2, ...
%   [1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4], ...
%   [2, 1, 1, 1; 1, 2, 1, 1; 1, 1, 2, 1; 1, 1, 1, 2]);}
% @end example
%
% Multiple graphs can be passed in a cell array to plot them simultaneously.
%
% @example
% @code{plots (2, ...
%   @{[1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4], ...
%    [1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4; 1, 2, 3, 4]@}, ...
%   @{[2, 1, 1, 1; 1, 2, 1, 1; 1, 1, 2, 1; 1, 1, 1, 2], ...
%    [1, 1, 1, 3; 1, 1, 3, 1; 1, 3, 1, 1; 3, 1, 1, 1]@});}
% @end example
%
% If either @var{x} or @var{y} remains constant,
% repeating them is not necessary.
%
% @example
% @code{plots (2, ...
%   [1, 2, 3, 4], ...
%   [2, 1, 1, 1; 1, 2, 1, 1; 1, 1, 2, 1; 1, 1, 1, 2]);}
% @end example
%
% @example
% @code{plots (2, ...
%   @{[1, 2, 3, 4], ...
%    [1, 2, 3, 4]@}, ...
%   @{[2, 1, 1, 1; 1, 2, 1, 1; 1, 1, 2, 1; 1, 1, 1, 2], ...
%    [1, 1, 1, 3; 1, 1, 3, 1; 1, 3, 1, 1; 3, 1, 1, 1]@});}
% @end example
%
% @seealso{plot}
%
% @end deftypefn

function plots (f, x, y, varargin)

dt = 1 / (24 * 60 * 60 * f);

if ~iscell (x) && ~iscell (y)
  x = {x};
  y = {y};
end

k = cellfun (@rows, x);
m = cellfun (@rows, y);

n = max ([k(1), m(1)]);

cx = k(1) == 1;
cy = m(1) == 1;

if ~((cx || k == n) && (cy || m == n))
  error ('mismatching numbers of rows');
end

if ~(cellfun (@columns, x) == cellfun (@columns, y))
  error ('mismatching numbers of columns');
end

i = 1;

f = @(i) @(x) x(i, :);

h = plot ([(mapl (f(i), x)); (mapl (f(i), y))]{:}, varargin{:});

g = @(y, x) [y; x(:)];
axislim (foldl (g, x, []), 'x');
axislim (foldl (g, y, []), 'y');

t0 = now ();

while i < n
  t1 = now ();

  if t1 - t0 < dt
    sleep (dt - (t1 - t0));
  else
    i = i + 1;

    for j = 1 : numel (y)
      if ~cx
        set (h(j), 'XData', f (i) (x{j}));
      end

      if ~cy
        set (h(j), 'YData', f (i) (y{j}));
      end
    end

    t0 = t0 + dt;
  end
end

end

%!function f (x, y)
%! figure (1);
%! clf ();
%! plots (60, x, y);
%!endfunction

%!error
%! f ([], []);
%!error
%! f ([], [1]);
%!error
%! f ([], [1, 2]);
%!error
%! f ([], [1, 2; 3, 4]);
%!error
%! f ([1], []);
%!test
%! f ([1], [1]);
%!error
%! f ([1], [1, 2]);
%!error
%! f ([1], [1, 2; 3, 4]);
%!error
%! f ([1, 2], []);
%!error
%! f ([1, 2], [1]);
%!test
%! f ([1, 2], [1, 2]);
%!test
%! f ([1, 2], [1, 2; 3, 4]);
%!error
%! f ([1, 2; 3, 4], []);
%!error
%! f ([1, 2; 3, 4], [1]);
%!test
%! f ([1, 2; 3, 4], [1, 2]);
%!test
%! f ([1, 2; 3, 4], [1, 2; 3, 4]);

%!error
%! f ({[], []}, {[], []});
%!error
%! f ({[], [1]}, {[], [1]});
%!error
%! f ({[], [1, 2]}, {[], [1, 2]});
%!error
%! f ({[], [1, 2; 3, 4]}, {[], [1, 2; 3, 4]});
%!error
%! f ({[1], []}, {[1], []});
%!test
%! f ({[1], [1]}, {[1], [1]});
%!test
%! f ({[1], [1, 2]}, {[1], [1, 2]});
%!test
%! f ({[1], [1, 2; 3, 4]}, {[1], [1, 2; 3, 4]});
%!error
%! f ({[1, 2], []}, {[1, 2], []});
%!test
%! f ({[1, 2], [1]}, {[1, 2], [1]});
%!test
%! f ({[1, 2], [1, 2]}, {[1, 2], [1, 2]});
%!test
%! f ({[1, 2], [1, 2; 3, 4]}, {[1, 2], [1, 2; 3, 4]});
%!error
%! f ({[1, 2; 3, 4], []}, {[1, 2; 3, 4], []});
%!error
%! f ({[1, 2; 3, 4], [1]}, {[1, 2; 3, 4], [1]});
%!error
%! f ({[1, 2; 3, 4], [1, 2]}, {[1, 2; 3, 4], [1, 2]});
%!test
%! f ({[1, 2; 3, 4], [1, 2; 3, 4]}, {[1, 2; 3, 4], [1, 2; 3, 4]});

%!error
%! f ({[], []}, {[], []});
%!error
%! f ({[], [1]}, {[1], []});
%!error
%! f ({[], [1, 2]}, {[1, 2], []});
%!error
%! f ({[], [1, 2; 3, 4]}, {[1, 2; 3, 4], []});
%!error
%! f ({[1], []}, {[], [1]});
%!test
%! f ({[1], [1]}, {[1], [1]});
%!error
%! f ({[1], [1, 2]}, {[1, 2], [1]});
%!error
%! f ({[1], [1, 2; 3, 4]}, {[1, 2; 3, 4], [1]});
%!error
%! f ({[1, 2], []}, {[], [1, 2]});
%!error
%! f ({[1, 2], [1]}, {[1], [1, 2]});
%!test
%! f ({[1, 2], [1, 2]}, {[1, 2], [1, 2]});
%!error
%! f ({[1, 2], [1, 2; 3, 4]}, {[1, 2; 3, 4], [1, 2]});
%!error
%! f ({[1, 2; 3, 4], []}, {[], [1, 2; 3, 4]});
%!error
%! f ({[1, 2; 3, 4], [1]}, {[1], [1, 2; 3, 4]});
%!error
%! f ({[1, 2; 3, 4], [1, 2]}, {[1, 2], [1, 2; 3, 4]});
%!test
%! f ({[1, 2; 3, 4], [1, 2; 3, 4]}, {[1, 2; 3, 4], [1, 2; 3, 4]});
