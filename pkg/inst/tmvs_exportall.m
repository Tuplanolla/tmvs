% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_exportall (@var{dname}, @var{aggr})
% @deftypefnx {Function File} {} tmvs_exportall (@var{dname}, @var{aggr}, @var{f})
%
% Write the data points in an aggregate into several files.
%
% If you want to save the data points for just one identifier,
% use @code{tmvs_export} instead.
%
% This procedure exports the data points for all the identifiers
% in the aggregate @var{aggr} into different files
% inside the directory @var{dname}.
% If @var{f} is omitted, the files are simply numbered.
% Otherwise the file names are determined by the injective function @var{f}:
% the file name is @code{f (i, id)} for each
% index @var{i} and identifier @var{id} in the aggregate @var{aggr}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));}
% @code{tmvs_exportall ('/tmp', aggr);}
% @end example
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));}
% @code{tmvs_exportall ('/tmp', aggr, @@(i, ~) sprintf ('%d.csv', i));
% tmvs_exportall ('/tmp', aggr, @@(~, id) sprintf ( ...
%   '%d-%d-%d.csv', id.quantity, id.section, id.ordinal));}
% @end example
%
% @seealso{tmvs, tmvs_export, dlmwrite, sprintf}
%
% @end deftypefn

function tmvs_exportall (dname, aggr, f = @(i, ~) sprintf ('%d.csv', i))

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
