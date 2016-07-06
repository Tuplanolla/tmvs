% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_section (@var{x})
%
% Enumerates the case-insensitive sections @qcode{'bottom corner'} and
% @qcode{'top corner'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_site, tmvs_surface, tmvs_room, tmvs_region}
%
% @end deftypefn

function y = tmvs_section (x)

if ischar (x)
  switch tolower (x)
  case {'bc', 'bottom corner'}
    y = 1;
  case {'tc', 'top corner'}
    y = 2;
  otherwise
    error ('section ''%s'' not known', x);
  end
elseif isindex (x)
  switch x
  case 1
    y = 'bottom corner';
  case 2
    y = 'top corner';
  otherwise
    error ('section %d not known', x);
  end
else
  error ('wrong type ''%s''', class (x));
end

end

%!shared f, n
%! f = @tmvs_section;
%! n = 2;

%!test
%! for i = 1 : n
%!   assert (f (i), f (f (f (i))));
%! end
