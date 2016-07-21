% -*- texinfo -*-
% @deftypefn {Function File} {@var{s} =} tmvs_zoom (@var{f}, @var{s}, @var{str})
%
% Apply the function @var{f}
% to the fields with the name @var{str} in the structure array @var{s}.
% The name stems from the corresponding operation in categorical optics
% (state monad lens).
%
% The following examples demonstrate basic usage.
%
% @example
% @code{tmvs_zoom (@@sqrt, ...
%            struct ('one', 1, 'two', 4, 'three', 9), 'two')}
% @result{} struct ('one', 1, 'two', 2, 'three', 9)
% @code{tmvs_zoom (@@sqrt, ...
%            struct ('one', @{1, 1@}, 'two', @{4, 4@}, 'three', @{9, 9@}), ...
%            'two')}
% @result{} struct ('one', @{1, 1@}, 'two', @{2, 2@}, 'three', @{9, 9@})
% @end example
%
% @seealso{tmvs_mapl, structfun}
%
% @end deftypefn

function s = tmvs_zoom (f, s, str)

s = tmvs_mapl (@(s) setfield (s, str, f (getfield (s, str))), s);

end

%!shared f
%! f = @(x) -x;


%!test
%! assert (tmvs_zoom (f, struct ('1', {}), '1'), struct ('1', {}));
%!test
%! assert (tmvs_zoom (f, struct ('1', {}), '2'), struct ('1', {}));


%!test
%! assert (tmvs_zoom (f, struct ('1', {-1}, '2', {1}), '1'), ...
%!         struct ('1', {1}, '2', {1}));
%!test
%! assert (tmvs_zoom (f, struct ('1', {-1}, '2', {1}), '2'), ...
%!         struct ('1', {-1}, '2', {-1}));


%!test
%! assert (tmvs_zoom (f, struct ('1', {-2, -1}, '2', {1, 2}), '1'), ...
%!         struct ('1', {2, 1}, '2', {1, 2}));
%!test
%! assert (tmvs_zoom (f, struct ('1', {-2, -1}, '2', {1, 2}), '2'), ...
%!         struct ('1', {-2, -1}, '2', {-1, -2}));

%!test
%! assert (tmvs_zoom (f, struct ('1', {-2; -1}, '2', {1; 2}), '1'), ...
%!         struct ('1', {2; 1}, '2', {1; 2}));
%!test
%! assert (tmvs_zoom (f, struct ('1', {-2; -1}, '2', {1; 2}), '2'), ...
%!         struct ('1', {-2; -1}, '2', {-1; -2}));


%!test
%! assert (tmvs_zoom (f, struct ('1', {-4, -3; -2, -1}, ...
%!                               '2', {1, 2; 3, 4}), '1'), ...
%!         struct ('1', {4, 3; 2, 1}, '2', {1, 2; 3, 4}));
%!test
%! assert (tmvs_zoom (f, struct ('1', {-4, -3; -2, -1}, ...
%!                               '2', {1, 2; 3, 4}), '2'), ...
%!         struct ('1', {-4, -3; -2, -1}, '2', {-1, -2; -3, -4}));
