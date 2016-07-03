% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_exportall (@var{fname}, @var{aggr}, @var{id})
%
% Wrong:
% Exports the data matching the identifier @var{id} from the aggregate @var{aggr}
% to the comma-separated value file @var{fname} with the delimiter @qcode{'|'}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_export ('/tmp/tmvs.csv', tmvs_fetch ('excerpt/2011/120-0.csv'))}
% @end example
%
% @seealso{dlmwrite, tmvs, tmvs_fetch}
%
% @end deftypefn

function tmvs_exportall (fname, aggr, id)

error ('nope');

end
