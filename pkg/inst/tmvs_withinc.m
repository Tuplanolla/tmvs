% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} tmvs_withinc (@var{x}, @var{a})
% @deftypefnx {Function File} {@var{p} =} tmvs_withinc (@var{x})
%
% Checks whether @var{x} is in the closed interval @var{a}.
% If @var{a} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{tmvs_withinc (x, [a, b])}
% is equivalent to @code{x >= a & x <= b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_withinc (1, [0, 2])}
% @result{} true
% @code{tmvs_withinc (2, [0, 2])}
% @result{} true
% @code{tmvs_withinc ([-1, 0, 1, 2, 3], [0, 2])}
% @result{} [false, true, true, true, false]
% @code{tmvs_withinc (1)}
% @result{} true
% @end example
%
% @seealso{tmvs_withino}
%
% @end deftypefn

function p = tmvs_withinc (x, a = [0, 1])

p = x >= a(1) & x <= a(2);

end

%!test
%! assert (tmvs_withinc (1, [0, 2]), true);
%!test
%! assert (tmvs_withinc (2, [0, 2]), true);
%!test
%! assert (tmvs_withinc ([-1, 0, 1, 2, 3], [0, 2]), ...
%!         [false, true, true, true, false]);
%!test
%! assert (tmvs_withinc (1), true);
