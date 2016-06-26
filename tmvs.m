% This file is reserved for documentation.
% Currently it holds integration tests.

filename = 'excerpt/2010/118-0.csv';
cachename = '2010-118.tmp';
parsed = tmvs_parse (filename);
filename = 'excerpt/2011/118-0.csv';
cachename = '2011-118.tmp';
fetched = tmvs_fetch (filename, cachename);
merged = tmvs_merge (parsed, fetched);
interpolated = tmvs_interpolate (merged);
discretized = tmvs_discretize (interpolated);
tmvs_visualize (discretized);

function tmvs_one_shot ()
arrays = tmvs_glob ('excerpt/*/[0-9]*.csv');
tmvs_store ('excerpt-rooms.tmp', arrays);
disp (fieldnames (arrays));
arrays = tmvs_glob ('excerpt/*/[a-z]*.csv');
tmvs_store ('excerpt-stations.tmp', arrays);
% arrays = tmvs_glob ('excerpt/*.csv');
% tmvs_store ('excerpt-observatories.tmp', arrays);
end

function tmvs_one_shot_for_real ()
arrays = tmvs_glob ('../data/*/[0-9]*.csv');
tmvs_store ('data-rooms.tmp', arrays);
disp (fieldnames (arrays));
arrays = tmvs_glob ('../data/*/[a-z]*.csv');
tmvs_store ('data-stations.tmp', arrays);
% arrays = tmvs_glob ('../data/*/[a-z]*.csv');
% tmvs_store ('data-observatories.tmp', arrays);
end

% This takes 360 seconds.
% filename = '../data/2010/118-0.csv';
% cachename = 'test.tmp';
% tmvs_purge (filename, cachename);
% tic
% fetched = tmvs_fetch (filename, cachename);
% toc
% This takes 0.2 seconds.
% filename = '../data/2010/118-0.csv';
% cachename = 'test.tmp';
% tic
% fetched = tmvs_fetch (filename, cachename);
% toc
