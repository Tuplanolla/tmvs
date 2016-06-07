% This file is reserved for integration tests.

filename = 'excerpt/2010/118-0.csv';
cachename = 'excerpt.tmp';
parsed = tmvs_parse(filename);
filename = 'excerpt/2011/118-0.csv';
cachename = 'other-excerpt.tmp';
fetched = tmvs_fetch(filename, cachename);
merged = tmvs_merge(parsed, fetched);
interpolated = tmvs_interpolate(merged);
discretized = tmvs_discretize(interpolated);
tmvs_visualize(discretized);

% This takes 360 seconds.
% filename = '../data/2010/118-0.csv';
% cachename = 'data.tmp';
% tmvs_purge(filename, cachename);
% tic
% fetched = tmvs_fetch(filename, cachename);
% toc
% This takes 0.2 seconds.
% filename = '../data/2010/118-0.csv';
% tic
% fetched = tmvs_fetch(filename, cachename);
% toc

% plotted = tmvs_visualize(fetched);

%!test
%! filename = 'excerpt/2010/118-0.csv';
%! fieldname = 'KoeRakQS118 - RH118 A1 180mm 160 PUR';
%! assert(tmvs_parse(filename).(fieldname)(1, :), [734265, 37], 1);
%! assert(tmvs_parse(filename).(fieldname)(2, :), [734383, 54], 1);

%!test
%! filename = 'excerpt/2010/118-0.csv';
%! fieldname = 'KoeRakQS118 - RH118 A1 180mm 160 PUR';
%! func = tmvs_interpolate(tmvs_parse(filename)).(fieldname);
%! assert(func.function(734324), 46, 1);
%! assert(func.limits, [734265, 734591], 1);

%!test
%! filename = 'excerpt/2010/118-0.csv';
%! fieldname = 'KoeRakQS118 - RH118 A1 180mm 160 PUR';
%! arrays = tmvs_discretize(tmvs_interpolate(tmvs_parse(filename)), 5);
%! assert(tmvs_parse(filename).(fieldname)(1, :), [734265, 37], 1);
%! assert(tmvs_parse(filename).(fieldname)(2, :), [734383, 54], 1);
