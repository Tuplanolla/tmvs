% -*- texinfo -*-
% @deftypefn {Function File} {} progress (@var{i})
% @deftypefnx {Function File} {} progress (@var{i}, @var{n})
% @deftypefnx {Function File} {} progress (@var{i}, @var{n}, @var{fid})
% @deftypefnx {Function File} {} progress ()
%
% When called in a loop with the index @var{i},
% prints a progress indicator to the file @var{fid} every @var{n} iterations.
% By default @var{n} is @code{1} and @var{fid} is @code{stdout}.
% Without any arguments simply prints an empty line.
%
% Printing is first triggered on @code{0} and then on @var{n},
% so that very short loops that start from @code{1} do not print anything.
% Since printed lines are terminated by @qcode{"\r"} instead of @qcode{"\n"},
% the progress indicator will disappear
% if something is later printed on the same line.
% To clear the line and keep the indicator visible,
% place a call without any arguments at the end of the loop.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{for i = 1 : 5
%   sleep (1);
%   progress (i);
% end}
% @code{for i = 1 : 50
%   sleep (0.1);
%   progress (i);
% end
% progress ();}
% @end example
%
% @seealso{fprintf, fflush}
%
% @end deftypefn

function progress (i, n = 1, fid = stdout)

if nargin == 0
  fprintf (fid, '\n');
elseif mod (i, n) == 0
  switch mod (i / n, 4)
  case 0
    c = '|';
  case 1
    c = '/';
  case 2
    c = '-';
  case 3
    c = '\';
  otherwise
    c = '+';
  end
  fprintf (fid, '%c %d\r', c, i);
  fflush (fid);
end

end

%!test
%! progress ();

%!test
%! progress (1, 2);
