% -*- texinfo -*-
% @deftypefn {Function File} {@var{str} =} tmvs_version ()
%
% Returns the version number string @var{str} of the project.
% This is primarily used to determine cache compatibility.
%
% The following example is obvious.
%
% @example
% @code{tmvs_version ()}
% @result{} '1.0.0'
% @end example
%
% @seealso{tmvs}
% @end deftypefn

function str = tmvs_version ()

str = '1.0.0';

end
