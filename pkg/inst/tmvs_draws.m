% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_draws (@var{aggr})
% @deftypefnx {Function File} {} tmvs_draws (@var{aggr}, @var{n})
% @deftypefnx {Function File} {} tmvs_draws (@var{aggr}, @var{n}, @var{datefmt})
%
% Visualize an aggregate with a three-dimensional surface.
%
% This procedure draws an three-dimensional surface of the data points
% for all the identifiers in the aggregate @var{aggr}.
% The third dimension spans the ordinals just like in @code{tmvs_drawi}.
%
% See @code{tmvs} for complete examples.
%
% @seealso{tmvs, tmvs_drawp, tmvs_drawi, surf}
%
% @end deftypefn

function tmvs_draws (aggr, n = 1, datefmt = 'yyyy-mm-dd')

a = vertcat (aggr.pairs);
a = a(sparsify (a(:, 1), 1000), :);

t = sort (a(:, 1));

interp = tmvs_interpolate (aggr, nan);
finterp = filteru (@(s) ~isempty (s.domain), interp);
eaggr = tmvs_evaluate (finterp, t);

x = foldl (@(x, s) horzcat (x, s.meta.position), eaggr, []);
q = foldl (@(q, s) horzcat (q, s.pairs(:, 2)), eaggr, []);

figure (n);
clf ();

surf (repmat (t, 1, columns (q)), repmat (x, rows (q), 1), q);

datefmt = 'yyyy-mm-dd';
datetick ('x', datefmt);
xlabel ('Date');
ylabel ('Position');
if numel (eaggr) > 1
  zlabel (tmvs_quantity (eaggr(1).id.quantity));
end
colormap ('hot');

end
