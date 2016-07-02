% -*- texinfo -*-
% @deftypefn {Function File} {[@var{i}, @var{j}] =} tmvs_brsearch (@var{a}, @var{x})
%
% Binary search, also known as half-interval search or logarithmic search,
% is the most efficient way to find the index of an element in a sorted array.
% Binary range search is a generalization of ordinary binary search and
% finds the range of indices from @var{i} to @var{j} that
% are equal to the element @var{x} in the array @var{a}.
% If the element @var{x} is not present in @var{a},
% @var{i} will be the position where it could be inserted
% (with the @code{a(i : end)} being pushed further) and
% @code{[i, j]} will be a degenerate interval
% (as in, the condition @code{j < i} will hold).
%
% The following examples demonstrate basic usage.
%
% @example
% @code{[i, j] = tmvs_brsearch ([0, 0, 1, 2], 0)}
% @result{} [1, 2]
% @code{[i, j] = tmvs_brsearch ([-1, 0, 1, 2], 0)}
% @result{} [2, 2]
% @code{[i, j] = tmvs_brsearch ([-2, -1, 1, 2], 0)}
% @result{} [2, 1]
% @end example
%
% @seealso{find}
% @end deftypefn

function [i, j] = tmvs_brsearch (a, x)

i = 1;
j = length (a);

while i <= j
  k = floor (i + (j - i) / 2);

  y = a(k);

  if y < x
    i = k + 1;
  elseif y > x
    j = k - 1;
  else
    n = i - 1;
    i = k;

    while i - n > 1
      m = floor (n + (i - n) / 2);

      y = a(m);

      if y < x
        n = m;
      else
        i = m;
      end
    end

    n = j + 1;
    j = k;

    while n - j > 1
      m = floor (j + (n - j) / 2);

      y = a(m);

      if y > x
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
%! [i, j] = tmvs_brsearch ([], 0);
%! assert ([i, j], [1, 0]);


%!test
%! [i, j] = tmvs_brsearch ([0], 0);
%! assert ([i, j], [1, 1]);

%!test
%! [i, j] = tmvs_brsearch ([1], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = tmvs_brsearch ([-1], 0);
%! assert ([i, j], [2, 1]);


%!test
%! [i, j] = tmvs_brsearch ([0, 0], 0);
%! assert ([i, j], [1, 2]);

%!test
%! [i, j] = tmvs_brsearch ([0, 1], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0], 0);
%! assert ([i, j], [2, 2]);

%!test
%! [i, j] = tmvs_brsearch ([1, 2], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 1], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1], 0);
%! assert ([i, j], [3, 2]);


%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0], 0);
%! assert ([i, j], [1, 3]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 1], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0], 0);
%! assert ([i, j], [2, 3]);

%!test
%! [i, j] = tmvs_brsearch ([0, 1, 2], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 1], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0], 0);
%! assert ([i, j], [3, 3]);

%!test
%! [i, j] = tmvs_brsearch ([1, 2, 3], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 1, 2], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 1], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1], 0);
%! assert ([i, j], [4, 3]);


%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0], 0);
%! assert ([i, j], [1, 4]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 1], 0);
%! assert ([i, j], [1, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0], 0);
%! assert ([i, j], [2, 4]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 1, 2], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 1], 0);
%! assert ([i, j], [2, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0], 0);
%! assert ([i, j], [3, 4]);

%!test
%! [i, j] = tmvs_brsearch ([0, 1, 2, 3], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 1, 2], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 1], 0);
%! assert ([i, j], [3, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 0], 0);
%! assert ([i, j], [4, 4]);

%!test
%! [i, j] = tmvs_brsearch ([1, 2, 3, 4], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 1, 2, 3], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 1, 2], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 1], 0);
%! assert ([i, j], [4, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -3, -2, -1], 0);
%! assert ([i, j], [5, 4]);


%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0, 0], 0);
%! assert ([i, j], [1, 5]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0, 1], 0);
%! assert ([i, j], [1, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0, 0], 0);
%! assert ([i, j], [2, 5]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 1, 2], 0);
%! assert ([i, j], [1, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0, 1], 0);
%! assert ([i, j], [2, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0, 0], 0);
%! assert ([i, j], [3, 5]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 1, 2, 3], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 1, 2], 0);
%! assert ([i, j], [2, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0, 1], 0);
%! assert ([i, j], [3, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 0, 0], 0);
%! assert ([i, j], [4, 5]);

%!test
%! [i, j] = tmvs_brsearch ([0, 1, 2, 3, 4], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 1, 2, 3], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 1, 2], 0);
%! assert ([i, j], [3, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 0, 1], 0);
%! assert ([i, j], [4, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -3, -2, -1, 0], 0);
%! assert ([i, j], [5, 5]);

%!test
%! [i, j] = tmvs_brsearch ([1, 2, 3, 4, 5], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 1, 2, 3, 4], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -1, 1, 2, 3], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -2, -1, 1, 2], 0);
%! assert ([i, j], [4, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-5, -3, -2, -1, 1], 0);
%! assert ([i, j], [5, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-6, -4, -3, -2, -1], 0);
%! assert ([i, j], [6, 5]);


%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [1, 6]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [1, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [2, 6]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [1, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [2, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0, 0, 0], 0);
%! assert ([i, j], [3, 6]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [1, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [2, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0, 0, 1], 0);
%! assert ([i, j], [3, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 0, 0, 0], 0);
%! assert ([i, j], [4, 6]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [2, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0, 1, 2], 0);
%! assert ([i, j], [3, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 0, 0, 1], 0);
%! assert ([i, j], [4, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -3, -2, -1, 0, 0], 0);
%! assert ([i, j], [5, 6]);

%!test
%! [i, j] = tmvs_brsearch ([0, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -1, 0, 1, 2, 3], 0);
%! assert ([i, j], [3, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -2, -1, 0, 1, 2], 0);
%! assert ([i, j], [4, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-5, -3, -2, -1, 0, 1], 0);
%! assert ([i, j], [5, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-6, -4, -3, -2, -1, 0], 0);
%! assert ([i, j], [6, 6]);

%!test
%! [i, j] = tmvs_brsearch ([1, 2, 3, 4, 5, 6], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 1, 2, 3, 4], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 1, 2, 3], 0);
%! assert ([i, j], [4, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -3, -2, -1, 1, 2], 0);
%! assert ([i, j], [5, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-5, -4, -3, -2, -1, 1], 0);
%! assert ([i, j], [6, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-6, -5, -4, -3, -2, -1], 0);
%! assert ([i, j], [7, 6]);


%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [1, 7]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [1, 6]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [2, 7]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [1, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [2, 6]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0, 0, 0, 0], 0);
%! assert ([i, j], [3, 7]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [1, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [2, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0, 0, 0, 1], 0);
%! assert ([i, j], [3, 6]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 0, 0, 0, 0], 0);
%! assert ([i, j], [4, 7]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [1, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [2, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0, 0, 1, 2], 0);
%! assert ([i, j], [3, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 0, 0, 0, 1], 0);
%! assert ([i, j], [4, 6]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -3, -2, -1, 0, 0, 0], 0);
%! assert ([i, j], [5, 7]);

%!test
%! [i, j] = tmvs_brsearch ([0, 0, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [1, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [2, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 0, 1, 2, 3], 0);
%! assert ([i, j], [3, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 0, 0, 1, 2], 0);
%! assert ([i, j], [4, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -3, -2, -1, 0, 0, 1], 0);
%! assert ([i, j], [5, 6]);
%!test
%! [i, j] = tmvs_brsearch ([-5, -4, -3, -2, -1, 0, 0], 0);
%! assert ([i, j], [6, 7]);

%!test
%! [i, j] = tmvs_brsearch ([0, 1, 2, 3, 4, 5, 6], 0);
%! assert ([i, j], [1, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 0, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [2, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 0, 1, 2, 3, 4], 0);
%! assert ([i, j], [3, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 0, 1, 2, 3], 0);
%! assert ([i, j], [4, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -3, -2, -1, 0, 1, 2], 0);
%! assert ([i, j], [5, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-5, -4, -3, -2, -1, 0, 1], 0);
%! assert ([i, j], [6, 6]);
%!test
%! [i, j] = tmvs_brsearch ([-6, -5, -4, -3, -2, -1, 0], 0);
%! assert ([i, j], [7, 7]);

%!test
%! [i, j] = tmvs_brsearch ([1, 2, 3, 4, 5, 6, 7], 0);
%! assert ([i, j], [1, 0]);
%!test
%! [i, j] = tmvs_brsearch ([-1, 1, 2, 3, 4, 5, 6], 0);
%! assert ([i, j], [2, 1]);
%!test
%! [i, j] = tmvs_brsearch ([-2, -1, 1, 2, 3, 4, 5], 0);
%! assert ([i, j], [3, 2]);
%!test
%! [i, j] = tmvs_brsearch ([-3, -2, -1, 1, 2, 3, 4], 0);
%! assert ([i, j], [4, 3]);
%!test
%! [i, j] = tmvs_brsearch ([-4, -3, -2, -1, 1, 2, 3], 0);
%! assert ([i, j], [5, 4]);
%!test
%! [i, j] = tmvs_brsearch ([-5, -4, -3, -2, -1, 1, 2], 0);
%! assert ([i, j], [6, 5]);
%!test
%! [i, j] = tmvs_brsearch ([-6, -5, -4, -3, -2, -1, 1], 0);
%! assert ([i, j], [7, 6]);
%!test
%! [i, j] = tmvs_brsearch ([-7, -6, -5, -4, -3, -2, -1], 0);
%! assert ([i, j], [8, 7]);
