% -*- texinfo -*-
% @deftypefn {Function File} {@var{p} =} tmvs_withino (@var{x}, @var{z})
%
% Checks whether @var{x} is in the open interval @var{z}.
% If @var{z} is omitted, the unit interval @code{[0, 1]} is assumed.
% The invocation @code{tmvs_withino (x, [a, b])}
% is equivalent to @code{x > a && x < b}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_withino (1, [0, 2])}
% @result{} true
% @code{tmvs_withino (3, [0, 2])}
% @result{} false
% @code{tmvs_withino (2, [0, 2])}
% @result{} true
% @end example
%
% @seealso{tmvs_withinc}
%
% @end deftypefn

function p = tmvs_withino (x, z = [0, 1])

p = x > z(0) && x < z(1);

end
