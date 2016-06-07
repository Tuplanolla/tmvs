function tmvs_visualize(arrays, n = 1)
figure(n);
clf();
hold('on');

% TODO This is sloppy.
arrays = tmvs_filter(arrays, 'RH118');

names = fieldnames(arrays);
for i = 1 : length(names)
  name = names{i};

  array = arrays.(name);
  j = mod(i - 1, 4) + 1;

  x = array(:, 1);
  y = array(:, 2);
  fmt = sprintf('.-%d', j);
  plot(x, y, fmt);

  % TODO This causes legendary problems.
  % xi = linspace(min(x), max(x));
  % fmt = sprintf('-%d', j);
  % plot(xi, spline(x, y, xi), fmt);
end

% TODO This is too wide.
% form = 'yyyy-mm-dd HH:MM:SS';
form = 'yyyy-mm-dd';

xlabel(sprintf('Date [%s]', form));
ylabel('Relative Humidity [\%]');

datetick('x', form);

words = @(a, b) @(s) (@(n) s(n(a) + 1 : n(b + 1) - 1))([0, find(s == ' ')]);

% TODO This is too cluttered.
% legend(names);
legend(cellfun(words(3, 5), names, 'uniformoutput', false), 'location', 'northoutside');

axis('tight');

hold('off');
end
