% -*- texinfo -*-
% @deftypefn {Function File} {@var{aggr} =} tmvs_glob (@var{pat}, @var{src})
% @deftypefnx {Function File} {@var{aggr} =} tmvs_glob (@var{pat}, @var{src}, @var{varargin})
%
% Fetches and merges together the files matching the pattern @var{pat} and
% produces the aggregate @var{aggr}.
% The pattern @var{pat} can be written
% according the format supported by @var{glob}.
%
% @seealso{tmvs, tmvs_fetch, tmvs_merge, glob}
%
% @end deftypefn

function aggr = tmvs_glob (pat, src, varargin)

f = @(fname) tmvs_fetch (fname, src, varargin{:});
aggr = tmvs_merge (cellfun (f, glob (pat), 'uniformoutput', false){:});

end
