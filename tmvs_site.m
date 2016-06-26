% Enumeration constructor.
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
