% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_room (@var{x})
%
% Enumerates the case-insensitive room names from @code{118} to @code{146}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_site, tmvs_surface, tmvs_section, tmvs_region}
%
% @end deftypefn

function y = tmvs_room (x)

if ischar (x)
  n = str2double (x);
  if ~isindex (n)
    error ('room ''%s'' not known', x);
  else
    y = n;
  end
elseif isindex (x)
  y = sprintf ('%d', x);
else
  error ('wrong type ''%s''', class (x));
end

end

%!shared f, n
%! f = @tmvs_room;
%! n = 999;

%!test
%! for i = 1 : n
%!   assert (f (i), f (f (f (i))));
%! end
