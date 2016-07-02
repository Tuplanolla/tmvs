% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_export (@var{fname}, @var{a})
%
% Exports the aggregate @var{a}
% to the comma-separated value file @var{fname} with the delimiter @qcode{'|'}.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_export ('/tmp/tmvs.csv', tmvs_fetch ('excerpt/2011/120-0.csv'))}
% @end example
%
% @seealso{dlmwrite, tmvs, tmvs_fetch}
% @end deftypefn

function tmvs_export (fname, a)

error ('nope');

end
