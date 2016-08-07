% -*- texinfo -*-
% @deftypefn {Function File} {@var{str} =} tmvs_dispmeta (@var{meta})
% @deftypefnx {Function File} {} tmvs_dispmeta (@var{meta})
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
% The result can also be assigned to a variable instead of being printed.
%
% @example
% @code{str = tmvs_dispmeta (aggr(9).meta);}
% @end example
%
% @seealso{tmvs, tmvs_dispid}
%
% @end deftypefn

function str = tmvs_dispmeta (meta)

f = @(str, k, x) sprintf ('%s%20s: %s\n', str, k, x);

st = '';

if isfield (meta, 'position')
  st = f (st, 'Position', sprintf ('%f m', meta.position));
end

if isfield (meta, 'material')
  st = f (st, tmvs_material (), tmvs_material (meta.material));
end

if nargout > 0
  str = st;
else
  fprintf (st);
end

end
