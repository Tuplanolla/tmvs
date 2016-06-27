function arrays = tmvs_parse (fname)

if (fid = fopen (name, 'r')) == -1
  error (sprintf ('failed to open ''%s''', fname));
end

if (str = fgetl (fid)) == -1
  error (sprintf ('failed to read ''%s''', fname));
end

while (str = fgetl(fid)) ~= -1
  % TODO Still slow and wrong.
  [name, time, value, ~, notes] = ...
    strread(str, '%s %s %f %f %s', 'delimiter', ',');
  [year, month, day, hour, minute, second] = ...
    datevec(time, 'yyyy/mm/dd HH:MM:SS');
  secs = datenum(year, month, day, hour, minute, second);
end

if fclose(fid) == -1
  error (sprintf ('failed to close ''%s''', fname));
end

% See CSV.g4 for the formal grammar.

pat = '"((?:""|[^"])*)"|([^\n\r|"]+)?';

[~, ~, ~, ~, t] = regexp (line, pat, 'emptymatch');
if isempty (t)
  error (sprintf ('malformed data on line %d of ''%s''', 2, fname));
end

n = (length (t) - 1) / 2;
c = cell (n, 1);
for i = 1 : n
  d = t{2 * i + 1};
  if isempty (d)
    c{i} = d;
  else
    c{i} = d{1};
  end
end

[id, date, x, ~, ~] = ...
  textread (fname, '%s %s %f %s %s', 'delimiter', '|', 'headerlines', 1);

n = rows (id);

daysx = [(nan (n, 1)), x];
for i = 1 : n
  [year, month, day, hour, minute, second] = ...
    datevec (strrep (date{i}, '"', ''), 'yyyy/mm/dd HH:MM:SS');
  daysx(i, 1) = datenum (year, month, day, hour, minute, second);
end

ids = unique (id);

arrays = struct ();
for i = 1 : length (ids)
  arrays.(strrep (ids{i}, '"', '')) = sortrows (daysx(strcmp (id, ids{i}), :));
end

end
