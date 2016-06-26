% -*- texinfo -*-
% @deftypefn {Function File} {@var{nothing} =} tmvs_store (@var{cachename}, @var{arrays})
% @deftypefnx {Function File} tmvs_store (@var{cachename}, @var{arrays}, @var{format})
% @deftypefnx {Function File} tmvs_store (@var{cachename}, @var{arrays}, @var{format}, @var{zip})
%
% Cache the @var{arrays} data structure on disk,
% into the file denoted by the @var{cachename} filepath.
%
% The optional @var{format} parameter can be chosen
% from the formats supported by @var{save} and
% defaults to the MATLAB compatible @qcode{'-mat'}.
% The other optional @var{zip} parameter determines
% whether the cache file should be compressed and defaults to @var{true}.
%
% The following example is useless.
%
% @example
% @group
% @code{2 + 3}
% @result{} 5
% @end group
% @end example
%
% @seealso{tmvs, tmvs_recall, tmvs_fetch, tmvs_purge}
% @end deftypefn

function tmvs_store (cachename, arrays, format = '-mat', zip = true)

tmvs = arrays;

if zip
  save (format, '-zip', cachename, 'tmvs');
else
  save (format, cachename, 'tmvs');
end

end
