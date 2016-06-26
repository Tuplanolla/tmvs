% Enumeration constructor.
function y = tmvs_material (x)

if ischar (x)
  switch tolower (x)
  case {'mw', 'mineral wool'}
    y = 1;
  case {'pur', 'polyurethane'}
    y = 2;
  case {'eps', 'polystyrene'}
    y = 3;
  otherwise
    error (sprintf ('material ''%s'' not known', x));
  end

  y = int8 (y);
elseif isindex (x)
  switch x
  case 1
    y = 'mineral wool';
  case 2
    y = 'polyurethane';
  case 3
    y = 'polystyrene';
  otherwise
    error (sprintf ('placement %d not known', x));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
