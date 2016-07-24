% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_draws (@var{aggr}, @var{varargin})
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

function tmvs_draws (aggr, n = 1, datefmt = 'yyyy-mm-dd')

a = vertcat (aggr.pairs);
a = a(sparsify (a(:, 1), 1000), :);

t = sort (a(:, 1));

interp = tmvs_interpolate (aggr, 'extrap');
finterp = filteru (@(s) ~isempty (s.domain), interp);
eaggr = tmvs_evaluate (finterp, t);

y = foldl (@(y, s) horzcat (y, s.meta.position), eaggr, []);
x = foldl (@(x, s) horzcat (x, s.pairs(:, 2)), eaggr, []);

figure (n);
clf ();

surf (repmat (t, 1, columns (x)), repmat (y, rows (x), 1), x);

datefmt = 'yyyy-mm-dd';
datetick ('x', datefmt);
xlabel ('Date');
ylabel ('Position');
if numel (eaggr) > 1
  zlabel (tmvs_quantity (eaggr(1).id.quantity));
end
colormap ('hot');

end
