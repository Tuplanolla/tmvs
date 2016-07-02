% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs (@var{dname})
%
% TMVS stands for Temperature and Moisture Visualization System and
% is a simple data analysis system.
% It is quite pedestrian
% even though the author has tried to impose some categorical structure on it.
%
% If you are in a hurry or do not enjoy reading technical manuals,
% jump straight to the examples at the end, try them out yourself and
% explore the other procedures listed under 'see also'.
% You can come back here and read the details
% in case something does not seem to make sense.
%
% Look at this space.
%
% The following example demonstrates basic usage.
%
% @example
% @code{
% fname = 'excerpt/2010/120-0.csv';
% cname = '2010-118.tmp';
% parsed = tmvs_import (fname);
% fname = 'excerpt/2011/120-0.csv';
% cname = '2011-118.tmp';
% fetched = tmvs_fetch (fname, cname);
% merged = tmvs_merge (parsed, fetched);
% interpolated = tmvs_interpolate (merged);
% discretized = tmvs_discretize (interpolated);
% tmvs_visualize (discretized);
% }
% @result{} ??
% @end example
%
% This procedure performs the commands shown in the previous example.
%
% @example
% @code{tmvs ('excerpt')}
% @result{} ??
% @end example
%
% @seealso{tmvs_import, tmvs_interpolate, tmvs_discretize, tmvs_merge, tmvs_visualize, tmvs_export, tmvs_store, tmvs_recall, tmvs_fetch, tmvs_purge}
%
% @end deftypefn

function everything = tmvs (dname)

fname = canonicalize_file_name (dname);
if isempty (fname)
  error (sprintf ('no such file or directory ''%s''', dname));
end

if ~isdir (fname)
  error (sprintf ('not a directory ''%s''', fname));
end

buildings = tmvs_glob (tmvs_source ('test lab'), sprintf ('%s/*/[0-9]*.csv', fname));
stations = tmvs_glob (tmvs_source ('weather station'), sprintf ('%s/*/[a-z]*.csv', fname));
% observatories = tmvs_glob (tmvs_source ('weather observatory'), sprintf ('%s/*.csv', fname));
everything = tmvs_foldl (@tmvs_merge, {buildings, stations});

tmvs_visualize (everything);

end
