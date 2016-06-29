% -*- texinfo -*-
% @deftypefn {Function File} {@var{s} =} tmvs_version ()
%
% Returns the version number string @var{s} of the project.
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

function s = tmvs_version ()
s = '1.0.0';
end
