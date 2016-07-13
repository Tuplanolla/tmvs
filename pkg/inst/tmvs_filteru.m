% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_filteru (@var{f}, @var{x})
%
% Filter, also known as select, find or copy-if,
% produces the data structure @var{y}
% by choosing those elements from the data structure @var{x}
% for which the function @var{f} returns a nonzero value.
% The unstable filter in particular may reorder the elements of @var{x}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_filteru (@@(x) mod (x, 2) == 0, [1, 2, 3, 4, 5, 6])}
% @result{} [2, 6, 4]
% @end example
%
% Other types work in a similar fashion.
%
% @example
% @code{tmvs_filteru (@@(x) mod (x, 2) == 0, @{1, 2, 3, 4, 5, 6@})}
% @result{} @{2, 6, 4@}
% @code{tmvs_filteru (@@(s) mod (s.one, 2) == 0, ...
%               struct ('one', @{1, 2, 3, 4, 5, 6@}, ...
%                       'two', @{7, 8, 9, 10, 11, 12@}))}
% @result{} struct ('one', @{2, 6, 4@}, 'two', @{8, 12, 10@})
% @end example
%
% Programming note: This is slightly slower than @code{tmvs_filters},
% but uses less memory if only a few elements are chosen.
%
% @seealso{tmvs_filteru, tmvs_foldl, tmvs_foldr, find, ismember}
%
% @end deftypefn

function y = tmvs_filteru (f, x)

if ~(isempty (x) || isvector (x))
  type = 0;
elseif isnumeric (x)
  type = 1;
elseif iscell (x)
  type = 2;
elseif isstruct (x)
  type = 3;
else
  type = 0;
end

[n, k] = max (size (x));

switch type
case 1
  y = nan (0);
case 2
  y = cell (0);
case 3
  c = fieldnames (x);
  y = resize (cell2struct (cell (size (c)), c), 0);
end

p = false;

switch type
case {1, 3}
  for i = 1 : n
    if f (x(i))
      y(end + 1) = x(i);

      if p
        i = ones (1, ndims (x));
        i(k) = 2;
        y = reshape (y, i);

        for i = 3 : n
          if f (x(i))
            y(end + 1) = x(i);
          end
        end

        break
      end

      p = true;
    end
  end
case 2
  for i = 1 : n
    if f (x{i})
      y{end + 1} = x{i};

      if p
        i = ones (1, ndims (x));
        i(k) = 2;
        y = reshape (y, i);

        for i = 3 : n
          if f (x{i})
            y{end + 1} = x{i};
          end
        end

        break
      end

      p = true;
    end
  end
otherwise
  error ('wrong type ''%s''', class (x));
end

if isempty (y)
  y = resize (y, 0);
end

end

%!shared f
%! f = @(x) x ~= 0;


%!test
%! assert (tmvs_filteru (f, []), []);

%!test
%! assert (tmvs_filteru (f, [0]), []);
%!test
%! assert (tmvs_filteru (f, [1]), [1]);

%!test
%! assert (tmvs_filteru (f, [0, 0]), []);
%!test
%! assert (tmvs_filteru (f, [0, 1]), [1]);
%!test
%! assert (tmvs_filteru (f, [1, 0]), [1]);
%!test
%! assert (tmvs_filteru (f, [1, 1]), [1, 1]);

%!test
%! assert (tmvs_filteru (f, [0; 0]), []);
%!test
%! assert (tmvs_filteru (f, [0; 1]), [1]);
%!test
%! assert (tmvs_filteru (f, [1; 0]), [1]);
%!test
%! assert (tmvs_filteru (f, [1; 1]), [1; 1]);


%!test
%! assert (tmvs_filteru (f, {}), {});

%!test
%! assert (tmvs_filteru (f, {0}), {});
%!test
%! assert (tmvs_filteru (f, {1}), {1});

%!test
%! assert (tmvs_filteru (f, {0, 0}), {});
%!test
%! assert (tmvs_filteru (f, {0, 1}), {1});
%!test
%! assert (tmvs_filteru (f, {1, 0}), {1});
%!test
%! assert (tmvs_filteru (f, {1, 1}), {1, 1});

%!test
%! assert (tmvs_filteru (f, {0; 0}), {});
%!test
%! assert (tmvs_filteru (f, {0; 1}), {1});
%!test
%! assert (tmvs_filteru (f, {1; 0}), {1});
%!test
%! assert (tmvs_filteru (f, {1; 1}), {1; 1});
