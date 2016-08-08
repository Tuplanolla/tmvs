% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_region (@var{x})
%
% Enumerate regions.
%
% This function enumerates the case-insensitive regions
%
% @itemize
% @item @qcode{'Autiolahti'} and
% @item @qcode{'Jyvaskyla'}.
% @end itemize
%
% Special characters are accepted in inputs,
% but in outputs they are represented by their ASCII approximations
% to avoid potential compatibility problems.
% Unfortunately UTF-8 does not permeate the fabric of the universe yet.
%
% See @code{tmvs_quantity} for a detailed treatise on functions of this kind.
%
% @seealso{tmvs, tmvs_source, tmvs_quantity, tmvs_site, tmvs_surface, tmvs_room, tmvs_section}
%
% @end deftypefn

function y = tmvs_region (x)

if nargin == 0
  y = 'Region';
else
  if ischar (x)
    switch tolower (x)
    case 'autiolahti'
      y = 1;
    case {'jyvaskyla', 'jyväskylä', 'jyv?skyl?'}
      y = 2;
    otherwise
      error ('region ''%s'' not known', x);
    end
  elseif isindex (x)
    switch x
    case 1
      y = 'Autiolahti';
    case 2
      y = 'Jyvaskyla';
    otherwise
      error ('region %d not known', x);
    end
  else
    error ('wrong type ''%s''', class (x));
  end
end

end

%!shared f, n
%! f = @tmvs_region;
%! n = 2;

%!test
%! for i = 1 : n
%!   assert (f (i), f (f (f (i))));
%! end
