% Enumeration constructor.
function y = tmvs_source (x)

if ischar (x)
  switch tolower (x)
  case {'tl', 'test lab'}
    y = 1;
  case {'sws', 'small weather station'}
    y = 2;
  case {'lws', 'large weather station'}
    y = 3;
  otherwise
    error (sprintf ('source ''%s'' not known', x));
  end

  y = int8 (y);
elseif isindex (x)
  switch x
  case 1
    y = 'test lab';
  case 2
    y = 'small weather station';
  case 3
    y = 'large weather station';
  otherwise
    error (sprintf ('source %d not known', x));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
