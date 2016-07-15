% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_graph (@var{x})
%
% Enumerates the case-insensitive graphs @qcode{'??'} and
% @qcode{'??'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_quantity}
%
% @end deftypefn

function y = tmvs_graph (x)

if nargin == 0
  y = 'Graph';
else
  if ischar (x)
    switch tolower (x)
    case 'simple'
      y = 1;
    case 'slice'
      y = 2;
    case 'surface'
      y = 3;
    otherwise
      error ('graph ''%s'' not known', x);
    end
  elseif isindex (x)
    switch x
    case 1
      y = 'simple';
    case 2
      y = 'slice';
    case 3
      y = 'surface';
    otherwise
      error ('graph %d not known', x);
    end
  else
    error ('wrong type ''%s''', class (x));
  end
end

end

%!shared f, n
%! f = @tmvs_graph;
%! n = 2;

%!test
%! for i = 1 : n
%!   assert (f (i), f (f (f (i))));
%! end
