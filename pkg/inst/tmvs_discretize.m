% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_discretize (@var{interp})
% @deftypefnx {Function File} {@var{aggr} =} tmvs_discretize (@var{interp}, @var{n})
%
% Does things.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}
% @end example
%
% @seealso{tmvs, tmvs_interpolate}
%
% @end deftypefn

function aggr = tmvs_discretize (interp, n = 100)

names = fieldnames (interp);

aggr = struct ();
for i = 1 : length (names)
  name = names{i};

  interp = interp.(name);

  limits = interp.limits;
  days = linspace (limits(1), limits(2), n)';
  aggr.(name) = [days, (interp.function (days))];
end

end
