% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_room (@var{x})
%
% Enumerates the case-insensitive room names from @code{118} to @code{146}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_site, tmvs_surface, tmvs_section, tmvs_material, tmvs_region}
%
% @end deftypefn

function y = tmvs_room (x)

if ischar (x)
  n = str2double (x);
  if ~isindex (n)
    error (sprintf ('room ''%s'' not known', x));
  else
    y = n;
  end
elseif isindex (x)
  y = sprintf ('%d', x);
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
