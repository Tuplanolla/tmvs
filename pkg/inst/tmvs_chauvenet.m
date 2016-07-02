% -*- texinfo -*-
% @deftypefn {Function File} {[@var{i}, @var{o}] =} tmvs_chauvenet (@var{x})
% @deftypefnx {Function File} {[@var{i}, @var{o}] =} tmvs_chauvenet (@var{x}, @var{mu})
% @deftypefnx {Function File} {[@var{i}, @var{o}] =} tmvs_chauvenet (@var{x}, @var{mu}, @var{sigma})
%
% Chauvenet's criterion separates the outliers @var{o} from the inliers @var{i}
% in the normally distributed data set @var{x}.
% If known, the mean @var{mu} and the standard deviation @var{sigma}
% of the data set can be supplied as extra arguments.
%
% The data set @var{x} must be a vector and
% its population or sample mean and standard deviation
% must be @var{mu} and @var{sigma} respectively.
% If these conditions are met,
% the resulting @var{i} and @var{o} will be the indices of
% the inliers and the outliers respectively,
% satisfying @code{union (i, o) == [1 : length (x)]} and
% @code{intersect (i, o) == []}.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{x = [4, 2, 1024, 0, 1];}
% @code{[i, o] = tmvs_chauvenet (x)}
% @result{} i = [1, 2, 4, 5]
%    o = [3]
% @code{x(tmvs_chauvenet (x))}
% @result{} [4, 2, 0, 1]
% @end example
%
% Working with matrices requires picking the interesting row or column first.
%
% @example
% @code{x = [2, 4; 1, 2; 10, 1024; -1, 0; 0, 1];}
% @code{x(tmvs_chauvenet (x(:, 2)), :)}
% @result{} [2, 4; 1, 2; -1, 0; 0, 1]
% @end example
%
% @end deftypefn

function [i, o] = tmvs_chauvenet (x, mu = mean (x), sigma = std (x))

if ~isvector (x)
  error (sprintf ('wrong shape %dx%d', size (x)));
end

if sigma == 0
  i = ones (size (x));
  o = [];
else
  n = length (x);

  if iscolumn (x)
    i = nan (n, 1);
    o = nan (n, 1);
  else
    i = nan (1, n);
    o = nan (1, n);
  end

  k = 0;
  for j = 1 : n
    p = 2 * n * normcdf (-abs (x(j) - mu) / sigma);
    if p < 0.5
      o(j - k) = j;
    else
      k = k + 1;
      i(k) = j;
    end
  end

  if iscolumn (x)
    i = resize (i, k, 1);
    o = resize (o, j - k, 1);
  else
    i = resize (i, 1, k);
    o = resize (o, 1, j - k);
  end
end

end
