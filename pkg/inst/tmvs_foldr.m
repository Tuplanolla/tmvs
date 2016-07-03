% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_foldr (@var{f}, @var{x})
% @deftypefnx {Function File} {@var{y} =} tmvs_foldr (@var{f}, @var{x}, @var{z})
%
% Fold, also known as reduce, inject, accumulate, aggregate or
% cata (for catamorphism), breaks the data structure @var{x} down
% by applying the function @var{f} to each of its elements
% until only the result @var{y} is left.
% The right fold in particular starts from the end of @var{x} and
% works its way to the very beginning.
%
% If the initial value @var{z} is supplied,
% it is used as the second argument in the first function application
% as if it was the last element in @var{x}.
%
% The data structure @var{x} can be a matrix, a cell array or a structure.
% With matrices and cell arrays the function @var{f} should take two arguments.
% However with structures @var{f} should take three arguments,
% because the field names are supplied alongside the corresponding elements.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_foldr (@@plus, [1, 2, 3])}
% @result{} 6
% @code{tmvs_foldr (@@plus, [1, 2, 3], 4)}
% @result{} 10
% @code{tmvs_foldr (@@(x, y) y / x, [3, 6, 36])}
% @result{} 2
% @end example
%
% Other types work in a similar fashion.
%
% @example
% @code{tmvs_foldr (@@plus, @{1, 2, 3@})}
% @result{} 6
% @code{tmvs_foldr (@@(x, ~, y) x + y, struct ('one', 1, 'two', 2, 'three', 3))}
% @result{} 6
% @end example
%
% The following rule for matrices generalizes.
%
% @example
% @code{tmvs_foldr (@@(x, y) sprintf ('f (x(%d), %s)', x, y), [1 : 3], 'z')}
% @result{} 'f (x(1), f (x(2), f (x(3), z)))'
% @end example
%
% Programming note: This is slightly slower than @code{tmvs_foldl}.
%
% @seealso{tmvs_foldl, reduce}
%
% @end deftypefn

function y = tmvs_foldr (f, x, z)

if isnumeric (x)
  type = 1;
elseif iscell (x)
  type = 2;
elseif isstruct (x)
  c = sort (fieldnames (x));
  m = numel (c);

  type = 3;
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
  case 3
    y = x(end).(c{end});
    for j = 2 : m
      s = c{end - j + 1};
      y = f (s, x(end).(s), y);
    end
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
case 3
  for i = k : n
    for j = 1 : m
      s = c{j};
      y = f (s, x(n - i + 1).(s), y);
    end
  end
otherwise
  error ('wrong type ''%s''', class (x));
end

end

% These tests are based on the OEIS sequences A173501 and A000142.

%!shared f, g
%! f = @(x, y) y / x;
%! g = @(s, x, y) str2double (s) * y / x;


%!error
%! tmvs_foldr (f, []);
%!test
%! assert (tmvs_foldr (f, [], 2), 2);

%!test
%! assert (tmvs_foldr (f, [2]), 2);
%!test
%! assert (tmvs_foldr (f, [3], 6), 2);

%!test
%! assert (tmvs_foldr (f, [3, 6]), 2);
%!test
%! assert (tmvs_foldr (f, [3, 6], 36), 2);
%!test
%! assert (tmvs_foldr (f, [3; 6]), 2);
%!test
%! assert (tmvs_foldr (f, [3; 6], 36), 2);

%!test
%! assert (tmvs_foldr (f, [3, 6; 36, 1296]), 2);
%!test
%! assert (tmvs_foldr (f, [3, 6; 36, 1296], 1679616), 2);


%!error
%! tmvs_foldr (f, {});
%!test
%! assert (tmvs_foldr (f, {}, 2), 2);

%!test
%! assert (tmvs_foldr (f, {2}), 2);
%!test
%! assert (tmvs_foldr (f, {3}, 6), 2);

%!test
%! assert (tmvs_foldr (f, {3, 6}), 2);
%!test
%! assert (tmvs_foldr (f, {3, 6}, 36), 2);
%!test
%! assert (tmvs_foldr (f, {3; 6}), 2);
%!test
%! assert (tmvs_foldr (f, {3; 6}, 36), 2);

%!test
%! assert (tmvs_foldr (f, {3, 6; 36, 1296}), 2);
%!test
%! assert (tmvs_foldr (f, {3, 6; 36, 1296}, 1679616), 2);


%!error
%! tmvs_foldr (g, struct ('1', {}));
%!test
%! assert (tmvs_foldr (g, struct ('1', {}), 2), 2);

%!test
%! assert (tmvs_foldr (g, struct ('1', {2})), 2);
%!test
%! assert (tmvs_foldr (g, struct ('1', {3}), 6), 2);

%!test
%! assert (tmvs_foldr (g, struct ('1', {3, 6})), 2);
%!test
%! assert (tmvs_foldr (g, struct ('1', {3, 6}), 36), 2);
%!test
%! assert (tmvs_foldr (g, struct ('1', {3}, '2', {6})), 2);
%!test
%! assert (tmvs_foldr (g, struct ('1', {3}, '2', {6}), 36), 4);

%!test
%! assert (tmvs_foldr (g, struct ('1', {3, 6}, '2', {36, 1296})), 4);
%!test
%! assert (tmvs_foldr (g, struct ('1', {3, 6}, '2', {36, 1296}), 1679616), 8);
