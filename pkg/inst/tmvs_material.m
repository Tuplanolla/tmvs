% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_material (@var{x})
%
% Enumerates the case-insensitive materials @qcode{'Mineral Wool'},
% @qcode{'Polyurethane'}, @qcode{'Polystyrene'} and
% @qcode{'Reinforced Concrete'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_quantity}
%
% @end deftypefn

function y = tmvs_material (x)

if nargin == 0
  y = 'Material';
else
  if ischar (x)
    switch tolower (x)
    case {'mw', 'mineral wool'}
      y = 1;
    case {'pur', 'polyurethane'}
      y = 2;
    case {'eps', 'polystyrene'}
      y = 3;
    case {'rc', 'reinforced concrete'}
      y = 4;
    otherwise
      error ('material ''%s'' not known', x);
    end
  elseif isindex (x)
    switch x
    case 1
      y = 'Mineral Wool';
    case 2
      y = 'Polyurethane';
    case 3
      y = 'Polystyrene';
    case 4
      y = 'Reinforced Concrete';
    otherwise
      error ('placement %d not known', x);
    end
  else
    error ('wrong type ''%s''', class (x));
  end
end

end

%!shared f, n
%! f = @tmvs_material;
%! n = 4;

%!test
%! for i = 1 : n
%!   assert (f (i), f (f (f (i))));
%! end
