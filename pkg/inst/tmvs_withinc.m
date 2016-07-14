% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} tmvs_withinc (@var{x}, @var{z})
%
% Checks whether @var{x} is in the closed interval @var{z}.
% If @var{z} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{tmvs_withinc (x, [a, b])}
% is equivalent to @code{x >= a && x <= b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_withinc (1, [0, 2])}
% @result{} true
% @code{tmvs_withinc (3, [0, 2])}
% @result{} false
% @code{tmvs_withinc (2, [0, 2])}
% @result{} true
% @code{tmvs_withinc (1)}
% @result{} true
% @end example
%
% @seealso{tmvs_withino}
%
% @end deftypefn

function p = tmvs_withinc (x, z = [0, 1])

p = x >= z(1) && x <= z(2);

end

%!test
%! assert (tmvs_withinc (1, [0, 2]), true);
%!test
%! assert (tmvs_withinc (3, [0, 2]), false);
%!test
%! assert (tmvs_withinc (2, [0, 2]), true);
%!test
%! assert (tmvs_withinc (1), true);
