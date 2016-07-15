% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_source (@var{x})
%
% Enumerates the case-insensitive data sources @qcode{'Test Lab'},
% @qcode{'Weather Station'} and @qcode{'Weather Observatory'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_quantity, tmvs_site, tmvs_surface, tmvs_room, tmvs_section, tmvs_region}
%
% @end deftypefn

function y = tmvs_source (x)

if nargin == 0
  y = 'Data Source';
else
  if ischar (x)
    switch tolower (x)
    case {'tl', 'test lab'}
      y = 1;
    case {'ws', 'weather station'}
      y = 2;
    case {'wo', 'weather observatory'}
      y = 3;
    otherwise
      error ('source ''%s'' not known', x);
    end
  elseif isindex (x)
    switch x
    case 1
      y = 'Test Lab';
    case 2
      y = 'Weather Station';
    case 3
      y = 'Weather Observatory';
    otherwise
      error ('source %d not known', x);
    end
  else
    error ('wrong type ''%s''', class (x));
  end
end

end

%!shared f, n
%! f = @tmvs_quantity;
%! n = 3;

%!test
%! for i = 1 : n
%!   assert (f (i), f (f (f (i))));
%! end
