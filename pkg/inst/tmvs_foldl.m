% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_foldl (@var{f}, @var{x})
% @deftypefnx {Function File} {@var{y} =} tmvs_foldl (@var{f}, @var{x}, @var{z})
%
% Fold, also known as reduce, inject, accumulate, aggregate or
% cata (for catamorphism), breaks the data structure @var{x} down
% by applying the function @var{f} to each of its elements
% until only the result @var{y} is left.
% The left fold in particular starts from the beginning of @var{x} and
% works its way to the very end.
%
% If the initial value @var{z} is supplied,
% it is used as the first argument in the first function application
% as if it was the first element in @var{x}.
%
% The data structure @var{x} can be a matrix, a cell array or a structure.
% With matrices and cell arrays the function @var{f} should take two arguments.
% However with structures @var{f} should take three arguments,
% because the field names are supplied alongside the corresponding elements.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_foldl (@@plus, [1, 2, 3])}
% @result{} 6
% @code{tmvs_foldl (@@plus, [1, 2, 3], 4)}
% @result{} 10
% @code{tmvs_foldl (@@(y, x) y / x, [36, 6, 3])}
% @result{} 2
% @end example
%
% Other types work in a similar fashion.
%
% @example
% @code{tmvs_foldl (@@plus, @{1, 2, 3@})}
% @result{} 6
% @code{tmvs_foldl (@@(y, ~, x) y + x, struct ('one', 1, 'two', 2, 'three', 3))}
% @result{} 6
% @end example
%
% The following rule for matrices generalizes.
%
% @example
% @code{tmvs_foldl (@@(y, x) sprintf ('f (%s, x(%d))', y, x), [1 : 3], 'z')}
% @result{} 'f (f (f (z, x(1)), x(2)), x(3))'
% @end example
%
% Programming note: This is slightly faster than @code{tmvs_foldr}.
%
% @seealso{tmvs_foldr, reduce}
%
% @end deftypefn

function y = tmvs_foldl (f, x, z)

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
    y = x(1);
  case 2
    y = x{1};
  case 3
    y = x(1).(c{1});
    for j = 2 : m
      s = c{j};
      y = f (y, s, x(1).(s));
    end
  end
end

switch type
case 1
  for i = k : numel (x)
    y = f (y, x(i));
  end
case 2
  for i = k : numel (x)
    y = f (y, x{i});
  end
case 3
  for i = k : numel (x)
    for j = 1 : m
      s = c{j};
      y = f (y, s, x(i).(s));
    end
  end
otherwise
  error ('wrong type ''%s''', class (x));
end

end

% These tests are based on the OEIS sequences A173501 and A000142.

%!shared f, g
%! f = @(y, x) y / x;
%! g = @(y, s, x) str2double (s) * y / x;


%!error
%! tmvs_foldl (f, []);
%!test
%! assert (tmvs_foldl (f, [], 2), 2);

%!test
%! assert (tmvs_foldl (f, [2]), 2);
%!test
%! assert (tmvs_foldl (f, [3], 6), 2);

%!test
%! assert (tmvs_foldl (f, [6, 3]), 2);
%!test
%! assert (tmvs_foldl (f, [6, 3], 36), 2);
%!test
%! assert (tmvs_foldl (f, [6; 3]), 2);
%!test
%! assert (tmvs_foldl (f, [6; 3], 36), 2);

%!test
%! assert (tmvs_foldl (f, [1296, 36; 6, 3]), 2);
%!test
%! assert (tmvs_foldl (f, [1296, 36; 6, 3], 1679616), 2);


%!error
%! tmvs_foldl (f, {});
%!test
%! assert (tmvs_foldl (f, {}, 2), 2);

%!test
%! assert (tmvs_foldl (f, {2}), 2);
%!test
%! assert (tmvs_foldl (f, {3}, 6), 2);

%!test
%! assert (tmvs_foldl (f, {6, 3}), 2);
%!test
%! assert (tmvs_foldl (f, {6, 3}, 36), 2);
%!test
%! assert (tmvs_foldl (f, {6; 3}), 2);
%!test
%! assert (tmvs_foldl (f, {6; 3}, 36), 2);

%!test
%! assert (tmvs_foldl (f, {1296, 36; 6, 3}), 2);
%!test
%! assert (tmvs_foldl (f, {1296, 36; 6, 3}, 1679616), 2);


%!error
%! tmvs_foldl (g, struct ('1', {}));
%!test
%! assert (tmvs_foldl (g, struct ('1', {}), 2), 2);

%!test
%! assert (tmvs_foldl (g, struct ('1', {2})), 2);
%!test
%! assert (tmvs_foldl (g, struct ('1', {3}), 6), 2);

%!test
%! assert (tmvs_foldl (g, struct ('1', {6, 3})), 2);
%!test
%! assert (tmvs_foldl (g, struct ('1', {6, 3}), 36), 2);
%!test
%! assert (tmvs_foldl (g, struct ('1', {6}, '2', {3})), 4);
%!test
%! assert (tmvs_foldl (g, struct ('1', {6}, '2', {3}), 36), 4);

%!test
%! assert (tmvs_foldl (g, struct ('1', {1296, 36}, '2', {6, 3})), 8);
%!test
%! assert (tmvs_foldl (g, struct ('1', {1296, 36}, '2', {6, 3}), 1679616), 8);
