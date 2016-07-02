% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_quantity (@var{x})
%
% Enumerates the case-insensitive physical quantities @qcode{'temperature'},
% @qcode{'relative humidity'}, @qcode{'absolute humidity'},
% @qcode{'pressure'}, @qcode{'wind speed'}, @qcode{'precipitation'} and
% @qcode{'solar energy'}.
%
% Enumerations or tagged unions of unit types are a common and
% useful technique for giving names to a fixed set of values.
% While defining them directly is not possible,
% they can be simulated with a generalized isomorphism.
% Such a thing consists of two functions @var{f} and @var{g}
% that satisfy @code{f (x) == f (g (f (x)))} and @code{g (y) == g (f (g (y)))},
% where @var{x} is any value from the set of interest and
% @var{y} is any value from the enumeration.
% (the generality comes from the fact that @code{x == g (f (x))} or
% @code{y == f (g (y))} are not guaranteed to hold).
%
% Since the underlying type system is dynamic and
% there is no need to enumerate integers (they enumerate themselves),
% the same function @var{h} can serve as both @var{f} and @var{g}.
% This is possible by choosing the appropriate action
% based on the type of the input argument.
% Then @code{h (x) == h (h (h (x)))},
% where @var{x} is any value from the set of interest or its enumeration.
%
% The whole ordeal is quite simple even if the description sounds complicated.
% The idea is that a single function can be used as
% a constructor-destructor, a parser-printer or a serializer-deserializer pair.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_quantity ('relative humidity')}
% @result{} 2
% @code{tmvs_quantity (2)}
% @result{} 'relative humidity'
% @end example
%
% Inputs can be abbreviated for convenience,
% but should not be used in programs.
%
% @example
% @code{tmvs_quantity ('rh')}
% @result{} 2
% @code{tmvs_quantity (tmvs_quantity ('rh'))}
% @result{} 'relative humidity'
% @end example
%
% @seealso{tmvs, tmvs_source, tmvs_site, tmvs_surface, tmvs_room, tmvs_section, tmvs_material, tmvs_region}
%
% @end deftypefn

function y = tmvs_quantity (x)

if ischar (x)
  switch tolower (x)
  case {'t', 'temperature'}
    y = 1;
  case {'rh', 'relative humidity'}
    y = 2;
  case {'ah', 'absolute humidity'}
    y = 3;
  case {'p', 'pressure'}
    y = 4;
  case {'v', 'wind speed'}
    y = 5;
  case {'h', 'precipitation'}
    y = 6;
  case {'i', 'solar energy'}
    y = 7;
  otherwise
    error (sprintf ('physical quantity ''%s'' not known', x));
  end
elseif isindex (x)
  switch x
  case 1
    y = 'temperature';
  case 2
    y = 'relative humidity';
  case 3
    y = 'absolute humidity';
  case 4
    y = 'pressure';
  case 5
    y = 'wind speed';
  case 6
    y = 'precipitation';
  case 7
    y = 'solar energy';
  otherwise
    error (sprintf ('physical quantity %d not known', x));
  end
else
  error (sprintf ('wrong type ''%s''', class (x)));
end

end
