% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} foldr (@var{f}, @var{x})
% @deftypefnx {Function File} {@var{y} =} foldr (@var{f}, @var{x}, @var{z})
%
% Apply a binary function through a collection from right to left.
%
% Fold, also known as reduce, inject, accumulate, aggregate or
% cata (for catamorphism), breaks the data structure @var{x} down
% by applying the function @var{f} to each of its elements
% until only the result @var{y} is left.
% The right fold in particular starts from the end of @var{x} and
% works its way to the very beginning.
%
% If the initial value @var{z} is supplied,
% it is used as the initial value in the first function application
% as if it was the last element in @var{x}.
%
% The data structure @var{x} can be a matrix, a cell array or a structure and
% the function @var{f} should take two arguments.
% The first argument is always the previous result.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{foldr (@@plus, [1, 2, 3])}
% @result{} 6
% @end example
%
% @example
% @code{foldr (@@plus, [1, 2, 3], 4)}
% @result{} 10
% @end example
%
% @example
% @code{foldr (@@(x, y) y / x, [3, 6, 36])}
% @result{} 2
% @end example
%
% Other types work in a similar fashion.
%
% @example
% @code{foldr (@@plus, @{1, 2, 3@})}
% @result{} 6
% @end example
%
% @example
% @code{foldl ( ...
%   @@(s, y) y + s.one, ...
%   struct ('one', @{1, 2, 3@}, 'two', @{4, 5, 6@}), 0)}
% @result{} 6
% @end example
%
% The following rule for matrices generalizes.
%
% @example
% @code{foldr (@@(x, y) sprintf ('f (x(%d), %s)', x, y), [1 : 3], 'z')}
% @result{} 'f (x(1), f (x(2), f (x(3), z)))'
% @end example
%
% Programming note: This is slightly slower than @code{foldl}.
%
% @seealso{foldl, reduce}
%
% @end deftypefn

function y = foldr (f, x, z)

if isnumeric (x) || isstruct (x)
  type = 1;
elseif iscell (x)
  type = 2;
else
  type = 0;
end

if nargin () >= 3
  k = 1;
  y = z;
else
  k = 2;
  switch type
  case 1
    y = x(end);
  case 2
    y = x{end};
  end
end

n = numel (x);

switch type
case 1
  for i = k : n
    y = f (x(n - i + 1), y);
  end
case 2
  for i = k : n
    y = f (x{n - i + 1}, y);
  end
otherwise
  error ('wrong type ''%s''', class (x));
end

end

% These tests are based on the OEIS sequences A173501 and A000142.

%!shared f, g
%! f = @(x, y) y / x;
%! g = @(s, y) f (getfield (s, '1'), y);


%!error
%! foldr (f, []);
%!test
%! assert (foldr (f, [], 2), 2);

%!test
%! assert (foldr (f, [2]), 2);
%!test
%! assert (foldr (f, [3], 6), 2);

%!test
%! assert (foldr (f, [3, 6]), 2);
%!test
%! assert (foldr (f, [3, 6], 36), 2);
%!test
%! assert (foldr (f, [3; 6]), 2);
%!test
%! assert (foldr (f, [3; 6], 36), 2);

%!test
%! assert (foldr (f, [3, 6; 36, 1296]), 2);
%!test
%! assert (foldr (f, [3, 6; 36, 1296], 1679616), 2);


%!error
%! foldr (f, {});
%!test
%! assert (foldr (f, {}, 2), 2);

%!test
%! assert (foldr (f, {2}), 2);
%!test
%! assert (foldr (f, {3}, 6), 2);

%!test
%! assert (foldr (f, {3, 6}), 2);
%!test
%! assert (foldr (f, {3, 6}, 36), 2);
%!test
%! assert (foldr (f, {3; 6}), 2);
%!test
%! assert (foldr (f, {3; 6}, 36), 2);

%!test
%! assert (foldr (f, {3, 6; 36, 1296}), 2);
%!test
%! assert (foldr (f, {3, 6; 36, 1296}, 1679616), 2);


%!error
%! foldr (g, struct ('1', {}, '2', {}));
%!test
%! assert (foldr (g, struct ('1', {}, '2', {}), 2), 2);

%!test
%! assert (foldr (g, struct ('1', {3}, '2', {6}), 6), 2);

%!test
%! assert (foldr (g, struct ('1', {3, 6}, '2', {6, 12}), 36), 2);
%!test
%! assert (foldr (g, struct ('1', {3; 6}, '2', {6; 12}), 36), 2);

%!test
%! assert (foldr (g, struct ( ...
%!   '1', {3, 6; 36, 1296}, ...
%!   '2', {6, 12; 72, 2592}), 1679616), 2);
