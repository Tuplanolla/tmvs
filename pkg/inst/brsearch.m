% -*- texinfo -*-
% @deftypefn {Function File} {[@var{i}, @var{j}] =} brsearch (@var{v}, @var{x})
% @deftypefnx {Function File} {[@var{i}, @var{j}] =} brsearch (@var{v}, @var{x}, @var{f})
%
% Find elements in a sorted vector efficiently.
%
% Binary search, also known as half-interval search or logarithmic search,
% is the most efficient way to find the index of an element in a sorted array.
% Binary range search is a generalization of ordinary binary search and
% finds the range of indices from @var{i} to @var{j} that
% are equal to the element @var{x} in the array @var{v}.
% If the element @var{x} is not present in @var{v},
% @var{i} will be the position where it could be inserted
% (with the @code{v(i : end)} being pushed further) and
% @code{[i, j]} will be a degenerate interval
% (as in, the condition @code{j < i} will hold).
%
% The optional parameter @var{f} allows supplying a custom comparator,
% which returns zero when the first argument is equal to the second,
% a negative number when the first argument is smaller than the second and
% a positive number when the first argument is greater than the second.
% The default comparator is simply @code{@@(x, y) x - y}.
% or equivalently @code{@@(x, y) (x > y) - (x < y)}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{[i, j] = brsearch ([0, 0, 1, 2], 0)}
% @result{} i = 1
% @result{} j = 2
% @end example
%
% @example
% @code{[i, j] = brsearch ([-1, 0, 1, 2], 0)}
% @result{} i = 2
% @result{} j = 2
% @end example
%
% @example
% @code{[i, j] = brsearch ([-2, -1, 1, 2], 0)}
% @result{} i = 2
% @result{} j = 1
% @end example
%
% A custom comparator makes the search very versatile.
%
% @example
% @code{[i, j] = brsearch ( ...
%   [-2, -1, 0, 1, 2], 0, @@(x, y) (abs (x - y) > 1) * (x - y))}
% @result{} i = 2
% @result{} j = 4
% @end example
%
% @seealso{find}
%
% @end deftypefn

function [i, j] = brsearch (v, x, f = @(x, y) x - y)

i = 1;
j = numel (v);

while i <= j
  k = floor (i + (j - i) / 2);

  y = v(k);

  c = f (y, x);
  if c < 0
    i = k + 1;
  elseif c > 0
    j = k - 1;
  else
    n = i - 1;
    i = k;

    while i - n > 1
      m = floor (n + (i - n) / 2);

      y = v(m);

      if f (y, x) < 0
        n = m;
      else
        i = m;
      end
    end

    n = j + 1;
    j = k;

    while n - j > 1
      m = floor (j + (n - j) / 2);

      y = v(m);

      if f (y, x) > 0
        n = m;
      else
        j = m;
      end
    end

    break
  end
end

end

% This is probably the most comprehensive set of tests
% you will ever see (if you stay away from SQLite).

%!test
%! [i, j] = brsearch ([], 0);
%! assert ([i, j], [1, 0]);


%!test
%! [i, j] = brsearch ([0], 0);
%! assert ([i, j], [1, 1]);

%!test
%! [i, j] = brsearch ([1], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = brsearch ([-1], 0);
%! assert ([i, j], [2, 1]);


%!test
%! [i, j] = brsearch ([0, 0], 0);
%! assert ([i, j], [1, 2]);

%!test
%! [i, j] = brsearch ([0, 1], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = brsearch ([-1, 0], 0);
%! assert ([i, j], [2, 2]);

%!test
%! [i, j] = brsearch ([1, 2], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = brsearch ([-1, 1], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = brsearch ([-2, -1], 0);
%! assert ([i, j], [3, 2]);


%!test
%! [i, j] = brsearch ([0, 0, 0], 0);
%! assert ([i, j], [1, 3]);

%!test
%! [i, j] = brsearch ([0, 0, 1], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = brsearch ([-1, 0, 0], 0);
%! assert ([i, j], [2, 3]);

%!test
%! [i, j] = brsearch ([0, 1, 2], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = brsearch ([-1, 0, 1], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = brsearch ([-2, -1, 0], 0);
%! assert ([i, j], [3, 3]);

%!test
%! [i, j] = brsearch ([1, 2, 3], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = brsearch ([-1, 1, 2], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = brsearch ([-2, -1, 1], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = brsearch ([-3, -2, -1], 0);
%! assert ([i, j], [4, 3]);


%!test
%! [i, j] = brsearch ([0, 0, 0, 0], 0);
%! assert ([i, j], [1, 4]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 1], 0);
%! assert ([i, j], [1, 3]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0], 0);
%! assert ([i, j], [2, 4]);

%!test
%! [i, j] = brsearch ([0, 0, 1, 2], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 1], 0);
%! assert ([i, j], [2, 3]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0], 0);
%! assert ([i, j], [3, 4]);

%!test
%! [i, j] = brsearch ([0, 1, 2, 3], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = brsearch ([-1, 0, 1, 2], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 1], 0);
%! assert ([i, j], [3, 3]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 0], 0);
%! assert ([i, j], [4, 4]);

%!test
%! [i, j] = brsearch ([1, 2, 3, 4], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = brsearch ([-1, 1, 2, 3], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = brsearch ([-2, -1, 1, 2], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 1], 0);
%! assert ([i, j], [4, 3]);
%!test
%! [i, j] = brsearch ([-4, -3, -2, -1], 0);
%! assert ([i, j], [5, 4]);


%!test
%! [i, j] = brsearch ([0, 0, 0, 0, 0], 0);
%! assert ([i, j], [1, 5]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 0, 1], 0);
%! assert ([i, j], [1, 4]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0, 0], 0);
%! assert ([i, j], [2, 5]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 1, 2], 0);
%! assert ([i, j], [1, 3]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0, 1], 0);
%! assert ([i, j], [2, 4]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0, 0], 0);
%! assert ([i, j], [3, 5]);

%!test
%! [i, j] = brsearch ([0, 0, 1, 2, 3], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 1, 2], 0);
%! assert ([i, j], [2, 3]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0, 1], 0);
%! assert ([i, j], [3, 4]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 0, 0], 0);
%! assert ([i, j], [4, 5]);

%!test
%! [i, j] = brsearch ([0, 1, 2, 3, 4], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = brsearch ([-1, 0, 1, 2, 3], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 1, 2], 0);
%! assert ([i, j], [3, 3]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 0, 1], 0);
%! assert ([i, j], [4, 4]);
%!test
%! [i, j] = brsearch ([-4, -3, -2, -1, 0], 0);
%! assert ([i, j], [5, 5]);

%!test
%! [i, j] = brsearch ([1, 2, 3, 4, 5], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = brsearch ([-1, 1, 2, 3, 4], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = brsearch ([-3, -1, 1, 2, 3], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = brsearch ([-4, -2, -1, 1, 2], 0);
%! assert ([i, j], [4, 3]);
%!test
%! [i, j] = brsearch ([-5, -3, -2, -1, 1], 0);
%! assert ([i, j], [5, 4]);
%!test
%! [i, j] = brsearch ([-6, -4, -3, -2, -1], 0);
%! assert ([i, j], [6, 5]);


%!test
%! [i, j] = brsearch ([0, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [1, 6]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [1, 5]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [2, 6]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [1, 4]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [2, 5]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0, 0, 0], 0);
%! assert ([i, j], [3, 6]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [1, 3]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [2, 4]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0, 0, 1], 0);
%! assert ([i, j], [3, 5]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 0, 0, 0], 0);
%! assert ([i, j], [4, 6]);

%!test
%! [i, j] = brsearch ([0, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [2, 3]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0, 1, 2], 0);
%! assert ([i, j], [3, 4]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 0, 0, 1], 0);
%! assert ([i, j], [4, 5]);
%!test
%! [i, j] = brsearch ([-4, -3, -2, -1, 0, 0], 0);
%! assert ([i, j], [5, 6]);

%!test
%! [i, j] = brsearch ([0, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = brsearch ([-1, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = brsearch ([-3, -1, 0, 1, 2, 3], 0);
%! assert ([i, j], [3, 3]);
%!test
%! [i, j] = brsearch ([-4, -2, -1, 0, 1, 2], 0);
%! assert ([i, j], [4, 4]);
%!test
%! [i, j] = brsearch ([-5, -3, -2, -1, 0, 1], 0);
%! assert ([i, j], [5, 5]);
%!test
%! [i, j] = brsearch ([-6, -4, -3, -2, -1, 0], 0);
%! assert ([i, j], [6, 6]);

%!test
%! [i, j] = brsearch ([1, 2, 3, 4, 5, 6], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = brsearch ([-1, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = brsearch ([-2, -1, 1, 2, 3, 4], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 1, 2, 3], 0);
%! assert ([i, j], [4, 3]);
%!test
%! [i, j] = brsearch ([-4, -3, -2, -1, 1, 2], 0);
%! assert ([i, j], [5, 4]);
%!test
%! [i, j] = brsearch ([-5, -4, -3, -2, -1, 1], 0);
%! assert ([i, j], [6, 5]);
%!test
%! [i, j] = brsearch ([-6, -5, -4, -3, -2, -1], 0);
%! assert ([i, j], [7, 6]);


%!test
%! [i, j] = brsearch ([0, 0, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [1, 7]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [1, 6]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [2, 7]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [1, 5]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [2, 6]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [3, 7]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [1, 4]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [2, 5]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [3, 6]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 0, 0, 0, 0], 0);
%! assert ([i, j], [4, 7]);

%!test
%! [i, j] = brsearch ([0, 0, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [1, 3]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [2, 4]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [3, 5]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 0, 0, 0, 1], 0);
%! assert ([i, j], [4, 6]);
%!test
%! [i, j] = brsearch ([-4, -3, -2, -1, 0, 0, 0], 0);
%! assert ([i, j], [5, 7]);

%!test
%! [i, j] = brsearch ([0, 0, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = brsearch ([-1, 0, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [2, 3]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [3, 4]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 0, 0, 1, 2], 0);
%! assert ([i, j], [4, 5]);
%!test
%! [i, j] = brsearch ([-4, -3, -2, -1, 0, 0, 1], 0);
%! assert ([i, j], [5, 6]);
%!test
%! [i, j] = brsearch ([-5, -4, -3, -2, -1, 0, 0], 0);
%! assert ([i, j], [6, 7]);

%!test
%! [i, j] = brsearch ([0, 1, 2, 3, 4, 5, 6], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = brsearch ([-1, 0, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = brsearch ([-2, -1, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [3, 3]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 0, 1, 2, 3], 0);
%! assert ([i, j], [4, 4]);
%!test
%! [i, j] = brsearch ([-4, -3, -2, -1, 0, 1, 2], 0);
%! assert ([i, j], [5, 5]);
%!test
%! [i, j] = brsearch ([-5, -4, -3, -2, -1, 0, 1], 0);
%! assert ([i, j], [6, 6]);
%!test
%! [i, j] = brsearch ([-6, -5, -4, -3, -2, -1, 0], 0);
%! assert ([i, j], [7, 7]);

%!test
%! [i, j] = brsearch ([1, 2, 3, 4, 5, 6, 7], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = brsearch ([-1, 1, 2, 3, 4, 5, 6], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = brsearch ([-2, -1, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = brsearch ([-3, -2, -1, 1, 2, 3, 4], 0);
%! assert ([i, j], [4, 3]);
%!test
%! [i, j] = brsearch ([-4, -3, -2, -1, 1, 2, 3], 0);
%! assert ([i, j], [5, 4]);
%!test
%! [i, j] = brsearch ([-5, -4, -3, -2, -1, 1, 2], 0);
%! assert ([i, j], [6, 5]);
%!test
%! [i, j] = brsearch ([-6, -5, -4, -3, -2, -1, 1], 0);
%! assert ([i, j], [7, 6]);
%!test
%! [i, j] = brsearch ([-7, -6, -5, -4, -3, -2, -1], 0);
%! assert ([i, j], [8, 7]);
