% -*- texinfo -*-
% @deftypefn {Function File} {[@var{i}, @var{o}] =} chauvenet (@var{v})
% @deftypefnx {Function File} {[@var{i}, @var{o}] =} chauvenet (@var{v}, @var{mu})
% @deftypefnx {Function File} {[@var{i}, @var{o}] =} chauvenet (@var{v}, @var{mu}, @var{sigma})
%
% Remove outliers with Chauvenet's criterion.
%
% Chauvenet's criterion separates the outliers @var{o} from the inliers @var{i}
% in the normally distributed data set @var{v}.
% If known, the mean @var{mu} and the standard deviation @var{sigma}
% of the data set can be supplied as extra arguments.
%
% The data set @var{v} must be an array and
% its population or sample mean and standard deviation
% must be @var{mu} and @var{sigma} respectively.
% If these conditions are met,
% the resulting @var{i} and @var{o} will be the indices of
% the inliers and the outliers respectively,
% satisfying @code{union (i, o) == [1 : numel (v)]} and
% @code{intersect (i, o) == []}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{v = [4, 2, 1024, 0, 1];}
% @code{[i, o] = chauvenet (v)}
% @result{} i = [1, 2, 4, 5]
% @result{} o = [3]
% @code{v(chauvenet (v))}
% @result{} [4, 2, 0, 1]
% @end example
%
% Working with matrices requires picking the interesting row or column first.
%
% @example
% @code{m = [2, 4; 1, 2; 10, 1024; -1, 0; 0, 1];}
% @code{m(chauvenet (m(:, 2)), :)}
% @result{} [2, 4; 1, 2; -1, 0; 0, 1]
% @end example
%
% With the probability density function P and
% the cumulative distribution function C,
% the threshold probability
%
% @tex
% $$
% \eqalign{p
% & = 1 - \int_{\mu - |x - \mu|}^{\mu + |x - \mu|} {\rm d} t P_\mu^\sigma(t) \cr
% & = \int_{-\infty}^{\mu - |x - \mu|} {\rm d} t P_\mu^\sigma(t)
% + \int_{\mu + |x - \mu|}^\infty {\rm d} t P_\mu^\sigma(t) \cr
% & = 2 \int_{-\infty}^{\mu - |x - \mu|} {\rm d} t P_\mu^\sigma(t) \cr
% & = 2 C_\mu^\sigma(\mu - |x - \mu|) \cr
% & = 2 C_0^1\Bigl(-{|x - \mu| \over \sigma}\Bigr).}
% $$
% @end tex
% @ifnottex
% @example
%             / mu + |x - mu|
%             |       sigma
% p  =  1  -  |  dt  P (t)
%             |       mu
%             / mu - |x - mu|
%
%       / mu - |x - mu|   / infty
%       |       sigma     |       sigma
%    =  |  dt  P  (t)  +  |  dt  P  (t)
%       |       mu        |       mu
%       / -infty          / mu + |x - mu|
%
%          / mu - |x - mu|
%          |       sigma
%    =  2  |  dt  P  (t)
%          |       mu
%          / -infty
%
%           sigma
%    =  2  C  (mu  -  |x  -  mu|)
%           mu
%
%           1 /    |x  -  mu| \
%    =  2  C  | -  ---------- | .
%           0 \      sigma    /
% @end example
% @end ifnottex
%
% @end deftypefn

function [i, o] = chauvenet (v, mu = mean (v), sigma = std (v))

if ~isvector (v)
  error ('wrong shape %dx%d', size (v));
end

if sigma == 0
  i = ones (size (v));
  o = [];
else
  n = numel (v);

  if iscolumn (v)
    i = nan (n, 1);
    o = nan (n, 1);
  else
    i = nan (1, n);
    o = nan (1, n);
  end

  p = 2 * n * normcdf (-abs (v - mu) / sigma);

  k = 0;
  for j = 1 : n
    if p(j) < 0.5
      o(j - k) = j;
    else
      k = k + 1;
      i(k) = j;
    end
  end

  if iscolumn (v)
    i = resize (i, k, 1);
    o = resize (o, j - k, 1);
  else
    i = resize (i, 1, k);
    o = resize (o, 1, j - k);
  end
end

end

%!shared u, v
%! u = [2, 1, 10, -1, 0];
%! v = [4, 2, 1024, 0, 1];

%!test
% [i, o] = chauvenet (u);
% assert (i, [1, 2, 4, 5]);
% assert (o, [3]);
%!test
% [i, o] = chauvenet (u');
% assert (i, [1; 2; 4; 5]);
% assert (o, [3]);

%!test
% [i, o] = chauvenet (v);
% assert (i, [1, 2, 3, 4, 5]);
% assert (o, []);
%!test
% [i, o] = chauvenet (v');
% assert (i, [1; 2; 3; 4; 5]);
% assert (o, []);
