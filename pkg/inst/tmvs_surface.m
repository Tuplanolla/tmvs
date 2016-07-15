% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_surface (@var{x})
%
% Enumerates the case-insensitive surfaces @qcode{'Wall'},
% @qcode{'Floor'} and @qcode{'Ceiling'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_site, tmvs_room, tmvs_section, tmvs_region}
%
% @end deftypefn

function y = tmvs_surface (x)

if nargin == 0
  y = 'Surface';
else
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
      y = 'Wall';
    case 2
      y = 'Floor';
    case 3
      y = 'Ceiling';
    otherwise
      error ('surface %d not known', x);
    end
  else
    error ('wrong type ''%s''', class (x));
  end
end

end

%!shared f, n
%! f = @tmvs_surface;
%! n = 3;

%!test
%! for i = 1 : n
%!   assert (f (i), f (f (f (i))));
%! end
