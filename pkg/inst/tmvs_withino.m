% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} tmvs_withino (@var{x}, @var{r})
% @deftypefnx {Function File} {@var{p} =} tmvs_withino (@var{x})
%
% Checks whether @var{x} is in the open interval @var{r}.
% If @var{r} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{tmvs_withino (x, [a, b])}
% is equivalent to @code{x > a & x < b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_withino (0, [-1, 1])}
% @result{} true
% @code{tmvs_withino (1, [-1, 1])}
% @result{} false
% @code{tmvs_withino ([-2, -1, 0, 1, 2], [-1, 1])}
% @result{} [false, false, true, false, false]
% @code{tmvs_withino (0)}
% @result{} false
% @end example
%
% @seealso{tmvs_withinc}
%
% @end deftypefn

function p = tmvs_withino (x, r = [0, 1])

p = x > r(1) & x < r(2);

end

%!test
%! assert (tmvs_withino (-2, [-1, 1]), false);
%!test
%! assert (tmvs_withino (-1, [-1, 1]), false);
%!test
%! assert (tmvs_withino (0, [-1, 1]), true);
%!test
%! assert (tmvs_withino (1, [-1, 1]), false);
%!test
%! assert (tmvs_withino (2, [-1, 1]), false);

%!test
%! assert (tmvs_withino ([-2, -1, 0, 1, 2], [-1, 1]), ...
%!         [false, false, true, false, false]);

%!test
%! assert (tmvs_withino (0), false);
