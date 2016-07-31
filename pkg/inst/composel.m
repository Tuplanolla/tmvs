% -*- texinfo -*-
% @deftypefn {Function File} {@var{f} =} composel (@var{varargin})
%
% Produces the function @var{f} by composing the functions in @var{varargin}
% from left to right (from the first argument to the last argument).
% Therefore @code{composel (f, g) (x) == g (f (x))} and
% @code{composel () (x) == x}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{composel (@@isscalar, @@not) (1)}
% @result{} false
% @code{composel (@@isscalar, @@not) ([1, 2])}
% @result{} true
% @end example
%
% @seealso{composer}
%
% @end deftypefn

function f = composel (varargin)

n = numel (varargin);

if n == 0
  f = @identity;
else
  f = varargin{1};

  for i = 2 : n
    f = @(x) varargin{i} (f (x));
  end
end

end

%!shared f, g
%! f = @(x) 2 * x;
%! g = @(x) 2 ^ x;

%!test
%! assert (composel () (2), 2);

%!test
%! assert (composel (f) (2), f (2));
%!test
%! assert (composel (g) (2), g (2));

%!test
%! assert (composel (f, f) (2), f (f (2)));
%!test
%! assert (composel (f, g) (2), g (f (2)));
%!test
%! assert (composel (g, f) (2), f (g (2)));
%!test
%! assert (composel (g, g) (2), g (g (2)));
