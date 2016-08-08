% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_fetchall (@var{pat}, @var{src}, @var{varargin})
%
% Read an aggregate from several source files, using cache files by need.
%
% If you want to read just one source file or merge several files by hand,
% try @code{tmvs_fetch} instead.
%
% This procedure reads and merges together
% the source files matching the pattern @var{pat} and
% produces the aggregate @var{aggr}.
% The pattern @var{pat} can be written
% according the format supported by @code{glob}.
% The data source @var{src} and the options in @var{varargin}
% are passed through to @code{tmvs_fetch}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{aggr = tmvs_fetchall ( ...
%   'excerpt/2012/[0-9]*.csv', tmvs_source ('Test Lab'));}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 175]
% @end example
%
% @example
% @code{aggr = tmvs_fetchall ( ...
%   'excerpt/*.csv', ...
%   tmvs_source ('Weather Observatory'), tmvs_region ('Jyvaskyla'));}
% @code{fieldnames (aggr)}
% @result{} @{'id', 'meta', 'pairs'@}(:)
% @code{size (aggr)}
% @result{} [1, 5]
% @end example
%
% @seealso{tmvs, tmvs_fetch, tmvs_merge, glob}
%
% @end deftypefn

function aggr = tmvs_fetchall (pat, src, varargin)

f = @(fname) tmvs_fetch (fname, src, varargin{:});
aggr = tmvs_merge (mapl (f, glob (pat)){:});

end
