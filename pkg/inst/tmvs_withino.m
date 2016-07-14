% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} tmvs_withino (@var{x}, @var{a})
% @deftypefnx {Function File} {@var{p} =} tmvs_withino (@var{x})
%
% Checks whether @var{x} is in the open interval @var{a}.
% If @var{a} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{tmvs_withino (x, [a, b])}
% is equivalent to @code{x > a & x < b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_withino (1, [0, 2])}
% @result{} true
% @code{tmvs_withino (2, [0, 2])}
% @result{} false
% @code{tmvs_withino ([-1, 0, 1, 2, 3], [0, 2])}
% @result{} [false, false, true, false, false]
% @code{tmvs_withino (1)}
% @result{} false
% @end example
%
% @seealso{tmvs_withinc}
%
% @end deftypefn

function p = tmvs_withino (x, a = [0, 1])

p = x > a(1) & x < a(2);

end

%!test
%! assert (tmvs_withino (1, [0, 2]), true);
%!test
%! assert (tmvs_withino (2, [0, 2]), false);
%!test
%! assert (tmvs_withino ([-1, 0, 1, 2, 3], [0, 2]), ...
%!         [false, false, true, false, false]);
%!test
%! assert (tmvs_withino (1), false);
