% -*- texinfo -*-
% @deftypefn {Function File} {@var{g} =} curry (@var{f})
%
% Convert a single multiparameter function into two nested functions.
%
% Currying, also known as sch@"onfinkeling or even fregeing,
% produces the function @var{g} from the function @var{f}
% in a way that satisfies @code{g (x) (y, z) == f (x, y, z)}.
% Hence @code{uncurry (curry (f)) == f} is always extensionally true.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{curry (@@(x, y) x + y) (1) (2)}
% @result{} 3
% @end example
%
% @example
% @code{curry (@@plus) (1) (2, 3)}
% @result{} 6
% @end example
%
% @seealso{uncurry}
%
% @end deftypefn

function g = curry (f)

g = @(x) @(varargin) f (x, varargin{:});

end

%!shared f
%! f = @(varargin) horzcat (varargin{:});

%!error
%! assert (curry (f) () (), f ());
%!error
%! assert (curry (f) () (1), f (1));
%!error
%! assert (curry (f) () (1, 2), f (1, 2));
%!error
%! assert (curry (f) () (1, 2, 3), f (1, 2, 3));
%!test
%! assert (curry (f) (1) (), f (1));
%!test
%! assert (curry (f) (1) (2), f (1, 2));
%!test
%! assert (curry (f) (1) (2, 3), f (1, 2, 3));
%!test
%! assert (curry (f) (1) (2, 3, 4), f (1, 2, 3, 4));
%!test
%! assert (curry (f) (1, 2) (), f (1));
%!test
%! assert (curry (f) (1, 2) (3), f (1, 3));
%!test
%! assert (curry (f) (1, 2) (3, 4), f (1, 3, 4));
%!test
%! assert (curry (f) (1, 2) (3, 4, 5), f (1, 3, 4, 5));
%!test
%! assert (curry (f) (1, 2, 3) (), f (1));
%!test
%! assert (curry (f) (1, 2, 3) (4), f (1, 4));
%!test
%! assert (curry (f) (1, 2, 3) (4, 5), f (1, 4, 5));
%!test
%! assert (curry (f) (1, 2, 3) (4, 5, 6), f (1, 4, 5, 6));
