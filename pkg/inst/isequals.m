% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} isequals (@var{x}, @var{y})
%
% Sets @var{p} to a nonzero value
% if the structures @var{x} and @var{y} satisfy shallow equality, that is,
% if they have the same fields with equal values.
% Equality is checked with the @code{==} operator and
% thus does not work for strings of different lengths,
% cell arrays, structure arrays or @code{nan} values.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{isequals (struct ('one', 1, 'two', 2), ...
%                struct ('one', 1, 'two', 2))}
% @result{} true
% @code{isequals (struct ('one', 1, 'two', 2), ...
%                struct ('one', 1, 'two', 3))}
% @result{} false
% @code{isequals (struct ('one', 1, 'two', 2), ...
%                struct ('one', 1, 'three', 3))}
% @result{} false
% @code{isequals (struct ('one', 1, 'two', 2), ...
%                struct ('one', 1))}
% @result{} false
% @end example
%
% Programming note: When comparing structures of primitive values,
% this is significantly faster than @code{isequal} or @code{isequaln}.
%
% @seealso{isequal, isequaln}
%
% @end deftypefn

function p = isequals (x, y)

c = fieldnames (x);
n = numel (c);

if n == numel (fieldnames (y))
  p = true;

  for i = 1 : n
    str = c{i};

    if ~isfield (y, str) || y.(str) ~= x.(str)
      p = false;

      break
    end
  end
else
  p = false;
end

end

%!test
% assert (isequals (struct (), struct ()), true);
%!test
% assert (isequals (struct ('1', 1), struct ('1', 1)), true);
%!test
% assert (isequals (struct ('1', 1, '2', 2), ...
%                        struct ('1', 1, '2', 2)), true);
%!test
% assert (isequals (struct ('1', 1, '2', 2, '3', 3), ...
%                        struct ('1', 1, '2', 2, '3', 3)), true);

%!test
% assert (isequals (struct (), struct ('1', 1)), false);
%!test
% assert (isequals (struct ('1', 1), struct ()), false);
%!test
% assert (isequals (struct ('1', 1), struct ('1', 2)), false);
%!test
% assert (isequals (struct ('1', 1), struct ('2', 1)), false);
%!test
% assert (isequals (struct ('1', 1), struct ('2', 2)), false);
