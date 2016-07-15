% -*- texinfo -*-
% @deftypefn {Function File} {@var{s} =} tmvs_printid (@var{id})
%
% Pretty prints the identifier @var{id}.
%
% @seealso{tmvs}
%
% @end deftypefn

function s = tmvs_printid (id)

f = @(x, y, z) sprintf ('%s%17s: %s\n', x, y, z);
s = '';

if isfield (id, 'source')
  s = f (s, 'Data Source', tmvs_source (id.source));
end

if isfield (id, 'quantity')
  s = f (s, 'Physical Quantity', tmvs_quantity (id.quantity));
end

if isfield (id, 'site')
  s = f (s, 'Measuring Site', tmvs_site (id.site));
end

if isfield (id, 'surface')
  s = f (s, 'Surface', tmvs_surface (id.surface));
end

if isfield (id, 'room')
  s = f (s, 'Room', tmvs_room (id.room));
end

if isfield (id, 'section')
  s = f (s, 'Section', tmvs_section (id.section));
end

if isfield (id, 'ordinal')
  s = f (s, 'Ordinal', sprintf ('%d', id.ordinal));
end

if isfield (id, 'region')
  s = f (s, 'Region', tmvs_region (id.region));
end

if isfield (id, 'position')
  s = f (s, 'Position', sprintf ('%f mm', id.position));
end

if isfield (id, 'material')
  s = f (s, 'Material', tmvs_material (id.material));
end

end
