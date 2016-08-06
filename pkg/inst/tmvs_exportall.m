% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_exportall (@var{dname}, @var{aggr}, @var{f})
%
% Plural of this:
% Exports the data from the aggregate @var{aggr}
% to the comma-separated value files returned by @var{f}
% when given the corresponding index and identifier.
% The delimiter is @qcode{'|'}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_exportall ('/tmp', aggr)}
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

if ~isdir (dname)
  error ('not a directory ''%s''', dname);
end

for i = 1 : n
  dlmwrite (sprintf ('%s/%s', dname, c{i}), aggr(i).pairs, '|');
end

end
