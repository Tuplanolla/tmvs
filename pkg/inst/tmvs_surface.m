% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_surface (@var{x})
%
% Enumerates the case-insensitive surfaces @qcode{'wall'},
% @qcode{'floor'} and @qcode{'ceiling'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_site, tmvs_room, tmvs_section, tmvs_material, tmvs_region}
%
% @end deftypefn

function y = tmvs_surface (x)

if ischar (x)
  switch tolower (x)
  case {'w', 'wall'}
    y = 1;
  case {'f', 'floor'}
    y = 2;
  case {'c', 'ceiling'}
    y = 3;
  otherwise
    error ('surface ''%s'' not known', x);
  end
elseif isindex (x)
  switch x
  case 1
    y = 'wall';
  case 2
    y = 'floor';
  case 3
    y = 'ceiling';
  otherwise
    error ('surface %d not known', x);
  end
else
  error ('wrong type ''%s''', class (x));
end

end
