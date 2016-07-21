% -*- texinfo -*-
% @deftypefn {Function File} {@var{s} =} modify (@var{f}, @var{s}, @var{str})
%
% Apply the function @var{f}
% to the fields with the name @var{str} in the structure array @var{s}.
% The name stems from the corresponding operation in categorical optics
% (modify or zoom for lenses).
%
% The following examples demonstrate basic usage.
%
% @example
% @code{modify (@@sqrt, ...
%         struct ('one', 1, 'two', 4, 'three', 9), 'two')}
% @result{} struct ('one', 1, 'two', 2, 'three', 9)
% @code{modify (@@sqrt, ...
%         struct ('one', @{1, 1@}, 'two', @{4, 4@}, 'three', @{9, 9@}), ...
%         'two')}
% @result{} struct ('one', @{1, 1@}, 'two', @{2, 2@}, 'three', @{9, 9@})
% @end example
%
% @seealso{mapl, structfun}
%
% @end deftypefn

function s = modify (f, s, str)

s = mapl (@(s) setfield (s, str, f (getfield (s, str))), s);

end

%!shared f
%! f = @(x) -x;


%!test
%! assert (modify (f, struct ('1', {}), '1'), struct ('1', {}));
%!test
%! assert (modify (f, struct ('1', {}), '2'), struct ('1', {}));


%!test
%! assert (modify (f, struct ('1', {-1}, '2', {1}), '1'), ...
%!         struct ('1', {1}, '2', {1}));
%!test
%! assert (modify (f, struct ('1', {-1}, '2', {1}), '2'), ...
%!         struct ('1', {-1}, '2', {-1}));


%!test
%! assert (modify (f, struct ('1', {-2, -1}, '2', {1, 2}), '1'), ...
%!         struct ('1', {2, 1}, '2', {1, 2}));
%!test
%! assert (modify (f, struct ('1', {-2, -1}, '2', {1, 2}), '2'), ...
%!         struct ('1', {-2, -1}, '2', {-1, -2}));

%!test
%! assert (modify (f, struct ('1', {-2; -1}, '2', {1; 2}), '1'), ...
%!         struct ('1', {2; 1}, '2', {1; 2}));
%!test
%! assert (modify (f, struct ('1', {-2; -1}, '2', {1; 2}), '2'), ...
%!         struct ('1', {-2; -1}, '2', {-1; -2}));


%!test
%! assert (modify (f, struct ('1', {-4, -3; -2, -1}, ...
%!                            '2', {1, 2; 3, 4}), '1'), ...
%!         struct ('1', {4, 3; 2, 1}, '2', {1, 2; 3, 4}));
%!test
%! assert (modify (f, struct ('1', {-4, -3; -2, -1}, ...
%!                            '2', {1, 2; 3, 4}), '2'), ...
%!         struct ('1', {-4, -3; -2, -1}, '2', {-1, -2; -3, -4}));
