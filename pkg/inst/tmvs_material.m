% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_material (@var{x})
%
% Enumerates the case-insensitive materials @qcode{'mineral wool'},
% @qcode{'polyurethane'} and @qcode{'polystyrene'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_site, tmvs_surface, tmvs_room, tmvs_section, tmvs_region}
%
% @end deftypefn

function y = tmvs_material (x)

if ischar (x)
  switch tolower (x)
  case {'mw', 'mineral wool'}
    y = 1;
  case {'pur', 'polyurethane'}
    y = 2;
  case {'eps', 'polystyrene'}
    y = 3;
  otherwise
    error (sprintf ('material ''%s'' not known', x));
  end

  y = int8 (y);
elseif isindex (x)
  switch x
  case 1
    y = 'mineral wool';
  case 2
    y = 'polyurethane';
  case 3
    y = 'polystyrene';
  otherwise
    error (sprintf ('placement %d not known', x));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
