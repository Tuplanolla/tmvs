% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_merge (@var{varargin})
%
% Combines the aggregates @var{varargin} into the single aggregate @var{aggr}.
%
% If you simply want to load data from several files,
% use @code{tmvs_fetchall} instead.
% This procedure does not read files byitself and is thus quite inconvenient.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr1 = tmvs_import ('excerpt/2011/120-0.csv', ...
%                      tmvs_source ('test lab'));
% aggr2 = tmvs_import ('excerpt/2011-2013-0.csv', ...
%                      tmvs_source ('weather observatory'), ...
%                      tmvs_region ('jyvaskyla'));}
% @code{aggr = tmvs_merge (aggr1, aggr2);}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}
% @code{size (aggr)}
% @result{} [1, 17]
% @end example
%
% @seealso{tmvs, tmvs_fetch, tmvs_fetchall}
%
% @end deftypefn

function aggr = tmvs_merge (varargin)

aggr = struct ('id', {}, 'meta', {}, 'pairs', {});

for i = 1 : numel (varargin)
  aggri = varargin{i};

  for j = 1 : numel (aggri)
    id = aggri(j).id;

    k = tmvs_findid (aggr, id);

    if k
      aggr(k).pairs = [aggr(k).pairs; aggri(j).pairs];
    else
      aggr(end + 1) = struct ('id', id, ...
                              'meta', aggri(j).meta, ...
                              'pairs', aggri(j).pairs);
    end
  end
end

for i = 1 : numel (aggr)
  [~, k] = unique (aggr(i).pairs(:, 1));
  aggr(i).pairs = aggr(i).pairs(k, :);
end

end
