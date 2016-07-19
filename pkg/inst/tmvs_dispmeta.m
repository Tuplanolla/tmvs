% -*- texinfo -*-
% @deftypefn {Function File} {@var{str} =} tmvs_dispmeta (@var{meta})
%
% Formats the metadata @var{meta} into the string @var{str}
% with keys in a 20-character column on the left and
% values in an indefinitely wide column on the right.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ('excerpt/2012/118-0.csv', ...
%                    tmvs_source ('Test Lab'));}
% @code{fprintf (tmvs_dispmeta (aggr(9).meta));}
% @print{}            Position: 0.295 m
%               Material: Polyurethane
% @end example
%
% @seealso{tmvs, tmvs_dispid}
%
% @end deftypefn

function str = tmvs_dispmeta (meta)

f = @(str, k, v) sprintf ('%s%20s: %s\n', str, k, v);

str = '';

if isfield (meta, 'position')
  str = f (str, 'Position', sprintf ('%f m', meta.position));
end

if isfield (meta, 'material')
  str = f (str, tmvs_material (), tmvs_material (meta.material));
end

end
