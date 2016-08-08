% -*- texinfo -*-
% @deftypefn {Function File} {@var{v} =} tmvs_version ()
%
% Get the version number of TMVS.
%
% This function returns the version number vector @var{v} of TMVS.
% The resulting version number @code{[n, k, m]} is divided into
% the major version number @var{n}, the minor version number @var{k} and
% the revision number @var{m}.
%
% The version number vector is primarily used to determine cache compatibility.
% A cache file is considered compatible
% if both the major and minor version numbers agree;
% the revision numbers do not matter.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_version ()}
% @result{} [1, 0, 0]
% @end example
%
% @seealso{tmvs, tmvs_checkcache, tmvs_store, tmvs_recall, tmvs_purge}
%
% @end deftypefn

function v = tmvs_version ()

v = [1, 0, 0];

end
