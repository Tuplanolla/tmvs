% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} globr (@var{pat}, @var{dname})
%
% Find files that match a pattern recursively.
%
% Runs @code{glob} by starting from the directory @var{dname} and
% recursively collecting every match for @var{pat} into @var{c}.
% If @var{dname} is omitted,
% the current working directory @qcode{'.'} is assumed.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{globr ('*.csv', 'excerpt')(1 : 3)}
% @result{} @{'excerpt/2011-2013-0.csv', ...
% @result{}  'excerpt/2010/118-0.csv', ...
% @result{}  'excerpt/2010/120-0.csv'@}
% @end example
%
% @example
% @code{str = cd ('excerpt');
% c = globr ('*.csv');
% cd (str);}
% @code{c(1 : 3)}
% @result{} @{'excerpt/2011-2013-0.csv', ...
% @result{}  'excerpt/2010/118-0.csv', ...
% @result{}  'excerpt/2010/120-0.csv'@}
% @end example
%
% @seealso{glob}
%
% @end deftypefn

function c = globr (pat, dname = '.')

c = glob (strcat (dname, '/', pat));

str = readdir (dname);

for i = 1 : numel (str)
  fname = str{i};

  if ~(strcmp (fname, '.') || strcmp (fname, '..'))
    c = vertcat (c, globr (pat, strcat (dname, '/', fname)));
  end
end

end

%!error
%! globr ();
