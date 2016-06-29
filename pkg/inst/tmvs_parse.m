% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs_parse (@var{fname}, @var{source})
%
% Parses the comma-separated value file @var{fname}
% with the delimiter @qcode{'|'}.
% The formal grammar is presented in the file @code{CSV.g4}
% with the exception that records may not contain quoted line breaks.
% The file should be formatted as expected of the data source @var{source}.
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

function c = tmvs_parse (fname)

fid = fopen (fname, 'r');
if fid == -1
  error (sprintf ('failed to open ''%s'' for reading', fname));
end

% TODO This is silly.
strs = cell ();
pairs = nan (1, 2);

i = 1;
washeader = true;
while (str = fgetl (fid)) ~= -1
  csv = tmvs_csv (str);

  try
    % TODO Identification should happen here.

    [year, month, day, hour, minute, second] = ...
      datevec (csv{2}, 'yyyy/mm/dd HH:MM:SS');
    days = datenum (year, month, day, hour, minute, second);

    value = str2double (csv{3});

    washeader = false;

    strs{i} = csv{1};
    pairs(i, 1) = days;
    pairs(i, 2) = value;

    tmvs_progress (i, 1000);

    i = i + 1;
  catch e
    if ~washeader
      error (sprintf ('malformed record ''%s'': %s', str, e.message));
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

ustrs = unique (strs);

c = cell ();

for i = 1 : length (ustrs)
  % j = cellfun (@(id) isequaln (id, uids{i}), ids);
  j = strcmp (strs, ustrs{i});

  tmvs_progress (i, 1000);

  c{i, 1} = tmvs_identify (ustrs{i});
  c{i, 2} = sortrows (pairs(j, :), 1);
end

end
