% -*- texinfo -*-
% @deftypefn {Function File} {@var{i} =} tmvs_findid (@var{aggr}, @var{id})
%
% Find the index of an identifier in an aggregate.
%
% This function finds the index @var{i} of the identifier @var{id}
% in the aggregate @var{aggr} or returns zero if the identifier is not present.
% This is faster than simply using @code{find} or equivalent,
% because of shallow equality comparisons and logical short circuiting.
%
% The following example demonstrates basic usage.
%
% @example
% @code{aggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));}
% @code{tmvs_findid (aggr, aggr(3).id)}
% @result{} 3
% @end example
%
% @seealso{tmvs, tmvs_dispid, find}
%
% @end deftypefn

function i = tmvs_findid (aggr, id)

i = 0;

for j = 1 : numel (aggr)
  % Calling @code{isequaln} here would be really slow.
  if isequals (aggr(j).id, id)
    i = j;

    break
  end
end

end
