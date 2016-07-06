% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_exportall (@var{dname}, @var{aggr}, @var{f})
%
% Wrong:
% Exports the data matching the identifier @var{id} from the aggregate @var{aggr}
% to the comma-separated value file @var{fname} with the delimiter @qcode{'|'}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_exportall ('/tmp', aggr, @@(i, ~) sprintf ('%d.csv', i))}
% @code{tmvs_exportall ('/tmp', aggr, @@(~, id) sprintf ('%d-%d-%d.csv', id.quantity, id.section, id.ordinal))}
% @end example
%
% @seealso{dlmwrite, tmvs, tmvs_fetch}
%
% @end deftypefn

function tmvs_exportall (dname, aggr, f = @(i, ~) sprintf ('%d', i))

n = numel (aggr);

c = cell (n, 1);

for i = 1 : n
  c{i} = f (i, aggr(i).id);
end

if numel (unique (c)) ~= numel (c)
  error ('naming function is not injective');
end

if ~isdir (fname)
  error ('not a directory ''%s''', fname);
end

for i = 1 : n
  dlmwrite (sprintf ('%s/%s', fname, c{i}), aggr(i).pairs, '|');
end

end
