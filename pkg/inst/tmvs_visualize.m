% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_visualize (@var{aggr}, @var{graph}, @var{varargin})
%
% Mention: all vars.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_visualize (aggr, tmvs_graph ('simple'), false, 9);}
% @code{tmvs_visualize (aggr, tmvs_graph ('slice'), true, tmvs_quantity ('temperature'), tmvs_room ('123'), tmvs_site ('M'), tmvs_source ('test lab'));}
% @end example
%
% @seealso{tmvs, tmvs_fetch}
%
% @end deftypefn

function tmvs_visualize (aggr, graph, unc = true, varargin)

% TODO This is too wide.
% datefmt = 'yyyy-mm-dd HH:MM:SS';
datefmt = 'yyyy-mm-dd';

% TODO Be more creative.
switch tmvs_graph (graph)
case 'simple'
  i = varargin{:};

  figure (1);
  clf ();
  hold ('on');

  s = aggr(i);

  fprintf (tmvs_printid (s.id));

  t = s.pairs(:, 1);
  x = s.pairs(:, 2);

  if unc
    dx = tmvs_uncertainty (s.id, x);
    fmt = sprintf ('~%d', 1);
    errorbar (t, x, dx, fmt);
  else
    fmt = sprintf ('.-%d', 1);
    plot (t, x, fmt);
  end

  xlabel (sprintf ('Date [%s]', datefmt));
  datetick ('x', datefmt);
  ylabel (tmvs_quantity (s.id.quantity));

  hold ('off');
case 'slice'
  [qty, room, site, src] = varargin{:};

  figure (1);
  clf ();
  hold ('on');

  f = @(s) s.id.quantity == qty && ...
           s.id.room == room && ...
           s.id.site == site && ...
           s.id.source == src;
  interp = tmvs_interpolate (tmvs_filteru (f, aggr), 'extrap');

  a = [inf, -inf];

  for i = 1 : numel (interp)
    b = interp(i).limits;

    a = [(min ([a(1), b(1)])), (max ([a(2), b(2)]))];
  end

  t = linspace (a(1), a(2));
  x = interp(1).function (t);

  s = interp(1);

  if unc
    dx = tmvs_uncertainty (s.id, x);
    fmt = sprintf ('~%d', 1);
    errorbar (t, x, dx, fmt);
  else
    fmt = sprintf ('.-%d', 1);
    plot (t, x, fmt);
  end

  xlabel (sprintf ('Date [%s]', datefmt));
  datetick ('x', datefmt);
  ylabel ('?? [1]');

  hold ('off');

  while true
    figure (1);

    [t, x, b] = ginput (1);

    figure (2);
    clf ();

    y = [];
    x = [];

    for i = 1 : numel (interp)
      s = interp(i);

      y = [y; s.meta.position];
      x = [x; (interp(i).function (t))];
    end

    [y, k] = sort (y);
    x = x(k);

    if unc
      dx = tmvs_uncertainty (s.id, x);
      fmt = sprintf ('~%d', 1);
      errorbar (y, x, dx, fmt);
    else
      fmt = sprintf ('.-%d', 1);
      plot (y, x, fmt);
    end

    xlabel ('Position [m]');
    ylabel (tmvs_quantity (interp(1).id.quantity));
  end
otherwise
  error ('graph ''%s'' not supported', tmvs_graph (graph));
end

end
