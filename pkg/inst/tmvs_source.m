% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_source (@var{x})
%
% Enumerates the case-insensitive data sources @qcode{'test lab'},
% @qcode{'weather station'} and @qcode{'large weather station'}.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_quantity, tmvs_site, tmvs_surface, tmvs_room, tmvs_section, tmvs_material, tmvs_region}
%
% @end deftypefn

function y = tmvs_source (x)

if ischar (x)
  switch tolower (x)
  case {'tl', 'test lab'}
    y = 1;
  case {'ws', 'weather station'}
    y = 2;
  case {'lws', 'large weather station'}
    y = 3;
  otherwise
    error (sprintf ('source ''%s'' not known', x));
  end
elseif isindex (x)
  switch x
  case 1
    y = 'test lab';
  case 2
    y = 'weather station';
  case 3
    y = 'large weather station';
  otherwise
    error (sprintf ('source %d not known', x));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
