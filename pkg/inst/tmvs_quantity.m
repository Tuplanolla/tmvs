% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_quantity (@var{x})
% @deftypefnx {Function File} {@var{y} =} tmvs_quantity ()
%
% Enumerate physical quantities.
%
% This function enumerates the case-insensitive physical quantities
%
% @itemize
% @item @qcode{'Temperature'},
% @item @qcode{'Relative Humidity'},
% @item @qcode{'Absolute Humidity'},
% @item @qcode{'Pressure'},
% @item @qcode{'Wind Speed'} and
% @item @qcode{'Precipitation'}.
% @end itemize
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
% a constructor-destructor, a parser-printer or a serializer-deserializer pair
% for the parameters @var{x} and @var{y}.
% Additionally the name of the enumeration can be obtained by omitting @var{x}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_quantity ('Relative Humidity')}
% @result{} 2
% @code{tmvs_quantity (2)}
% @result{} 'Relative Humidity'
% @end example
%
% @example
% @code{tmvs_quantity ()}
% @result{} 'Physical Quantity'
% @end example
%
% Inputs can be abbreviated for convenience,
% but should not be used in programs.
%
% @example
% @code{tmvs_quantity ('RH')}
% @result{} 2
% @code{tmvs_quantity (tmvs_quantity ('RH'))}
% @result{} 'Relative Humidity'
% @end example
%
% @seealso{tmvs, tmvs_source, tmvs_site, tmvs_surface, tmvs_room, tmvs_section, tmvs_material, tmvs_region, tmvs_graph}
%
% @end deftypefn

function y = tmvs_quantity (x)

if nargin == 0
  y = 'Physical Quantity';
else
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
    otherwise
      error ('physical quantity ''%s'' not known', x);
    end
  elseif isindex (x)
    switch x
    case 1
      y = 'Temperature';
    case 2
      y = 'Relative Humidity';
    case 3
      y = 'Absolute Humidity';
    case 4
      y = 'Pressure';
    case 5
      y = 'Wind Speed';
    case 6
      y = 'Precipitation';
    otherwise
      error ('physical quantity %d not known', x);
    end
  else
    error ('wrong type ''%s''', class (x));
  end
end

end

%!shared f, n
%! f = @tmvs_quantity;
%! n = 6;

%!test
%! for i = 1 : n
%!   assert (f (i), f (f (f (i))));
%! end
