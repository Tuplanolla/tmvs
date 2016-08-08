% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} withinr (@var{x}, @var{r})
% @deftypefnx {Function File} {@var{p} =} withinr (@var{x})
%
% Check whether a value is in a right-open interval.
%
% Checks whether @var{x} is in the right-open interval @var{r}.
% If @var{r} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{withinr (x, [a, b])}
% is equivalent to @code{x >= a & x < b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{withinr (0, [-1, 1])}
% @result{} true
% @end example
%
% @example
% @code{withinr (1, [-1, 1])}
% @result{} true
% @end example
%
% @example
% @code{withinr ([-2, -1, 0, 1, 2], [-1, 1])}
% @result{} [false, true, true, false, false]
% @end example
%
% @example
% @code{withinr (0)}
% @result{} true
% @end example
%
% @seealso{withinl, withino, withinc}
%
% @end deftypefn

function p = withinr (x, r = [0, 1])

p = x >= r(1) & x < r(2);

end

%!test
%! assert (withinr (-2, [-1, 1]), false);
%!test
%! assert (withinr (-1, [-1, 1]), true);
%!test
%! assert (withinr (0, [-1, 1]), true);
%!test
%! assert (withinr (1, [-1, 1]), false);
%!test
%! assert (withinr (2, [-1, 1]), false);

%!test
%! assert ( ...
%!   withinr ([-2, -1, 0, 1, 2], [-1, 1]), ...
%!   [false, true, true, false, false]);

%!test
%! assert (withinr (0), true);
