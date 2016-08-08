% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_drawi (@var{aggr})
% @deftypefnx {Function File} {} tmvs_drawi (@var{aggr}, @var{n})
% @deftypefnx {Function File} {} tmvs_drawi (@var{aggr}, @var{n}, @var{datefmt})
%
% Visualize an aggregate with an interactive plot.
%
% This procedure draws an interactive plot of the data points
% for all the identifiers in the aggregate @var{aggr}.
% First a point cloud of all the ordinals is drawn into figure @var{n(1)}
% with the date format @code{datefmt}.
% Once a point in time is selected from it,
% a projection over all the ordinals is drawn into figure @var{n(2)}.
% This process is repeated until the interaction is cancelled or
% an impossible point in time is selected.
%
% This interaction really pushes the boundaries
% of what Octave can do and relies on @code{ginput},
% so the interaction can be quite finicky.
%
% See @code{tmvs} for complete examples.
%
% @seealso{tmvs, tmvs_drawp, tmvs_draws, ginput}
%
% @end deftypefn

function tmvs_drawi (aggr, n = [1, 2], datefmt = 'yyyy-mm-dd')

if n(1) == n(2)
  error ('images %d and %d not distinct', n(1), n(2));
end

a = vertcat (aggr.pairs);
a = a(sparsify (a(:, 1), 1000), :);

t = a(:, 1);
q = a(:, 2);

figure (n(1));
clf ();
plot (t, q, '.1');
datetick ('x', datefmt);
xlabel ('Date');
if numel (aggr) > 1
  ylabel (tmvs_quantity (aggr(1).id.quantity));
end

interp = tmvs_interpolate (aggr, 'extrap');
finterp = filteru (@(s) ~isempty (s.domain), interp);

a = vertcat (finterp.domain);
dom = [(min (a(:, 1))), (max (a(:, 2)))];

a = vertcat (finterp.codomain);
codom = [(min (a(:, 1))), (max (a(:, 2)))];

t = mean (dom);

while true
  figure (n(1));
  h = line ([t, t], codom);

  eaggr = tmvs_evaluate (finterp, t);

  x = arrayfun (@(s) s.meta.position, eaggr);
  q = vertcat (eaggr.pairs)(:, 2);

  f = @(dx, s) max ([dx, (max (tmvs_uncertainty (s.id, q)))]);
  dx = foldl (f, eaggr, 0);

  [x, k] = sort (x);
  q = q(k);

  figure (n(2));
  clf ();
  errorbar (x, q, dx, '~1');
  xlabel ('Position');
  if numel (eaggr) > 1
    ylabel (tmvs_quantity (eaggr(1).id.quantity));
  end

  figure (n(1));
  t = ginput (1);
  if isempty (t) || ~withinc (t, dom)
    break
  end
  delete (h);
end

end
