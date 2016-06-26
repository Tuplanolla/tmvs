% Enumeration constructor.
function y = tmvs_region (x)

if ischar (x)
  switch tolower (x)
  case 'autiolahti'
    y = 1;
  case {'jyvaskyla', 'jyväskylä'}
    y = 2;
  otherwise
    error (sprintf ('region ''%s'' not known', x));
  end

  y = int8 (y);
elseif isindex (x)
  switch x
  case 1
    y = 'Autiolahti';
  case 2
    % Use ASCII characters only to avoid potential compatibility problems.
    y = 'Jyvaskyla';
  otherwise
    error (sprintf ('region %d not known', x));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
