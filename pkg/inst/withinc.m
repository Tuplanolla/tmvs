% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} withinc (@var{x}, @var{r})
% @deftypefnx {Function File} {@var{p} =} withinc (@var{x})
%
% Checks whether @var{x} is in the closed interval @var{r}.
% If @var{r} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{withinc (x, [a, b])}
% is equivalent to @code{x >= a & x <= b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{withinc (0, [-1, 1])}
% @result{} true
% @code{withinc (1, [-1, 1])}
% @result{} true
% @code{withinc ([-2, -1, 0, 1, 2], [-1, 1])}
% @result{} [false, true, true, true, false]
% @code{withinc (0)}
% @result{} true
% @end example
%
% @seealso{withino, withinl, withinr}
%
% @end deftypefn

function p = withinc (x, r = [0, 1])

p = x >= r(1) & x <= r(2);

end

%!test
%! assert (withinc (-2, [-1, 1]), false);
%!test
%! assert (withinc (-1, [-1, 1]), true);
%!test
%! assert (withinc (0, [-1, 1]), true);
%!test
%! assert (withinc (1, [-1, 1]), true);
%!test
%! assert (withinc (2, [-1, 1]), false);

%!test
%! assert (withinc ([-2, -1, 0, 1, 2], [-1, 1]), ...
%!         [false, true, true, true, false]);

%!test
%! assert (withinc (0), true);
