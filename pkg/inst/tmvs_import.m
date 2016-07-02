% -*- texinfo -*-
% @deftypefn {Function File} {@var{a} =} tmvs_import (@var{src}, @var{fname})
% @deftypefnx {Function File} {@var{a} =} tmvs_import (@var{src}, @var{fname}, @var{n})
%
% Parses the comma-separated value file @var{fname}
% with the delimiter @qcode{'|'} and
% the format appropriate to the data source @var{src}
% and produces the aggregate @var{a}.
% A formal grammar for the superstructure
% is presented in the file @qcode{'CSV.g4'}
% with the exception that quoted fields in records may not contain line breaks.
% While the substructure depends on the data source,
% a formal grammar for identification and metadata extraction
% is presented in the file @qcode{'Name.g4'}.
%
% When the optional parameter @var{n} is nonzero,
% a progress indicator will appear to entertain the user and
% update each time @var{n} records have been processed.
% There are two passes, so the indicator counts up twice.
%
% The following example demonstrates basic usage.
%
% @example
% @code{a = tmvs_import (tmvs_source ('test lab'), 'excerpt/2011/120-0.csv');}
% @code{fieldnames (a)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{size (a)}
% @result{} [1, 11]
% @end example
%
% Programming note: While the data source could be detected automatically,
% it would require detecting and parsing the header lines or
% making an educated guess based on the first few records.
% This is forgone to keep the parser simple and robust.
%
% @seealso{tmvs, tmvs_fetch, tmvs_source, tmvs_progress, csvread}
% @end deftypefn

function a = tmvs_import (src, fname, n = 100)

[fid, msg] = fopen (fname, 'r');
if fid == -1
  error (sprintf ('failed to open ''%s'' for reading: %s', fname, msg));
end

switch src
case {(tmvs_source ('test lab')), (tmvs_source ('weather station'))}
  persistent fmt
  if isempty (fmt)
    fmt = 'yyyy/mm/dd HH:MM:SS';
  end

  a = struct ('id', {}, 'meta', {}, 'pairs', {});

  k = 1;
  csv1 = cell (0);
  j = nan (0);
  header = true;
  while (str = fgetl (fid)) ~= -1
    csv = tmvs_parsecsv (str);

    try
      k = find (ismember (csv1, csv{1}));

      [year, month, day, hour, minute, second] = datevec (csv{2}, fmt);
      t = datenum (year, month, day, hour, minute, second);

      x = str2double (csv{3});

      if isempty (k)
        % Note: every id MUST HAVE same meta or one meta is lost.
        [id, meta] = tmvs_parsename (csv{1});

        z = 1;
        new = true;
        for z = 1 : length (a)
          if isequaln (a(z).id, id)
            new = false;

            break
          end
        end

        if new
          a(end + 1) = struct ('id', id, 'meta', meta, 'pairs', [t, x]);
        else
          a(z).pairs(end + 1, :) = [t, x];
        end

        csv1{end + 1} = csv{1};
        j(end + 1) = z;
      else
        a(j(k)).pairs(end + 1, :) = [t, x];
      end

      header = false;

      if n
        tmvs_progress (k, n);

        k = k + 1;
      end
    catch err
      if ~header
        error (sprintf ('failed to parse ''%s'': %s', str, err.message));
      end
    end
  end
otherwise
  error (sprintf ('unsupported source %d', src));
end

[err, msg] = ferror (fid);
if err == -1
  error (sprintf ('failed to read ''%s'': %s', fname, msg));
end

if fclose (fid) == -1
  error (sprintf ('failed to close ''%s''', fname));
end

k = 1;
for i = 1 : length (a)
  [y, j] = unique (a(i).pairs(:, 1));
  a(i).pairs = a(i).pairs(j, :);

  if n
    tmvs_progress (k, n);

    k = k + length (j);
  end
end

end
