% -*- texinfo -*-
% @deftypefn {Function File} {@var{i} =} tmvs_findid (@var{aggr}, @var{id})
%
% Finds the index @var{i} of the identifier @var{id}
% in the aggregate @var{aggr} or returns zero if the identifier is not present.
% This is faster than simply using @code{find} or equivalent,
% because of logical short circuiting.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetch ('excerpt/2011/120-0.csv', ...
%                    tmvs_source ('test lab'));}
% @code{tmvs_findid (aggr, aggr(3).id)}
% @result{} 3
% @end example
%
% @seealso{tmvs, find}
%
% @end deftypefn

function i = tmvs_findid (aggr, id)

i = 0;

for j = 1 : numel (aggr)
  if isequaln (aggr(j).id, id)
    i = j;

    break
  end
end

end
