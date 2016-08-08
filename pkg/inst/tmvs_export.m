% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_export (@var{fname}, @var{aggr}, @var{id})
%
% Write the data points for an identifier in an aggregate into a file.
%
% If you want to save a complete aggregate at once,
% use @code{tmvs_exportall} instead, because it is more convenient.
%
% This procedure exports the data points for the identifier @var{id}
% in the aggregate @var{aggr} to the comma-separated value file @var{fname}
% with the delimiter @qcode{'|'}.
% If @var{fname} already exists, it is overwritten.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));}
% @code{tmvs_export ('/tmp/tmvs.csv', aggr, aggr(9).id)}
% @end example
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 5]
% @end example
%
% @seealso{tmvs, tmvs_exportall, tmvs_findid, dlmwrite}
%
% @end deftypefn

function tmvs_export (fname, aggr, id)

dlmwrite (fname, aggr(tmvs_findid (aggr, id)).pairs, '|');

end
