% -*- texinfo -*-
% @deftypefn {Function File} {} axislim (@var{a}, @var{axis})
%
% Adjusts the @var{axis} axis for all @var{a}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{axislim ([1, 2, 3, 4], 'x')}
% @end example
%
% @seealso{axis, xlim, ylim, zlim}
%
% @end deftypefn

function axislim (a, axis)

v = a(:);

if ~isempty (v)
  a = min (v);
  b = max (v);

  if a < b
    switch axis
    case {'x', 1}
      xlim ([a, b]);
    case {'y', 2}
      xlim ([a, b]);
    case {'z', 3}
      xlim ([a, b]);
    otherwise
      error ('unknown axis');
    end
  end
end

end
