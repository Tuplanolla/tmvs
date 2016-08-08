% -*- texinfo -*-
% @deftypefn {Function File} {} axislim (@var{a}, @var{axis})
%
% Adjust an axis based on a collection of values.
%
% This procedure adjusts the axis @var{axis} in a way
% that makes every value in @var{a} is visible.
% This is useful for locking the axes during an animation.
%
% The following example demonstrates basic usage.
%
% @example
% @code{t = 2*pi * rand (64, 1);
% h = plot (2 * cos (t), 2 * sin (t));
% set (h, 'XData', cos (t));
% axislim (2 * sin (t), 'y');
% set (h, 'YData', sin (t));}
% @end example
%
% @seealso{axis, xlim, ylim, zlim}
%
% @end deftypefn

function r = axislim (a, axis)

r = [];

v = a(:);

if ~isempty (v)
  a = min (v);
  b = max (v);

  if a < b
    r = [a, b];

    switch axis
    case {'x', 1}
      xlim (r);
    case {'y', 2}
      ylim (r);
    case {'z', 3}
      zlim (r);
    otherwise
      error ('unknown axis');
    end
  end
end

end

%!shared x, y
%! x = [5, 2, 3, 4, 1, 4, 3, 2, 5];
%! y = [3, 4, 1, 4, 3, 2, 5, 2, 3];

%!error
%! axislim (x);

%!test
%! assert (axislim ([], 'x'), []);
%!test
%! assert (axislim ([], 'y'), []);
%!test
%! assert (axislim ([], 'z'), []);

%!test
%! figure (1);
%! clf ();
%! plot (x, y);
%! assert (axislim (x, 'x'), [1, 5]);
%! assert (axislim (y, 'y'), [1, 5]);
