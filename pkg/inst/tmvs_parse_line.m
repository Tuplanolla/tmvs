function [id, meta, t, x] = tmvs_parse_line (csv)

csv = tmvs_csv (str);

[id, meta] = tmvs_parse_name (csv{1});

fmt = 'yyyy/mm/dd HH:MM:SS';
[year, month, day, hour, minute, second] = datevec (csv{2}, fmt);
t = datenum (year, month, day, hour, minute, second);

x = str2double (csv{3});

end
