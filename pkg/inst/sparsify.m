% -*- texinfo -*-
% @deftypefn {Function File} {@var{i} =} sparsify (@var{x}, @var{n})
%
% Constructs such vector @var{i}
% that uniformly indexes at most @var{n} elements from @var{x},
% effectively making @var{x} sparser if it is too large.
% It follows that @code{numel (i) == min (n, numel (x))}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{sparsify ([-2, -1, 0, 1, 2], 2)}
% @result{} [1, 3]
% @code{x = linspace (0, 99, 100);}
% @code{x(sparsify (x, 10))}
% @result{} [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]
% @end example
%
% @seealso{interp1}
%
% @end deftypefn

function i = sparsify (x, n)

k = numel (x);

if k == 0 || n == 0
  i = [];
else
  m = max ([1, (floor (k / n))]);
  i = [1 : m : m * (min (k, n))];
end

end

%!test
%! assert (sparsify ([], 0), []);
%!test
%! assert (sparsify ([], 1), []);
%!test
%! assert (sparsify ([], 2), []);
%!test
%! assert (sparsify ([], 3), []);
%!test
%! assert (sparsify ([], 4), []);

%!test
%! assert (sparsify ([1], 0), []);
%!test
%! assert (sparsify ([1], 1), [1]);
%!test
%! assert (sparsify ([1], 2), [1]);
%!test
%! assert (sparsify ([1], 3), [1]);
%!test
%! assert (sparsify ([1], 4), [1]);

%!test
%! assert (sparsify ([1, 2], 0), []);
%!test
%! assert (sparsify ([1, 2], 1), [1]);
%!test
%! assert (sparsify ([1, 2], 2), [1, 2]);
%!test
%! assert (sparsify ([1, 2], 3), [1, 2]);
%!test
%! assert (sparsify ([1, 2], 4), [1, 2]);

%!test
%! assert (sparsify ([1, 2, 3], 0), []);
%!test
%! assert (sparsify ([1, 2, 3], 1), [1]);
%!test
%! assert (sparsify ([1, 2, 3], 2), [1, 2]);
%!test
%! assert (sparsify ([1, 2, 3], 3), [1, 2, 3]);
%!test
%! assert (sparsify ([1, 2, 3], 4), [1, 2, 3]);

%!test
%! assert (sparsify ([1, 2, 3, 4], 0), []);
%!test
%! assert (sparsify ([1, 2, 3, 4], 1), [1]);
%!test
%! assert (sparsify ([1, 2, 3, 4], 2), [1, 3]);
%!test
%! assert (sparsify ([1, 2, 3, 4], 3), [1, 2, 3]);
%!test
%! assert (sparsify ([1, 2, 3, 4], 4), [1, 2, 3, 4]);
