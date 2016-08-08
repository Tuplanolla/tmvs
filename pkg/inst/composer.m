% -*- texinfo -*-
% @deftypefn {Function File} {@var{f} =} composer (@var{varargin})
%
% Compose several functions from right to left.
%
% This function produces the function @var{f}
% by composing the functions in @var{varargin}
% from right to left (from the last argument to the first argument).
% Therefore @code{composer (f, g) (x) == f (g (x))} and
% @code{composer () (x) == x}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{composer (@@not, @@isscalar) (1)}
% @result{} false
% @end example
%
% @example
% @code{composer (@@not, @@isscalar) ([1, 2])}
% @result{} true
% @end example
%
% @seealso{composel}
%
% @end deftypefn

function f = composer (varargin)

n = numel (varargin);

if n == 0
  f = @identity;
else
  f = varargin{1};

  for i = 2 : n
    f = @(x) f (varargin{i} (x));
  end
end

end

%!shared f, g
%! f = @(x) 2 * x;
%! g = @(x) 2 ^ x;

%!test
%! assert (composer () (2), 2);

%!test
%! assert (composer (f) (2), f (2));
%!test
%! assert (composer (g) (2), g (2));

%!test
%! assert (composer (f, f) (2), f (f (2)));
%!test
%! assert (composer (f, g) (2), f (g (2)));
%!test
%! assert (composer (g, f) (2), g (f (2)));
%!test
%! assert (composer (g, g) (2), g (g (2)));
