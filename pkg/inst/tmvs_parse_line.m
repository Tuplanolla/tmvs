function s = tmvs_parse_line (str)

csv = tmvs_csv (str);

id = tmvs_id (csv{1});

fmt = 'yyyy/mm/dd HH:MM:SS';
[year, month, day, hour, minute, second] = datevec (csv{2}, fmt);
days = datenum (year, month, day, hour, minute, second);

value = str2double (csv{3});

s = struct ('id', id, 'days', days, 'value', value);

end
