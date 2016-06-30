% TODO This is incomplete due to missing requirements.
function tmvs_visualize (arrays, n = 1, pat = false, string = '')

if pat
  arrays = tmvs_filter (arrays, pat);
end

% TODO Elsewhere... and also humidity.
% arrays = tmvs_map (@(~, array) array(chauvenet (array(:, 2)), :), arrays);

figure (n);
clf ();
hold ('on');

names = fieldnames (arrays);
for i = 1 : length (names)
  name = names{i};

  array = arrays.(name);
  j = mod (i - 1, 4) + 1;

  x = array(:, 1);
  y = array(:, 2);
  dy = 4e-2 * y;
  % fmt = sprintf ('.-%d', j);
  fmt = sprintf ('~%d', j);
  errorbar (x, y, dy, fmt);

  % TODO This causes legendary problems.
  % xi = linspace (min (x), max (x));
  % fmt = sprintf ('-%d', j);
  % plot (xi, spline (x, y, xi), fmt);
end

% TODO This is too wide.
% form = 'yyyy-mm-dd HH:MM:SS';
form = 'yyyy-mm-dd';

xlabel (sprintf ('Date [%s]', form));
ylabel (string);

datetick ('x', form);

shorten = @(s) strsplit (s, ' - '){2};

% TODO This is too cluttered.
% legend (names);
% legend (cellfun (shorten, names, ...
%   'uniformoutput', false), 'location', 'northoutside');

axis ('tight');

hold ('off');

end
