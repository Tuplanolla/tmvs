% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_drawi (@var{aggr}, @var{varargin})
%
% Mention: all vars.
% This is pushing the boundaries of what Octave and Gnuplot can do,
% so the interaction is quite finicky.
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
