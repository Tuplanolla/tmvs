% TODO Do some work.
function handle = tmvs_visualize(arrays)
handle = figure(1);
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
words = @(a, b) @(s) (@(n) s(n(a) + 1 : n(b + 1) - 1))([0, find(s == ' ')]);
legend(cellfun(words(3, 5), fields, 'UniformOutput', false));
hold('off');
end
