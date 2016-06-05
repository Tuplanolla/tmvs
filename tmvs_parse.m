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

%!test
%! assert(true);
