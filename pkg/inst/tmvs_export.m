% -*- texinfo -*-
% @deftypefn {Function File} tmvs_export (@var{fname}, @var{c})
% @deftypefnx {Function File} tmvs_export (@var{fname}, @var{c}, @var{dlm})
%
% Export the central data structure @var{c}
% to the comma-separated value file @var{fname}.
%
% The optional delimiter @var{dlm} can be chosen arbitrarily,
% but should not appear in the displayed form of @var{c}.
% Otherwise data corruption is possible due to lack of quotation.
% The default delimiter is @qcode{'|'},
% because it does not appear in the excerpt data set.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_export ('/tmp/tmvs.csv', tmvs_fetch ('excerpt/2011/118-0.csv'))}
% @end example
%
% @seealso{dlmwrite, tmvs, tmvs_fetch}
% @end deftypefn

function tmvs_export (fname, c, dlm = '|')

error ('nope');

end
