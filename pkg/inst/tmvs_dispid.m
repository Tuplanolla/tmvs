% -*- texinfo -*-
% @deftypefn {Function File} {@var{str} =} tmvs_dispid (@var{id})
%
% Formats the identifier @var{id} into the string @var{str}
% with keys in a 20-character column on the left and
% values in an indefinitely wide column on the right.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ('excerpt/2012/118-0.csv', ...
%                    tmvs_source ('Test Lab'));}
% @code{fprintf (tmvs_dispid (aggr(9).id));}
% @print{}         Data Source: Test Lab
%      Physical Quantity: Temperature
%         Measuring Site: Q
%                Surface: Wall
%              Room Name: 118
%                Section: Bottom Corner
%                Ordinal: 3
% @end example
%
% @seealso{tmvs, tmvs_dispmeta}
%
% @end deftypefn

function str = tmvs_dispid (id)

f = @(str, k, v) sprintf ('%s%20s: %s\n', str, k, v);

str = '';

if isfield (id, 'source')
  str = f (str, tmvs_source (), tmvs_source (id.source));
end

if isfield (id, 'quantity')
  str = f (str, tmvs_quantity (), tmvs_quantity (id.quantity));
end

if isfield (id, 'site')
  str = f (str, tmvs_site (), tmvs_site (id.site));
end

if isfield (id, 'surface')
  str = f (str, tmvs_surface (), tmvs_surface (id.surface));
end

if isfield (id, 'room')
  str = f (str, tmvs_room (), tmvs_room (id.room));
end

if isfield (id, 'section')
  str = f (str, tmvs_section (), tmvs_section (id.section));
end

if isfield (id, 'ordinal')
  str = f (str, 'Ordinal', sprintf ('%d', id.ordinal));
end

if isfield (id, 'region')
  str = f (str, tmvs_region (), tmvs_region (id.region));
end

end
