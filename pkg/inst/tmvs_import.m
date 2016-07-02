% -*- texinfo -*-
% @deftypefn {Function File} {@var{a} =} tmvs_import (@var{fname}, @var{src})
% @deftypefnx {Function File} {@var{a} =} tmvs_import (@var{fname}, @var{src}, @var{reg})
%
% Parses the comma-separated value file @var{fname}
% with the delimiter @qcode{'|'} and
% and produces the aggregate @var{a}.
% The record format is expected
% to be appropriate to the data source @var{src} and region @var{reg}.
% A formal grammar for the superstructure
% is presented in the file @qcode{'CSV.g4'}
% with the exception that quoted fields in records may not contain line breaks.
% While the substructure depends on the data source,
% a formal grammar for identification and metadata extraction
% is presented in the file @qcode{'Name.g4'}.
%
% If this procedure takes a long time to complete,
% a progress indicator will appear to entertain the user.
% There are two passes, so the indicator counts up twice.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{a = tmvs_import ('excerpt/2011/120-0.csv', ...
%                  tmvs_source ('test lab'));}
% @code{fieldnames (a)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{size (a)}
% @result{} [1, 11]
% @code{a = tmvs_import ('excerpt/2011-2013-0.csv', ...
%                  tmvs_source ('weather observatory'));}
% @code{fieldnames (a)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{size (a)}
% @result{} [1, 6]
% @end example
%
% Programming note: While the data source could be detected automatically,
% it would require detecting and parsing the header lines or
% making an educated guess based on the first few records.
% This is forgone to keep the parser simple and robust.
%
% @seealso{tmvs, tmvs_fetch, tmvs_source, tmvs_progress, csvread}
%
% @end deftypefn

function a = tmvs_import (fname, src, reg)

n = 100;

y = tmvs_source (src);

[fid, msg] = fopen (fname, 'r');
if fid == -1
  error (sprintf ('failed to open ''%s'' for reading: %s', fname, msg));
end

switch y
case {'test lab', 'weather station'}
  fmt = 'yyyy/mm/dd HH:MM:SS';

  c = cell (0);
  k = nan (0);

  a = struct ('id', {}, 'meta', {}, 'pairs', {});

  i = 1;
  header = true;
  while (str = fgetl (fid)) ~= -1
    try
      csv = tmvs_parsecsv (str);

      j = find (ismember (c, csv{1}));

      [year, month, day, hour, minute, second] = datevec (csv{2}, fmt);
      t = datenum (year, month, day, hour, minute, second);
      if isempty (t)
        error (sprintf ('failed to parse date ''%s''', csv{2}));
      end

      x = str2double (csv{3});

      if isempty (j)
        [id, meta] = tmvs_parsename (csv{1});

        j = tmvs_findid (a, id);

        if j
          a(j).pairs(end + 1, :) = [t, x];

          k(end + 1) = j;
        else
          a(end + 1) = struct ('id', id, 'meta', meta, 'pairs', [t, x]);

          k(end + 1) = length (a);
        end

        c{end + 1} = csv{1};
      else
        a(k(j)).pairs(end + 1, :) = [t, x];
      end

      header = false;

      if n
        tmvs_progress (i, n);

        i = i + 1;
      end
    catch err
      if ~header
        fclose (fid);

        error (sprintf ('failed to parse ''%s'': %s', str, err.message));
      end
    end
  end
case 'weather observatory'
  fmt = 'dd.mm.yy';

  f = @(qty) struct ('source', src, 'quantity', qty, 'region', reg);

  a = struct ('id', {(f (tmvs_quantity ('temperature'))), ...
                     (f (tmvs_quantity ('relative humidity'))), ...
                     (f (tmvs_quantity ('wind speed'))), ...
                     (f (tmvs_quantity ('pressure'))), ...
                     (f (tmvs_quantity ('precipitation'))), ...
                     (f (tmvs_quantity ('solar energy')))}, ...
              'meta', repmat ({(struct ())}, 1, 6), ...
              'pairs', repmat ({[]}, 1, 6));

  i = 1;
  header = true;
  while (str = fgetl (fid)) ~= -1
    try
      csv = tmvs_parsecsv (str);

      [year, month, day, hour, minute, second] = datevec (csv{1}, fmt);
      t = datenum (year, month, day, hour, minute, second);
      if isempty (t)
        error (sprintf ('failed to parse date ''%s''', csv{1}));
      end

      T = str2double (csv{3});
      R = str2double (csv{6});
      % TODO Should this be csv{10} instead?
      v = str2double (csv{8});
      p = str2double (csv{17});
      % TODO Should this be csv{19} or csv{20} instead?
      h = str2double (csv{18});
      % TODO Should this be csv{21} instead?
      E = str2double (csv{22});

      a(1).pairs(end + 1, :) = [t, T];
      a(2).pairs(end + 1, :) = [t, R];
      a(3).pairs(end + 1, :) = [t, v];
      a(4).pairs(end + 1, :) = [t, p];
      a(5).pairs(end + 1, :) = [t, h];
      a(6).pairs(end + 1, :) = [t, E];

      header = false;

      if n
        tmvs_progress (i, n);

        i = i + 1;
      end
    catch err
      if ~header
        fclose (fid);

        error (sprintf ('failed to parse ''%s'': %s', str, err.message));
      end
    end
  end
otherwise
  fclose (fid);

  error (sprintf ('data source ''%s'' not supported', y));
end

[err, msg] = ferror (fid);
if err == -1
  error (sprintf ('failed to read ''%s'': %s', fname, msg));
end

if fclose (fid) == -1
  error (sprintf ('failed to close ''%s''', fname));
end

if ~isempty (a)
  i = 1;
  for j = 1 : length (a)
    [~, k] = unique (a(j).pairs(:, 1));
    a(j).pairs = a(j).pairs(k, :);

    if n
      tmvs_progress (i, n);

      i = i + length (k);
    end
  end
end

end
