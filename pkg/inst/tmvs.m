% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs (@var{dname})
%
% TMVS stands for Temperature and Moisture Visualization System.
%
% Look at this space.
%
% The following example demonstrates basic usage.
%
% @example
% @code{
% fname = 'excerpt/2010/118-0.csv';
% cname = '2010-118.tmp';
% parsed = tmvs_parse (fname);
% fname = 'excerpt/2011/118-0.csv';
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
% @seealso{tmvs_parse, tmvs_interpolate, tmvs_discretize, tmvs_merge, tmvs_visualize, tmvs_export, tmvs_store, tmvs_recall, tmvs_fetch, tmvs_purge}
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

buildings = tmvs_glob (sprintf ('%s/*/[0-9]*.csv', fname));
stations = tmvs_glob (sprintf ('%s/*/[a-z]*.csv', fname));
everything = tmvs_merge (buildings, stations);
% observatories = tmvs_glob (sprintf ('%s/*.csv', fname));
% everything = tmvs_foldl (@tmvs_merge, {buildings, stations, observatories});

tmvs_visualize (everything);

end
