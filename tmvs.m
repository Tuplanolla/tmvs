function arrays = tmvs_parse(file)
% TODO This is not robust and is, in fact, really slow.
[name, time, value, ~, notes] = ...
  textread(file, '%s %s %f %f %s', 'delimiter', ',', 'headerlines', 1);
name = strrep(name, '"', '');
time = strrep(time, '"', '');
notes = strrep(notes, '"', '');

% TODO This does not take leap seconds etc into account.
secs = nan(size(time));
for k = [1 : length(time)]
  [year, month, day, hour, minute, second] = ...
    datevec(time{k}, 'yyyy/mm/dd HH:MM:SS');
  secs(k) = datenum(year, month, day, hour, minute, second);
end

% TODO This may not catch different names for the same thing.
devs = unique(name);

% TODO Sort and verify.
arrays = struct();
for k = [1 : length(devs)]
  pred = strcmp(name, devs{k});
  arr = [secs(pred), value(pred)];
  arrays = setfield(arrays, devs{k}, arr);
end

% TODO Include uncertainties.
% TODO Write structural data documentation.
end

function interps = tmvs_interpolate(arrays, method = 'linear')
fields = fieldnames(arrays);
interps = struct();
for k = [1 : length(fields)]
  field = fields{k};
  array = getfield(arrays, field);
  x = array(:, 1);
  y = array(:, 2);
  % TODO Ensure table not too short (zero or one element).
  n = length(x);
  if n < 2
    error(sprintf('not enough data points: %d'), n);
  end
  fun = @(time) interp1(x, y, time, method);
  bunch = struct('function', fun, 'limits', [min(x), max(x)]);
  interps = setfield(interps, field, bunch);
end
end

function arrays = tmvs_discretize(interps, points = 100)
fields = fieldnames(interps);
arrays = struct();
for k = [1 : length(fields)]
  field = fields{k};
  interp = getfield(interps, field);
  fun = getfield(interp, 'function');
  lims = getfield(interp, 'limits');
  % TODO Ensure lims increasing and points positive.
  x = linspace(lims(1), lims(2), points)';
  y = fun(x);
  arrays = setfield(arrays, field, [x, y]);
end
end

function handle = tmvs_visualize(arrays, n = 1)
handle = figure(n);
clf();
hold('on');
fields = fieldnames(arrays);
for k = [1 : length(fields)]
  field = fields{k};
  array = getfield(arrays, field);
  x = array(:, 1);
  y = array(:, 2);
  fmt = sprintf('-%d', mod(k - 1, 4) + 1);
  plot(x, y, fmt);
end
xlabel('Time');
% TODO What value? Better separate different units into their own plots?
ylabel('Value');
% TODO Fix this clusterfuck.
% datetick('x', 'yyyy-mm-dd HH:MM:SS');
datetick('x', 'mm-dd HH:MM');
% legend(fields);
legend(cellfun(@(s) fliplr(strtrunc(fliplr(s), 13)), fields, 'UniformOutput', false));
hold('off');
end

function tmvs_clear()
error('call clear yourself');
end

function arrays = tmvs_fetch(file, cache = sprintf('%s.tmp', file))
% TODO Check for races.
if exist(cache, 'file')
  arrays = tmvs_recall(cache);
else
  arrays = tmvs_parse(file);
  tmvs_store(cache, arrays);
end
end

function interps = tmvs_lift(file, cache = sprintf('%s.tmp', file))
% TODO Implement or scrap.
end

function tmvs_store(file, arrays, format = '-mat', zip = true)
if zip
  save(format, '-zip', file, 'arrays');
else
  save(format, file, 'arrays');
end
end

function arrays = tmvs_recall(file)
arrays = getfield(load(file, 'arrays'), 'arrays');
end

function tmvs_purge(file, cache = sprintf('%s.tmp', file))
if exist(cache, 'file')
  [err, msg] = unlink(cache);
  if err ~= 0
    error(err);
  end
end
end

% TODO Move tests elsewhere.
file = '../data/sample/118-0.csv';
cache = 'cache.tmp';
parsed = tmvs_parse(file);
interpolated = tmvs_interpolate(parsed);
discretized = tmvs_discretize(interpolated);
plotted = tmvs_visualize(discretized);

% This takes half an hour.
% tmvs_purge(file, cache);
% file = '../data/2010/118-0.csv';
% tic
% fetched = tmvs_fetch(file, cache);
% toc
tic
fetched = tmvs_fetch(file, cache);
toc

% plotted = tmvs_visualize(fetched);
