% -*- texinfo -*-
% @deftypefn  {Function File} {@var{c} =} nchoosek (@var{n}, @var{k})
% @deftypefnx {Function File} {@var{c} =} nchoosek (@var{set}, @var{k})
%
% Compute the binomial coefficient of @var{n} or list all possible
% combinations of a @var{set} of items.
%
% If @var{n} is a scalar then calculate the binomial coefficient
% of @var{n} and @var{k} which is defined as
% @tex
% $$
%  {n \choose k} = {n (n-1) (n-2) \cdots (n-k+1) \over k!}
%                = {n! \over k! (n-k)!}
% $$
% @end tex
% @ifnottex
%
% @example
% @group
%  /   \
%  | n |    n (n-1) (n-2) @dots{} (n-k+1)       n!
%  |   |  = ------------------------- =  ---------
%  | k |               k!                k! (n-k)!
%  \   /
% @end group
% @end example
%
% @end ifnottex
% @noindent
% This is the number of combinations of @var{n} items taken in groups of
% size @var{k}.
%
% If the first argument is a vector, @var{set}, then generate all
% combinations of the elements of @var{set}, taken @var{k} at a time, with
% one row per combination.  The result @var{c} has @var{k} columns and
% @w{@code{nchoosek (length (@var{set}), @var{k})}} rows.
%
% For example:
%
% How many ways can three items be grouped into pairs?
%
% @example
% @group
% nchoosek (3, 2)
%    @result{} 3
% @end group
% @end example
%
% What are the possible pairs?
%
% @example
% @group
% nchoosek (1:3, 2)
%    @result{}  1   2
%        1   3
%        2   3
% @end group
% @end example
%
% Programming Note: When calculating the binomial coefficient @code{nchoosek}
% works only for non-negative, integer arguments.  Use @code{bincoeff} for
% non-integer and negative scalar arguments, or for computing many binomial
% coefficients at once with vector inputs for @var{n} or @var{k}.
%
% @seealso{bincoeff, perms}
% @end deftypefn
function tmvs_store(cachename, arrays, format = '-mat', zip = true)
tmvs = arrays;

if zip
  save(format, '-zip', cachename, 'tmvs');
else
  save(format, cachename, 'tmvs');
end
end
