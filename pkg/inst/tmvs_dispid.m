% -*- texinfo -*-
% @deftypefn {Function File} {@var{str} =} tmvs_dispid (@var{id})
% @deftypefnx {Function File} {} tmvs_dispid (@var{id})
%
% Display an identifier.
%
% This procedure formats the identifier @var{id} into the string @var{str}
% with keys in a 20-character column on the left and
% values in an indefinitely wide column on the right.
% The result is printed if it is not used, just like with @code{disp}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ('excerpt/2012/118-0.csv', ...
%                    tmvs_source ('Test Lab'));}
% @code{tmvs_dispid (aggr(9).id);}
% @print{}         Data Source: Test Lab
% @print{}   Physical Quantity: Temperature
% @print{}      Measuring Site: Q
% @print{}             Surface: Wall
% @print{}           Room Name: 118
% @print{}             Section: Bottom Corner
% @print{}             Ordinal: 3
% @end example
%
% The result can also be assigned to a variable instead of being printed.
%
% @example
% @code{str = tmvs_dispid (aggr(9).id);}
% @end example
%
% @seealso{tmvs, tmvs_dispmeta, tmvs_findid, disp}
%
% @end deftypefn

function str = tmvs_dispid (id)

f = @(str, k, x) sprintf ('%s%20s: %s\n', str, k, x);

st = '';

if isfield (id, 'source')
  st = f (st, tmvs_source (), tmvs_source (id.source));
end

if isfield (id, 'quantity')
  st = f (st, tmvs_quantity (), tmvs_quantity (id.quantity));
end

if isfield (id, 'site')
  st = f (st, tmvs_site (), tmvs_site (id.site));
end

if isfield (id, 'surface')
  st = f (st, tmvs_surface (), tmvs_surface (id.surface));
end

if isfield (id, 'room')
  st = f (st, tmvs_room (), tmvs_room (id.room));
end

if isfield (id, 'section')
  st = f (st, tmvs_section (), tmvs_section (id.section));
end

if isfield (id, 'ordinal')
  st = f (st, 'Ordinal', sprintf ('%d', id.ordinal));
end

if isfield (id, 'region')
  st = f (st, tmvs_region (), tmvs_region (id.region));
end

if nargout > 0
  str = st;
else
  fprintf (st);
end

end
