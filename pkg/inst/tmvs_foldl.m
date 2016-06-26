% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_foldl (@var{f}, @var{x})
% @deftypefnx {Function File} {@var{y} =} tmvs_foldl (@var{f}, @var{x}, @var{z})
%
% Fold, also known as reduce, inject, accumulate, aggregate or cata,
% breaks the data structure @var{x} down
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
% @code{tmvs_foldl (@@(y, x) y / x, [6, 3, 2])}
% @result{} 1
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
% @seealso{tmvs_foldr}
% @end deftypefn

function y = tmvs_foldl (f, x, z)

if isnumeric (x)
elseif iscell (x)
elseif isstruct (x)
  s = fieldnames (x);
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

if nargin () == 3
  j = 1;
  y = z;
else
  j = 2;
  if isnumeric (x)
    y = x(1);
  elseif iscell (x)
    y = x{1};
  elseif isstruct (x)
    y = x.(s{1});
  else
    error (sprintf ('wrong type ''%s''', class (x)));
  end
end

if isnumeric (x)
  for i = j : length (x)
    y = f (y, x(i));
  end
elseif iscell (x)
  for i = j : length (x)
    y = f (y, x{i});
  end
elseif isstruct (x)
  for i = j : length (s)
    k = s{i};
    y = f (y, k, x.(k));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
