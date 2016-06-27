% -*- texinfo -*-
% @deftypefn {Function File} {@var{c} =} tmvs_csv (@var{record})
%
% Parses the comma-separated value record @var{record}
% with the delimiter @qcode{'|'}.
% The formal grammar is presented in the file @code{CSV.g4}.
%
% The following example demonstrates basic usage.
%
% @example
% @code{tmvs_csv ('one|number two|"magic ""number"" three"')}
% @result{} @{'one', 'number two', 'magic ""number"" three'@}
% @code{tmvs_csv ('one||')}
% @result{} @{'one', @{@}, @{@}@}
% @end example
%
% @seealso{csvread, dlmread, regexp}
% @end deftypefn

function c = tmvs_csv (record)

pat = '"((?:""|[^"])*)"|([^\n\r|"]+)?';

[~, ~, ~, ~, t] = regexp (record, pat, 'emptymatch')
if isempty (t)
  error (sprintf ('malformed record ''%s''', record));
end

n = length (t);
k = floor ((n + 1) / 2);

% This cell array is too small when empty matches are present,
% but it can expand without incurring a significant performance hit.
c = cell (k, 1);
% TODO This is subtly wrong; see end.
for i = 1 : k
  d = t{2 * i - 1};
  if isempty (d)
    c{i} = d;
  else
    c{i} = d{1};
  end
end

end

% Empty matches cause trouble.
%
% > tmvs_csv ('oh|one||number two|||"magic ""number"" three"|||')
% t =
% {
%   [1,1] =
%   {
%     [1,1] = oh
%   }
%   [1,2] = {}(1x0)
%   [1,3] =
%   {
%     [1,1] = one
%   }
%   [1,4] = {}(1x0)
%   [1,5] = {}(1x0)
%   [1,6] =
%   {
%     [1,1] = number two
%   }
%   [1,7] = {}(1x0)
%   [1,8] = {}(1x0)
%   [1,9] = {}(1x0)
%   [1,10] =
%   {
%     [1,1] = magic ""number"" three
%   }
%   [1,11] = {}(1x0)
%   [1,12] = {}(1x0)
%   [1,13] = {}(1x0)
%   [1,14] = {}(1x0)
% }
%
% One must perform compaction.
%
% {}s In  {}s Out
%     1       0
%     2       1
%     3       2
%     4       3
%    ...     ...
