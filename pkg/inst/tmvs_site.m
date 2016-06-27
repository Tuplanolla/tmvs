% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_site (@var{x})
%
% Enumerates the case-insensitive measuring sites
% from @qcode{'A'} to @qcode{'Z'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_room, tmvs_placement, tmvs_material, tmvs_region}
%
% @end deftypefn

function y = tmvs_site (x)

if ischar (x)
  c = tolower (x);
  if c < 'a' || c > 'z'
    error (sprintf ('site ''%s'' not known', x));
  else
    y = c - 'a' + 1;
  end

  y = int8 (y);
elseif isindex (x)
  if c < 1 || c > 26
    error (sprintf ('site %d not known', x));
  else
    y = c + 'a' - 1;
  end

  y = char (y);
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
