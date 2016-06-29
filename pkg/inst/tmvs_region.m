% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_x (@var{x})
%
% Enumerates the case-insensitive regions @qcode{'autiolahti'} and
% @qcode{'jyvaskyla'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_site, tmvs_surface, tmvs_room, tmvs_section, tmvs_material}
%
% @end deftypefn

function y = tmvs_region (x)

if ischar (x)
  switch tolower (x)
  case 'autiolahti'
    y = 1;
  case {'jyvaskyla', 'jyväskylä'}
    y = 2;
  otherwise
    error (sprintf ('region ''%s'' not known', x));
  end

  y = int8 (y);
elseif isindex (x)
  switch x
  case 1
    y = 'autiolahti';
  case 2
    % Special characters are represented by their ASCII approximations
    % to avoid potential compatibility problems.
    % Unfortunately UTF-8 does not yet permeate the universe.
    y = 'jyvaskyla';
  otherwise
    error (sprintf ('region %d not known', x));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
