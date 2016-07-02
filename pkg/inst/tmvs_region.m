% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_region (@var{x})
%
% Enumerates the case-insensitive regions @qcode{'autiolahti'} and
% @qcode{'jyvaskyla'}.
%
% Special characters are accepted in inputs,
% but in outputs they are represented by their ASCII approximations
% to avoid potential compatibility problems.
% Unfortunately UTF-8 does not permeate the fabric of the universe yet.
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
  case {'jyvaskyla', 'jyväskylä', 'jyv?skyl?'}
    y = 2;
  otherwise
    error (sprintf ('region ''%s'' not known', x));
  end
elseif isindex (x)
  switch x
  case 1
    y = 'autiolahti';
  case 2
    y = 'jyvaskyla';
  otherwise
    error (sprintf ('region %d not known', x));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
