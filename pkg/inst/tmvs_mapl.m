% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_mapl (@var{f}, @var{x})
%
% Map, also known as collect, apply or for-each,
% applies the function @var{f} to every element of the data structure @var{x}.
% If @var{f} has side effects, as it may, the application order also matters.
% The left map in particular starts from the beginning of @var{x} and
% works its way to the very end.
%
% The data structure @var{x} can be a matrix, a cell array or a structure.
% With matrices and cell arrays the function @var{f} should take one argument.
% However with structures @var{f} should take two arguments,
% because the field names are supplied alongside the corresponding elements.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_mapl (@@sqrt, [1, 4, 9])}
% @result{} [1, 2, 3]
% @code{tmvs_mapl (@@(x) mod (x, 2), [1, 2, 3])}
% @result{} [1, 0, 1]
% @end example
%
% Other types work in a similar fashion.
%
% @example
% @code{tmvs_mapl (@@sqrt, @{1, 4, 9@})}
% @result{} @{1, 2, 3@}
% @code{tmvs_mapl (@@(~, x) sqrt (x), struct ('one', 1, 'two', 4, 'three', 9))}
% @result{} struct ('one', 1, 'two', 2, 'three', 3)
% @code{tmvs_mapl (@@(~, x) sqrt (x), ...
%            struct ('one', @{1, 1@}, 'two', @{4, 4@}, 'three', @{9, 9@}))}
% @result{} struct ('one', @{1, 1@}, 'two', @{2, 2@}, 'three', @{3, 3@})
% @end example
%
% Mapping is structure-preserving, so the following is not allowed.
%
% @example
% @code{tmvs_mapl (@(x) rmfield (x, 'two'), ...
%            struct ('one', {1, 1}, 'two', {4, 4}))}
% @end example
%
% Programming note: This is slightly faster than @code{tmvs_mapr}.
%
% @seealso{tmvs_mapr, arrayfun, cellfun, structfun}
%
% @end deftypefn

function y = tmvs_mapl (f, x)

if isnumeric (x)
  type = 1;
elseif iscell (x)
  type = 2;
elseif isstruct (x)
  type = 3;
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
case 3
  c = sort (fieldnames (x));
  m = numel (c);

  for i = 1 : numel (x)
    for j = 1 : m
      s = c{j};
      y(i).(s) = f (s, x(i).(s));
    end
  end
otherwise
  error ('wrong type ''%s''', class (x));
end

end

%!shared f, g
%! f = @(x) -x;
%! g = @(s, x) str2double (s) * f (x);


%!test
%! assert (tmvs_mapl (f, []), []);

%!test
%! assert (tmvs_mapl (f, [1]), [-1]);

%!test
%! assert (tmvs_mapl (f, [-1, 1]), [1, -1]);
%!test
%! assert (tmvs_mapl (f, [-1; 1]), [1; -1]);

%!test
%! assert (tmvs_mapl (f, [-2, -1; 1, 2]), [2, 1; -1, -2]);


%!test
%! assert (tmvs_mapl (f, {}), {});

%!test
%! assert (tmvs_mapl (f, {1}), {-1});

%!test
%! assert (tmvs_mapl (f, {-1, 1}), {1, -1});
%!test
%! assert (tmvs_mapl (f, {-1; 1}), {1; -1});

%!test
%! assert (tmvs_mapl (f, {-2, -1; 1, 2}), {2, 1; -1, -2});


%!test
%! assert (tmvs_mapl (g, struct ('1', {})), struct ('1', {}));

%!test
%! assert (tmvs_mapl (g, struct ('1', {1})), struct ('1', {-1}));

%!test
%! assert (tmvs_mapl (g, struct ('1', {-1, 1})), struct ('1', {1, -1}));
%!test
%! assert (tmvs_mapl (g, struct ('1', {-1}, '2', {1})), ...
%!         struct ('1', {1}, '2', {-2}));

%!test
%! assert (tmvs_mapl (g, struct ('1', {-2, -1}, '2', {1, 2})), ...
%!         struct ('1', {2, 1}, '2', {-2, -4}));
