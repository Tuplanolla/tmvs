% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_fetchall (@var{pat}, @var{src}, @var{varargin})
%
% Fetches and merges together the files matching the pattern @var{pat} and
% produces the aggregate @var{aggr}.
% Mention: @var{src} and @var{varargin}.
% The pattern @var{pat} can be written
% according the format supported by @code{glob}.
%
% @seealso{tmvs, tmvs_fetch, tmvs_merge, glob}
%
% @end deftypefn

function aggr = tmvs_fetchall (pat, src, varargin)

f = @(fname) tmvs_fetch (fname, src, varargin{:});
aggr = tmvs_merge (mapl (f, glob (pat)){:});

end
