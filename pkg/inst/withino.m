% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} withino (@var{x}, @var{r})
% @deftypefnx {Function File} {@var{p} =} withino (@var{x})
%
% Checks whether @var{x} is in the open interval @var{r}.
% If @var{r} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{withino (x, [a, b])}
% is equivalent to @code{x > a & x < b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{withino (0, [-1, 1])}
% @result{} true
% @code{withino (1, [-1, 1])}
% @result{} false
% @code{withino ([-2, -1, 0, 1, 2], [-1, 1])}
% @result{} [false, false, true, false, false]
% @code{withino (0)}
% @result{} false
% @end example
%
% @seealso{withinc, withinl, withinr}
%
% @end deftypefn

function p = withino (x, r = [0, 1])

p = x > r(1) & x < r(2);

end

%!test
%! assert (withino (-2, [-1, 1]), false);
%!test
%! assert (withino (-1, [-1, 1]), false);
%!test
%! assert (withino (0, [-1, 1]), true);
%!test
%! assert (withino (1, [-1, 1]), false);
%!test
%! assert (withino (2, [-1, 1]), false);

%!test
%! assert (withino ([-2, -1, 0, 1, 2], [-1, 1]), ...
%!         [false, false, true, false, false]);

%!test
%! assert (withino (0), false);
