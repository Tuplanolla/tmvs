% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_merge (@var{varargin})
%
% Combine zero or more aggregates.
%
% If you are loading data from several files and merging them by hand,
% consider using @code{tmvs_fetchall} instead.
%
% This function merges the aggregates in @var{varargin}
% into the single aggregate @var{aggr}.
% Since aggregates are essentially unordered maps,
% they form a monoid with this function as the associative binary operator and
% the empty aggregate as the identity element.
% If common identifiers do not contain conflicting data points
% (that is, there are never two different values for the same point in time),
% the monoid is also commutative.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tlaggr = tmvs_fetch ( ...
%   'excerpt/2012/118-0.csv', tmvs_source ('Test Lab'));
% woaggr = tmvs_fetch ( ...
%   'excerpt/2011-2013-0.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));
% aggr = tmvs_merge (tlaggr, woaggr);}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 17]
% @end example
%
% @example
% @code{aggr = tmvs_merge ();}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [0, 0]
% @end example
%
% @seealso{tmvs, tmvs_fetch}
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
      aggr(end + 1) = struct ( ...
        'id', id, 'meta', aggri(j).meta, 'pairs', aggri(j).pairs);
    end
  end
end

for i = 1 : numel (aggr)
  [~, k] = unique (aggr(i).pairs(:, 1));
  aggr(i).pairs = aggr(i).pairs(k, :);
end

end
