% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs_csv (@var{str})
%
% Parses the string @var{str} containing a comma-separated value record
% with the delimiter @qcode{'|'} and produces the cell array @var{c}.
% The formal grammar is presented in the file @qcode{'CSV.g4'}.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_csv ('one|number two|"magic ""number"" three"')}
% @result{} @{'one', 'number two', 'magic ""number"" three'@}
% @code{tmvs_csv ('one|||number two|')}
% @result{} @{'one', @{@}, @{@}, 'number two', @{@}@}
% @end example
%
% @seealso{tmvs_parse, textscan, regexp}
% @end deftypefn

function c = tmvs_csv (str)

pat = '"((?:""|[^"])*)"|([^\n\r|"]+)?';

[~, ~, ~, ~, t] = regexp (str, pat, 'emptymatch');
if isempty (t)
  error (sprintf ('malformed record ''%s''', str));
end

% These bounds are too optimistic when empty matches are present,
% but the resulting cell array can adapt to them by expanding.
% The performance hit incurred by the expansion should be negligible too.
n = length (t);
c = cell (floor ((n + 1) / 2), 1);

j = 1;
wasempty = false;
for i = 1 : n
  matches = t{i};
  if isempty (matches)
    if wasempty
      c{j} = matches;
      j = j + 1;
    end
    wasempty = true;
  else
    c{j} = matches{1};
    j = j + 1;
    wasempty = false;
  end
end

end
