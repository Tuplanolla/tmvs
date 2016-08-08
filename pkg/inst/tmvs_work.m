% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_work (@var{dname})
%
% Read an aggregate from several source files in a certain arrangement.
%
% This procedure reads every source file
% in the sample data set and merges them together.
%
% The following example demonstrates basic usage.
%
% @example
% @code{aggr = tmvs_work ('excerpt');}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 205]
% @end example
%
% @seealso{tmvs, tmvs_fetchall, tmvs_merge}
%
% @end deftypefn

function aggr = tmvs_work (dname)

if ~isdir (dname)
  error ('not a directory ''%s''', dname);
end

labs = tmvs_fetchall ( ...
  sprintf ('%s/*/[0-9]*.csv', dname), tmvs_source ('Test Lab'));

stations = tmvs_fetchall ( ...
  sprintf ('%s/*/[a-z]*.csv', dname), tmvs_source ('Weather Station'));

observatories = tmvs_fetchall ( ...
  sprintf ('%s/*.csv', dname), ...
  tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));

aggr = tmvs_merge (labs, stations, observatories);

end
