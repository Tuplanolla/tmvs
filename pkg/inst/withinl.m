% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} withinl (@var{x}, @var{r})
% @deftypefnx {Function File} {@var{p} =} withinl (@var{x})
%
% Checks whether @var{x} is in the left-open interval @var{r}.
% If @var{r} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{withinl (x, [a, b])}
% is equivalent to @code{x > a & x <= b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{withinl (0, [-1, 1])}
% @result{} true
% @code{withinl (1, [-1, 1])}
% @result{} true
% @code{withinl ([-2, -1, 0, 1, 2], [-1, 1])}
% @result{} [false, false, true, true, false]
% @code{withinl (0)}
% @result{} true
% @end example
%
% @seealso{withinr, withino, withinc}
%
% @end deftypefn

function p = withinl (x, r = [0, 1])

p = x > r(1) & x <= r(2);

end

%!test
%! assert (withinl (-2, [-1, 1]), false);
%!test
%! assert (withinl (-1, [-1, 1]), false);
%!test
%! assert (withinl (0, [-1, 1]), true);
%!test
%! assert (withinl (1, [-1, 1]), true);
%!test
%! assert (withinl (2, [-1, 1]), false);

%!test
%! assert (withinl ([-2, -1, 0, 1, 2], [-1, 1]), ...
%!         [false, false, true, true, false]);

%!test
%! assert (withinl (0), false);
