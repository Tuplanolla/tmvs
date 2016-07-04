% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_site (@var{x})
%
% Enumerates the case-insensitive measuring sites
% from @qcode{'a'} to @qcode{'z'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_surface, tmvs_room, tmvs_section, tmvs_material, tmvs_region}
%
% @end deftypefn

function y = tmvs_site (x)

if ischar (x)
  c = tolower (x);
  if c < 'a' || c > 'z'
    error ('measuring site ''%s'' not known', x);
  else
    y = c - 'a' + 1;
  end
elseif isindex (x)
  if x < 1 || x > 26
    error ('measuring site %d not known', x);
  else
    n = x + 'a' - 1;
  end

  y = char (n);
else
  error ('wrong type ''%s''', class (x));
end

end

%!shared f, n
%! f = @tmvs_site;
%! n = 26;

%!test
%! for i = 1 : n
%!   assert (f (i), f (f (f (i))));
%! end
