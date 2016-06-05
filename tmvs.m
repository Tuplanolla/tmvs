% This is reserved for integration tests.
function tmvs()
test('tmvs_parse.m');
test('tmvs_interpolate.m');
test('tmvs_discretize.m');
test('tmvs_visualize.m');
test('tmvs_clear.m');
test('tmvs_fetch.m');
test('tmvs_store.m');
test('tmvs_recall.m');
test('tmvs_purge.m');

% TODO Move tests elsewhere.
file = 'excerpt/2010/118-0.csv';
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
end
