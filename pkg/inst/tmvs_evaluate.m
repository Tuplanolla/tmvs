% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_evaluate (@var{interp}, @var{t})
%
% Does things.
% Mention: all vars.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{eaggr = tmvs_evaluate (interp);}
% @code{fieldnames (eaggr)}
% @result{} @{'id', 'meta', 'pairs'@}
% @end example
%
% @seealso{tmvs, tmvs_interpolate, tmvs_discretize}
%
% @end deftypefn

% tmvs_evaluate (tmvs_interpolate (maggr), 734.7e+3)

function aggr = tmvs_evaluate (interp, t)

aggr = struct ('id', {}, 'meta', {}, 'pairs', {});
aggr = resize (aggr, size (interp));

for i = 1 : numel (interp)
  a = interp(i).domain;

  if numel (a) < 2
    z = [];
  else
    z = [t, (interp(i).function (t))];
  end

  aggr(i) = struct ('id', interp(i).id, ...
                    'meta', interp(i).meta, ...
                    'pairs', z);
end

end
