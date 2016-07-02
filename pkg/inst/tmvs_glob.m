% -*- texinfo -*-
% @deftypefn {Function File} {@var{y} =} tmvs_glob (@var{src}, @var{pat})
%
% Fetches and merges together the original files
% matching the pattern @var{pat}.
% The pattern @var{pat} can be written
% according the formats supported by @var{glob}.
%
% @seealso{tmvs, tmvs_fetch, tmvs_merge, glob}
%
% @end deftypefn

function a = tmvs_glob (src, pat)

fnames = glob (pat);

a = struct ('id', {}, 'meta', {}, 'pairs', {});

for i = 1 : length (fnames)
  a = tmvs_merge (a, tmvs_fetch (src, fnames{i}));
end

end
