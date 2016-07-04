% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_filter (@var{f}, @var{x})
%
% Filter, also known as select, find or copy-if,
% produces the data structure @var{y}
% by choosing those elements from the data structure @var{x}
% for which the function @var{f} returns a nonzero value.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_filter (@@(x) mod (x, 2) == 0, [1, 2, 3, 4])}
% @result{} [2, 4]
% @end example
%
% Other types work in a similar fashion.
%
% @example
% @code{tmvs_filter (@@(x) mod (x, 2) == 0, @{1, 2, 3, 4@})}
% @result{} @{2, 4@}
% @code{tmvs_filter (@@(s) mod (s.one, 2) == 0, ...
%             struct ('one', @{1, 2, 3, 4@}, 'two', @{5, 6, 7, 8@}))}
% @result{} struct ('one', @{2, 4@}, 'two', @{6, 8@})
% @end example
%
% For the row vector @var{x} the following invocations produce the same result.
%
% @example
% @code{tmvs_filter (f, x)}
% @code{tmvs_foldl (@@(y, x) ifelse (f (x), [y, x], y), x, [])}.
% @end example
%
% @seealso{tmvs_foldl, tmvs_foldr, find, ismember}
%
% @end deftypefn

function y = tmvs_filter (f, x)

if ~(isempty (x) || isvector (x))
  type = 0;
elseif isnumeric (x) || isstruct (x)
  type = 1;
elseif iscell (x)
  type = 2;
else
  type = 0;
end

[n, k] = max (size (x));

y = x;
j = 0;

switch type
case 1
  for i = 1 : n
    if f (x(i))
      j = j + 1;
      y(j) = x(i);
    end
  end
case 2
  for i = 1 : n
    if f (x{i})
      j = j + 1;
      y{j} = x{i};
    end
  end
otherwise
  error ('wrong type ''%s''', class (x));
end

if j == 0
  i = zeros (1, ndims (x));
else
  i = ones (1, ndims (x));
  i(k) = j;
end
y = resize (y, i);

end

%!shared f
%! f = @(x) x ~= 0;


%!test
%! assert (tmvs_filter (f, []), []);

%!test
%! assert (tmvs_filter (f, [0]), []);
%!test
%! assert (tmvs_filter (f, [1]), [1]);

%!test
%! assert (tmvs_filter (f, [0, 0]), []);
%!test
%! assert (tmvs_filter (f, [0, 1]), [1]);
%!test
%! assert (tmvs_filter (f, [1, 0]), [1]);
%!test
%! assert (tmvs_filter (f, [1, 2]), [1, 2]);

%!test
%! assert (tmvs_filter (f, [0; 0]), []);
%!test
%! assert (tmvs_filter (f, [0; 1]), [1]);
%!test
%! assert (tmvs_filter (f, [1; 0]), [1]);
%!test
%! assert (tmvs_filter (f, [1; 2]), [1; 2]);


%!test
%! assert (tmvs_filter (f, {}), {});

%!test
%! assert (tmvs_filter (f, {0}), {});
%!test
%! assert (tmvs_filter (f, {1}), {1});

%!test
%! assert (tmvs_filter (f, {0, 0}), {});
%!test
%! assert (tmvs_filter (f, {0, 1}), {1});
%!test
%! assert (tmvs_filter (f, {1, 0}), {1});
%!test
%! assert (tmvs_filter (f, {1, 2}), {1, 2});

%!test
%! assert (tmvs_filter (f, {0; 0}), {});
%!test
%! assert (tmvs_filter (f, {0; 1}), {1});
%!test
%! assert (tmvs_filter (f, {1; 0}), {1});
%!test
%! assert (tmvs_filter (f, {1; 2}), {1; 2});
