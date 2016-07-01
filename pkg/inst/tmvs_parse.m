% -*- texinfo -*-
% @deftypefn {Function File} {@var{cds} =} tmvs_parse (@var{src}, @var{fname})
%
% Parses the comma-separated value file @var{fname}
% with the delimiter @qcode{'|'} and
% produces the central data structure @var{cds}.
% The formal grammar is presented in the file @code{CSV.g4}
% with the exception that records may not contain quoted line breaks.
% The file should be formatted as expected of the data source @var{src}.
%
% While the data source could be detected automatically,
% it would require detecting and parsing the header lines or
% making an educated guess based on the first few records.
% This is forgone to keep the parser simple and robust.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_parse ('excerpt/2011/118-0.csv')}
% @end example
%
% @seealso{tmvs, tmvs_fetch, tmvs_csv}
% @end deftypefn

function cds = tmvs_parse (src, fname)

% TODO All sources.
if src ~= tmvs_source ('test lab') && src ~= tmvs_source ('weather station')
  error (sprintf ('unsupported source %d', src));
end

fid = fopen (fname, 'r');
if fid == -1
  error (sprintf ('failed to open ''%s'' for reading', fname));
end

cds = struct ('hash', {}, 'id', {}, 'pairs', {});

i = 1;
washeader = true;
while (str = fgetl (fid)) ~= -1
  csv = tmvs_csv (str);

  try
    id = tmvs_id (csv{1});

    [year, month, day, hour, minute, second] = ...
      datevec (csv{2}, 'yyyy/mm/dd HH:MM:SS');
    t = datenum (year, month, day, hour, minute, second);

    x = str2double (csv{3});

    washeader = false;

    cds = tmvs_insert (cds, id, horzcat (t, x));

    tmvs_progress (i, 100);

    i = i + 1;
  catch e
    if ~washeader
      error (sprintf ('failed to parse ''%s'': %s', str, e.message));
    end
  end
end

[err, msg] = ferror (fid);
if err == -1
  error (sprintf ('failed to read ''%s'': %s', fname, msg));
end

if fclose (fid) == -1
  error (sprintf ('failed to close ''%s''', fname));
end

end
