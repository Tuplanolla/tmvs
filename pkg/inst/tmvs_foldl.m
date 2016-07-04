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
% it is used as the initial value in the first function application
% as if it was the first element in @var{x}.
%
% The data structure @var{x} can be a matrix, a cell array or a structure and
% the function @var{f} should take two arguments.
% The first argument is always the previous result.
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
% @code{tmvs_foldl (@@(y, s) y + s.one, ...
%             struct ('one', @{1, 2, 3@}, 'two', @{4, 5, 6@}), 0)}
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
    y = x(1);
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
    y = f (y, x(i));
  end
otherwise
  error ('wrong type ''%s''', class (x));
end

end

% These tests are based on the OEIS sequences A173501 and A000142.

%!shared f, g
%! f = @(y, x) y / x;
%! g = @(y, s) f (y, getfield (s, '1'));


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
%! tmvs_foldl (g, struct ('1', {}, '2', {}));
%!test
%! assert (tmvs_foldl (g, struct ('1', {}, '2', {}), 2), 2);

%!test
%! assert (tmvs_foldl (g, struct ('1', {3}, '2', {6}), 6), 2);

%!test
%! assert (tmvs_foldl (g, struct ('1', {6, 3}, '2', {12, 6}), 36), 2);
%!test
%! assert (tmvs_foldl (g, struct ('1', {6; 3}, '2', {12; 6}), 36), 2);

%!test
%! assert (tmvs_foldl (g, struct ('1', {1296, 36; 6, 3}, ...
%!                                '2', {2592, 72; 12, 6}), 1679616), 2);
