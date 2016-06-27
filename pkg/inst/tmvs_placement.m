% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_placement (@var{x})
%
% Enumerates the case-insensitive placements @qcode{'wall bottom corner'},
% @qcode{'wall top corner'}, @qcode{'level floor'} and @qcode{'level ceiling'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_site, tmvs_room, tmvs_material, tmvs_region}
%
% @end deftypefn

function y = tmvs_placement (x)

if ischar (x)
  switch tolower (x)
  case {'wbc', 'wall bottom corner'}
    y = 1;
  case {'wtc', 'wall top corner'}
    y = 2;
  case {'lf', 'level floor'}
    y = 3;
  case {'lc', 'level ceiling'}
    y = 4;
  otherwise
    error (sprintf ('placement ''%s'' not known', x));
  end

  y = int8 (y);
elseif isindex (x)
  switch x
  case 1
    y = 'wall bottom corner';
  case 2
    y = 'wall top corner';
  case 3
    y = 'level floor';
  case 4
    y = 'level ceiling';
  otherwise
    error (sprintf ('placement %d not known', x));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
