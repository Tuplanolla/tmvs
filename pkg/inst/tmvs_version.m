% -*- texinfo -*-
% @deftypefn {Function File} {@var{v} =} tmvs_version ()
%
% Returns the version number vector @var{v} of the project.
% This is primarily used to determine cache compatibility.
%
% The following example is obvious.
%
% @example
% @code{tmvs_version ()}
% @result{} [1, 0, 0]
% @end example
%
% @seealso{tmvs}
%
% @end deftypefn

function v = tmvs_version ()

v = [1, 0, 0];

end
