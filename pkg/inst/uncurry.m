% -*- texinfo -*-
% @deftypefn {Function File} {@var{g} =} uncurry (@var{f})
%
% Produces the function @var{g} from the function @var{f}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{uncurry (@@(x) @@(y) x + y) (1) (2)}
% @result{} 3
% @code{uncurry (@@(x) @@(varargin) x + plus (varargin@{:@})) (1, 2, 3)}
% @result{} 6
% @end example
%
% @seealso{curry}
%
% @end deftypefn

function g = uncurry (f)

g = @(x, varargin) f (x) (varargin{:});

end

%!shared f
%! f = @(x) @(varargin) horzcat (x, varargin{:});

%!error
%! assert (uncurry (f) (), f () ());
%!error
%! assert (uncurry (f) (1), f () (1));
%!error
%! assert (uncurry (f) (1, 2), f () (1, 2));
%!error
%! assert (uncurry (f) (1, 2, 3), f () (1, 2, 3));
%!test
%! assert (uncurry (f) (1), f (1) ());
%!test
%! assert (uncurry (f) (1, 2), f (1) (2));
%!test
%! assert (uncurry (f) (1, 2, 3), f (1) (2, 3));
%!test
%! assert (uncurry (f) (1, 2, 3, 4), f (1) (2, 3, 4));
%!test
%! assert (uncurry (f) (1), f (1, 2) ());
%!test
%! assert (uncurry (f) (1, 3), f (1, 2) (3));
%!test
%! assert (uncurry (f) (1, 3, 4), f (1, 2) (3, 4));
%!test
%! assert (uncurry (f) (1, 3, 4, 5), f (1, 2) (3, 4, 5));
%!test
%! assert (uncurry (f) (1), f (1, 2, 3) ());
%!test
%! assert (uncurry (f) (1, 4), f (1, 2, 3) (4));
%!test
%! assert (uncurry (f) (1, 4, 5), f (1, 2, 3) (4, 5));
%!test
%! assert (uncurry (f) (1, 4, 5, 6), f (1, 2, 3) (4, 5, 6));
