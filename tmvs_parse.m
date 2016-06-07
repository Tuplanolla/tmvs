% TODO This is still a little slow and fragile.
function arrays = tmvs_parse(filename)
[id, date, x, ~, ~] = ...
  textread(filename, '%s %s %f %s %s', 'delimiter', '|', 'headerlines', 1);

n = rows(id);

daysx = [nan(n, 1), x];
for i = 1 : n
  [year, month, day, hour, minute, second] = ...
    datevec(strrep(date{i}, '"', ''), 'yyyy/mm/dd HH:MM:SS');
  daysx(i, 1) = datenum(year, month, day, hour, minute, second);
end

ids = unique(id);

arrays = struct();
for i = 1 : length(ids)
  arrays.(strrep(ids{i}, '"', '')) = sortrows(daysx(strcmp(id, ids{i}), :));
end
end
