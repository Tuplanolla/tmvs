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
% @code{tmvs_foldr (@@(x, y) y / x, [2, 3, 6])}
% @result{} 1
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
% @end deftypefn

function y = tmvs_foldr (f, x, z)

if isnumeric (x)
elseif iscell (x)
elseif isstruct (x)
  c = fieldnames (x);
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

if nargin () == 3
  j = 1;
  y = z;
else
  j = 2;
  if isnumeric (x)
    y = x(end);
  elseif iscell (x)
    y = x{end};
  elseif isstruct (x)
    y = x.(c{end});
  else
    error (sprintf ('wrong type ''%s''', class (x)));
  end
end

if isnumeric (x)
  n = length (x);
  for i = j : n
    y = f (x(n - i + 1), y);
  end
elseif iscell (x)
  n = length (x);
  for i = j : n
    y = f (x{n - i + 1}, y);
  end
elseif isstruct (x)
  n = length (c);
  for i = j : n
    k = c{n - i + 1};
    y = f (k, x.(k), y);
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
