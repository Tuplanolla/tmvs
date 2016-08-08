% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_import (@var{fname}, @var{src})
% @deftypefnx {Function File} {@var{aggr} =} tmvs_import (@var{fname}, @var{src}, @var{varargin})
%
% Read a source file into an aggregate without caching.
%
% If you simply want to load data from a file, use @code{tmvs_fetch} instead,
% because it leverages the cache mechanism and is thus faster.
%
% This procedure parses the comma-separated value file @var{fname}
% with the delimiter @qcode{'|'} and produces the aggregate @var{aggr}.
% The structure of the file is expected the follow the regular grammar
% from the ANTLR 4 grammar file @file{CSV.g4}
% with the exception that quoted fields in records may not contain line breaks.
% The structure of the records is expected to be
% suitable for the data source @var{src} and
% any other specifications passed in @var{varargin}.
% A formal grammar for parts of the records is presented
% in the ANTLR 4 grammar file @file{Name.g4}.
%
% The data sources @qcode{'Test Lab'} and @qcode{'Weather Station'}
% allow @var{varargin} to be empty
% while @qcode{'Weather Observatory'}
% requires @var{varargin} to contain the region of the observatory.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_import ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 12]
% @end example
%
% @example
% @code{aggr = tmvs_import ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 5]
% @end example
%
% Programming note: While the data source could be detected automatically,
% it would require detecting and parsing the header lines or
% making an educated guess based on the first few records.
% This is forgone to keep the parser simple and robust.
%
% @seealso{tmvs, tmvs_fetch, tmvs_source, tmvs_region}
%
% @end deftypefn

function aggr = tmvs_import (fname, src, varargin)

[fid, msg] = fopen (fname, 'r');
if fid == -1
  error ('failed to open ''%s'' for reading: %s', fname, msg);
end

switch tmvs_source (src)
case {'Test Lab', 'Weather Station'}
  c = cell (0);
  j = [];

  aggr = struct ('id', {}, 'meta', {}, 'pairs', {});

  header = true;
  while (line = fgetl (fid)) ~= -1
    try
      csv = tmvs_parsecsv (line);

      [year, month, day, ...
       hour, minute, second] = datevec (csv{2}, 'yyyy/mm/dd HH:MM:SS');
      t = datenum (year, month, day, hour, minute, second);
      if isempty (t)
        error ('failed to parse date ''%s''', csv{2});
      end

      k = find (ismember (c, csv{1}));

      if isempty (k)
        [id, meta] = tmvs_parsename (csv{1});

        k = tmvs_findid (aggr, id);

        if ~isindex (k)
          k = numel (aggr) + 1;

          aggr(k) = struct ('id', id, 'meta', meta, 'pairs', nan (0, 2));
        end

        c{end + 1} = csv{1};
        j(end + 1) = k;
      else
        k = j(k);
      end

      switch tmvs_quantity (aggr(k).id.quantity)
      case 'Temperature'
        q = str2double (csv{3});
      case 'Relative Humidity'
        q = str2double (csv{3}) * 1e-2;
      case 'Absolute Humidity'
        q = str2double (csv{3}) * 1e-3;
      case 'Pressure'
        q = str2double (csv{3}) * 100;
      case 'Wind Speed'
        q = str2double (csv{3});
      case 'Precipitation'
        q = str2double (csv{3}) * 1e-3;
      end

      aggr(k).pairs(end + 1, :) = [t, q];

      header = false;
    catch err
      % TODO Should this stop after too many header lines have been skipped?
      if ~header
        fclose (fid);

        error ('failed to parse ''%s'': %s', line, err.message);
      end
    end
  end
case 'Weather Observatory'
  reg = varargin{:};

  f = @(qty) struct ('source', src, 'quantity', qty, 'region', reg);
  c = { ...
    (f (tmvs_quantity ('Temperature'))), ...
    (f (tmvs_quantity ('Relative Humidity'))), ...
    (f (tmvs_quantity ('Pressure'))), ...
    (f (tmvs_quantity ('Wind Speed'))), ...
    (f (tmvs_quantity ('Precipitation')))};
  aggr = struct ( ...
    'id', c, ...
    'meta', repmat ({(struct ())}, size (c)), ...
    'pairs', repmat ({[]}, size (c)));

  header = true;
  while (line = fgetl (fid)) ~= -1
    try
      csv = tmvs_parsecsv (line);

      [year, month, day] = datevec (csv{1}, 'dd.mm.yy');
      t = datenum (year, month, day);
      if isempty (t)
        error ('failed to parse date ''%s''', csv{1});
      end

      T = str2double (csv{3});
      R = str2double (csv{6}) * 1e-2;
      % TODO Should this be @code{csv{10}} instead?
      p = str2double (csv{17}) * 100;
      v = str2double (csv{8});
      % TODO Should this be @code{csv{19}} instead?
      h = str2double (csv{18}) * 1e-3;

      aggr(1).pairs(end + 1, :) = [t, T];
      aggr(2).pairs(end + 1, :) = [t, R];
      aggr(3).pairs(end + 1, :) = [t, p];
      aggr(4).pairs(end + 1, :) = [t, v];
      aggr(5).pairs(end + 1, :) = [t, h];

      header = false;
    catch err
      if ~header
        fclose (fid);

        error ('failed to parse ''%s'': %s', line, err.message);
      end
    end
  end
otherwise
  fclose (fid);

  error ('data source ''%s'' not supported', tmvs_source (src));
end

[err, msg] = ferror (fid);
if err == -1
  error ('failed to read ''%s'': %s', fname, msg);
end

if fclose (fid) == -1
  error ('failed to close ''%s''', fname);
end

if ~isempty (aggr)
  for i = 1 : numel (aggr)
    [~, k] = unique (aggr(i).pairs(:, 1));
    aggr(i).pairs = aggr(i).pairs(k, :);
  end
end

end
