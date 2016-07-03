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

fnames = glob (pat);

aggr = struct ('id', {}, 'meta', {}, 'pairs', {});

for i = 1 : length (fnames)
  aggr = tmvs_merge (aggr, tmvs_fetch (fnames{i}, src, varargin{:}));
end

end
