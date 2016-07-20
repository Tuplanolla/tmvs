% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_discretize (@var{interp})
% @deftypefnx {Function File} {@var{aggr} =} tmvs_discretize (@var{interp}, @var{n})
%
% Does things.
% Mention: all vars.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{daggr = tmvs_discretize (interp);
% plot (num2cell (daggr(3).pairs, 1)@{:@});}
% @end example
%
% @seealso{tmvs, tmvs_interpolate, tmvs_evaluate}
%
% @end deftypefn

function aggr = tmvs_discretize (interp, n = 100)

aggr = struct ('id', {}, 'meta', {}, 'pairs', {});
aggr = resize (aggr, size (interp));

for i = 1 : numel (interp)
  aggr(i) = tmvs_evaluate (interp(i), linspace (num2cell (interp(i).domain){:}, n)(:));
end

end
