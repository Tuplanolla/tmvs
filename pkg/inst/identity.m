% -*- texinfo -*-
% @deftypefn {Function File} {@var{x} =} identity (@var{x})
%
% Does not do anything to @var{x}.
% While not doing anything seems pointless,
% this is occasionally useful when working with higher-order functions.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{identity (2)}
% @result{} 2
% @code{identity (identity (2))}
% @result{} 2
% @end example
%
% Programming note: This is slightly slower than doing nothing at all.
%
% @seealso{composel, composer}
%
% @end deftypefn

function x = identity (x)

end

%!test
%! assert (identity (false), false);
%!test
%! assert (identity (true), true);
