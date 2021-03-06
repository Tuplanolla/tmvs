% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs_parsecsv (@var{str})
%
% Parse a comma-separated value record into a cell array.
%
% This function parses the string @var{str}
% containing a comma-separated value record
% with the delimiter @qcode{'|'} and produces the cell array @var{c}.
% A formal grammar for the parser
% is presented in the ANTLR 4 grammar file @file{CSV.g4}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_parsecsv ('one|number two|"magic ""number"" three"')}
% @result{} @{'one', 'number two', 'magic ""number"" three'@}
% @end example
%
% @example
% @code{tmvs_parsecsv ('one|||number two|')}
% @result{} @{'one', @{@}, @{@}, 'number two', @{@}@}
% @end example
%
% @seealso{textscan, regexp}
%
% @end deftypefn

function c = tmvs_parsecsv (str)

persistent pat
if isempty (pat)
  value = '([^\n\r|"]+)';
  quote = '"((?:""|[^"])*)"';

  pat = strcat (quote, '|', value, '?');
end

[~, ~, ~, ~, t] = regexp (str, pat, 'emptymatch');
if isempty (t)
  error ('failed to parse record ''%s''', str);
end

% These bounds are too optimistic when empty matches are present,
% but the resulting cell array can adapt to them by expanding.
% The performance hit incurred by the expansion should be negligible too.
n = numel (t);
c = cell (floor ((n + 1) / 2), 1);

j = 1;
empty = false;
for i = 1 : n
  matches = t{i};
  if isempty (matches)
    if empty
      c{j} = matches;
      j = j + 1;
    end
    empty = true;
  else
    c{j} = matches{1};
    j = j + 1;
    empty = false;
  end
end

end
