% -*- texinfo -*-
% @deftypefn {Function File} {} tmvs_visualize (@var{aggr}, @var{graph}, @var{varargin})
%
% Mention: all vars.
% This is pushing the boundaries of what Octave and Gnuplot can do,
% so the interaction is quite finicky.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_visualize (aggr, tmvs_graph ('simple'), false, 9);}
% @code{tmvs_visualize (aggr, tmvs_graph ('slice'), true, tmvs_quantity ('Temperature'), tmvs_room ('123'), tmvs_site ('M'), tmvs_source ('Test Lab'));}
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
% TODO Split into different procedures; keep the interface 'open' to change.
switch tmvs_graph (graph)
case 'simple'
  i = varargin{:};

  figure (1);
  clf ();
  hold ('on');

  s = aggr(i);

  fprintf (tmvs_dispid (s.id));

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
  [qty, room, site, src, sec] = varargin{:};

  figure (1);
  clf ();
  hold ('on');

  f = @(s) s.id.quantity == qty && ...
           s.id.room == room && ...
           s.id.site == site && ...
           s.id.section == sec && ...
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

  fprintf (tmvs_printid (s.id));

  if unc
    dx = tmvs_uncertainty (s.id, x);
    fmt = sprintf ('~%d', 1);
    errorbar (t, x, dx, fmt);
  else
    fmt = sprintf ('.-%d', 1);
    plot (t, x, fmt);
  end

  b = [(min (x)), (max (x))];

  xlabel (sprintf ('Date [%s]', datefmt));
  datetick ('x', datefmt);
  ylabel (tmvs_quantity (interp(1).id.quantity));

  hold ('off');

  fprintf (stdout, 'waiting for input (go outside the range to stop)\n');
  fflush (stdout);

  h = false;

  while true
    figure (1);

    t = ginput (1);

    if isempty (t) || t < a(1) || t > a(2)
      break
    end

    if h
      delete (h);
    end
    h = line ([t, t], b);

    figure (2);
    clf ();

    y = [];
    x = [];

    for i = 1 : numel (interp)
      s = interp(i);

      y = [y; s.meta.position];
      x = [x; (s.function (t))];
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
case 'surface'
  % Copy-paste code is my favorite!

  [qty, room, site, src] = varargin{:};

  figure (3);
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

  t = linspace (a(1), a(2), 100);

  y = [];
  x = [];

  for i = 1 : numel (interp)
    s = interp(i);

    y = [y; s.meta.position];
    x = [x; (s.function (t))];
  end

  [y, k] = sort (y);
  x = x(k, :);

  surf (repmat (t, rows (x), 1), repmat (y, 1, columns (x)), x);

  xlabel (sprintf ('Date [%s]', datefmt));
  datetick ('x', datefmt);
  ylabel ('Position [mm]');
  zlabel (tmvs_quantity (interp(1).id.quantity));

  hold ('off');
otherwise
  error ('graph ''%s'' not supported', tmvs_graph (graph));
end

end
