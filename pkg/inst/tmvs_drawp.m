% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_drawp (@var{aggr}, @var{varargin})
%
% Mention: all vars.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_visualize (aggr, ...);}
% @end example
%
% @seealso{tmvs, tmvs_fetch}
%
% @end deftypefn

function tmvs_drawp (aggr, n = 1, datefmt = 'yyyy-mm-dd')

k = numel (aggr);

figure (n);
clf ();

hold ('on');
for i = 1 : k
  t = aggr(i).pairs(:, 1);
  x = aggr(i).pairs(:, 2);
  dx = tmvs_uncertainty (aggr(i).id, x);

  fmt = sprintf ('~%d', mod (i, 6));
  errorbar (t, x, dx, fmt);
end
hold ('off');

datetick ('x', datefmt);
xlabel (sprintf ('Date [%s]', datefmt));
if k == 1
  ylabel (tmvs_quantity (aggr.id.quantity));
elseif k > 1
  legend (foldl (@(y, s) horzcat (y, tmvs_quantity (s.id.quantity)), aggr, {}));
end

end
