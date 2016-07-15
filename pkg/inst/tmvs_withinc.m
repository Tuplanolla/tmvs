% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} tmvs_withinc (@var{x}, @var{r})
% @deftypefnx {Function File} {@var{p} =} tmvs_withinc (@var{x})
%
% Checks whether @var{x} is in the closed interval @var{r}.
% If @var{r} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{tmvs_withinc (x, [a, b])}
% is equivalent to @code{x >= a & x <= b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_withinc (0, [-1, 1])}
% @result{} true
% @code{tmvs_withinc (1, [-1, 1])}
% @result{} true
% @code{tmvs_withinc ([-2, -1, 0, 1, 2], [-1, 1])}
% @result{} [false, true, true, true, false]
% @code{tmvs_withinc (0)}
% @result{} true
% @end example
%
% @seealso{tmvs_withino}
%
% @end deftypefn

function p = tmvs_withinc (x, r = [0, 1])

p = x >= r(1) & x <= r(2);

end

%!test
%! assert (tmvs_withinc (-2, [-1, 1]), false);
%!test
%! assert (tmvs_withinc (-1, [-1, 1]), true);
%!test
%! assert (tmvs_withinc (0, [-1, 1]), true);
%!test
%! assert (tmvs_withinc (1, [-1, 1]), true);
%!test
%! assert (tmvs_withinc (2, [-1, 1]), false);

%!test
%! assert (tmvs_withinc ([-2, -1, 0, 1, 2], [-1, 1]), ...
%!         [false, true, true, true, false]);

%!test
%! assert (tmvs_withinc (0), true);
