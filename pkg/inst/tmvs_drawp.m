% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_drawp (@var{aggr})
% @deftypefnx {Function File} {} tmvs_drawp (@var{aggr}, @var{n})
% @deftypefnx {Function File} {} tmvs_drawp (@var{aggr}, @var{n}, @var{datefmt})
%
% Visualize an aggregate with a simple plot.
%
% This procedure draws a simple plot of the data points
% for all the identifiers in the aggregate @var{aggr}.
% The plot is drawn into figure @var{n} with the date format @code{datefmt}.
%
% See @code{tmvs} for complete examples.
%
% @seealso{tmvs, tmvs_drawi, tmvs_draws, plot}
%
% @end deftypefn

function tmvs_drawp (aggr, n = 1, datefmt = 'yyyy-mm-dd')

k = numel (aggr);

figure (n);
clf ();

hold ('on');
for i = 1 : k
  t = aggr(i).pairs(:, 1);
  q = aggr(i).pairs(:, 2);
  dq = tmvs_uncertainty (aggr(i).id, q);

  fmt = sprintf ('~%d', mod (i, 6));
  errorbar (t, q, dq, fmt);
end
hold ('off');

datetick ('x', datefmt);
xlabel (sprintf ('Date [%s]', datefmt));
if k == 1
  ylabel (tmvs_quantity (aggr.id.quantity));
elseif k > 1
  legend (foldl (@(c, s) horzcat (c, tmvs_quantity (s.id.quantity)), aggr, {}));
end

end
