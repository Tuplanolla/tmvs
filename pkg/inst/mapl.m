% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} mapl (@var{f}, @var{x})
%
% Apply a function to every element in a collection from left to right.
%
% Map, also known as collect, apply or for-each,
% applies the function @var{f} to every element of the data structure @var{x}.
% If @var{f} has side effects, as it may, the application order also matters.
% The left map in particular starts from the beginning of @var{x} and
% works its way to the very end.
%
% The data structure @var{x} can be a matrix, a cell array or a structure and
% the function @var{f} should take one argument.
% In the case of structures, @var{f} must not add or remove fields.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{mapl (@@sqrt, [1, 4, 9])}
% @result{} [1, 2, 3]
% @end example
%
% @example
% @code{mapl (@@(x) mod (x, 2), [1, 2, 3])}
% @result{} [1, 0, 1]
% @end example
%
% Other types work in a similar fashion.
%
% @example
% @code{mapl (@@sqrt, @{1, 4, 9@})}
% @result{} @{1, 2, 3@}
% @end example
%
% @example
% @code{mapl ( ...
%   @@(s) setfield (s, 'two', 2 * s.one), ...
%   struct ('one', 1, 'two', 4))}
% @result{} struct ('one', 1, 'two', 2)
% @end example
%
% @example
% @code{mapl ( ...
%   @@(s) setfield (s, 'two', 2 * s.one), ...
%   struct ('one', @{1, 1@}, 'two', @{4, 4@}))}
% @result{} struct ('one', @{1, 1@}, 'two', @{2, 2@})
% @end example
%
% Mapping is structure-preserving, so the following is not allowed.
%
% @example
% @code{mapl ( ...
%   @@(s) rmfield (s, 'two'), ...
%   struct ('one', @{1, 1@}, 'two', @{4, 4@}))}
% @end example
%
% Programming note: This is slightly faster than @code{mapr}.
%
% @seealso{mapr, arrayfun, cellfun, structfun}
%
% @end deftypefn

function y = mapl (f, x)

if isnumeric (x) || isstruct (x)
  type = 1;
elseif iscell (x)
  type = 2;
else
  type = 0;
end

y = x;

switch type
case 1
  for i = 1 : numel (x)
    y(i) = f (x(i));
  end
case 2
  for i = 1 : numel (x)
    y{i} = f (x{i});
  end
otherwise
  error ('wrong type ''%s''', class (x));
end

end

%!shared f, g
%! f = @(x) -x;
%! g = @(s) setfield (s, '2', f (getfield (s, '1')));


%!test
%! assert (mapl (f, []), []);

%!test
%! assert (mapl (f, [1]), [-1]);

%!test
%! assert (mapl (f, [-1, 1]), [1, -1]);
%!test
%! assert (mapl (f, [-1; 1]), [1; -1]);

%!test
%! assert (mapl (f, [-2, -1; 1, 2]), [2, 1; -1, -2]);


%!test
%! assert (mapl (f, {}), {});

%!test
%! assert (mapl (f, {1}), {-1});

%!test
%! assert (mapl (f, {-1, 1}), {1, -1});
%!test
%! assert (mapl (f, {-1; 1}), {1; -1});

%!test
%! assert (mapl (f, {-2, -1; 1, 2}), {2, 1; -1, -2});


%!test
%! assert (mapl (g, struct ('1', {})), struct ('1', {}));

%!test
%! assert ( ...
%!   mapl (g, struct ('1', {-1}, '2', {1})), ...
%!   struct ('1', {-1}, '2', {1}));

%!test
%! assert ( ...
%!   mapl (g, struct ('1', {-2, -1}, '2', {1, 2})), ...
%!   struct ('1', {-2, -1}, '2', {2, 1}));
%!test
%! assert ( ...
%!   mapl (g, struct ('1', {-2; -1}, '2', {1; 2})), ...
%!   struct ('1', {-2; -1}, '2', {2; 1}));

%!test
%! assert ( ...
%!   mapl (g, struct ('1', {-4, -3; -2, -1}, '2', {1, 2; 3, 4})), ...
%!   struct ('1', {-4, -3; -2, -1}, '2', {4, 3; 2, 1}));
