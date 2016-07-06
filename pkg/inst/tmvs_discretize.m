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
% @code{aggrd = tmvs_discretize (interp);
% plot (num2cell (aggrd(3).pairs, 1){:});}
% @end example
%
% @seealso{tmvs, tmvs_interpolate}
%
% @end deftypefn

function aggr = tmvs_discretize (interp, n = 100)

aggr = struct ('id', {}, 'meta', {}, 'pairs', {});
aggr = resize (aggr, size (interp));

for i = 1 : numel (interp)
  a = interp(i).limits;

  if numel (a) < 2
    z = [];
  else
    t = linspace (a(1), a(2), n)';
    z = [t, (interp(i).function (t))];
  end

  aggr(i) = struct ('id', aggr(i).id, ...
                    'meta', aggr(i).meta, ...
                    'pairs', z);
end

end
