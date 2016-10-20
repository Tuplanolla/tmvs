% -*- texinfo -*-
% @deftypefn {Function File} {[@var{qn}, @var{tn}, @var{xn}] =} diffuse1 (@var{q0}, @var{q})
% @deftypefnx {Function File} {[@var{qn}, @var{tn}, @var{xn}] =} diffuse1 (@var{q0}, @var{q}, @var{B})
% @deftypefnx {Function File} {[@var{qn}, @var{tn}, @var{xn}] =} diffuse1 (@var{q0}, @var{q}, @var{B}, @var{C})
% @deftypefnx {Function File} {[@var{qn}, @var{tn}, @var{xn}] =} diffuse1 (@var{q0}, @var{q}, @var{B}, @var{C}, @var{rt}, @var{rx})
% @deftypefnx {Function File} {[@var{qn}, @var{tn}, @var{xn}] =} diffuse1 (@var{q0}, @var{q}, @var{B}, @var{C}, @var{rt}, @var{rx}, @var{nt}, @var{nx})
% @deftypefnx {Function File} {[@var{qn}, @var{tn}, @var{xn}] =} diffuse1 (@var{q0}, @var{q}, @var{B}, @var{C}, @var{rt}, @var{rx}, @var{nt}, @var{nx}, @var{dt}, @var{dx})
%
% Simulate a one-dimensional diffusion process.
%
% Assuming @var{C} and @var{B} are known position-dependent functions and
% @var{q} is the unknown position-dependent and time-dependent function,
% this function uses the finite difference method
% to solve the one-dimensional diffusion equation
%
% @tex
% $$
% \eqalign{C \partial_t q & = \partial_x (B \partial_x q).}
% $$
% @end tex
% @ifnottex
% @example
% C  d_t  (q)  =  d_x  (B  d_x  (q)).
% @end example
% @end ifnottex
%
% The simulation discretizes the position interval @var{rx} and
% the calculates the timespan from the time interval @var{rt}.
% Initial conditions are applied by calling @var{q0} once and
% forcing the whole space to the returned values.
% Boundary conditions are applied by calling @var{q} on every iteration and
% only forcing those parts of the space to the returned values
% for which the returned values are not @code{nan}.
%
% The solution is saved into the matrix @var{qn} with
% @var{nt} rows for the points in time @var{tn} and
% @var{nx} columns for positions @var{xn}.
%
% Since the solver may temporarily require more time or space to not diverge,
% @var{dt} and @var{dx} control the densities (or multiplicities)
% of the temporary numbers of rows and columns.
% If, for instance, @var{B} is almost discontinuous,
% increasing @var{dx} will help tremendously.
%
% This solver is useful for, say, approximating temperature transfer
% inside a planar hetergenous object such as a wall or a floor.
%
% See @code{tmvs} for complete examples.
%
% Programming note: Time is measured in days,
% as is common with @code{datenum} and other such functions.
%
% @seealso{tmvs}
%
% @end deftypefn

function [qn, tn, xn] = diffuse1 (q0, q, ...
  B = @(x) 1 + 0 * x, C = @(x) 1 + 0 * x, ...
  rt = [0, 1], rx = [0, 1], nt = 100, nx = 100, dt = 1, dx = 1)

qn = nan (nt, nx);
tn = linspace (num2cell (rt){:}, nt)';
xn = linspace (num2cell (rx){:}, nx);

kt = dt * nt;
kx = dx * nx;

Dt = diff (rt) / kt;
Dx = diff (rx) / kx;
s = Dt / Dx ^ 2;

xk = linspace (num2cell (rx){:}, kx);

Ci = C (xk);
Bi = B (xk);

Cij = Ci(2 : end - 1);
Cijp1 = Ci(3 : end);
Bijm1 = Bi(1 : end - 2);
Bij = Bi(2 : end - 1);
Bijp1 = Bi(3 : end);

if ~(Bijp1 < 2 * Bij && s < Cij ./ (3 * Bij - Bijp1))
  error ('simulation is divergent');
end

qk = q0 (xk);

in = 1;
for ik = 1 : kt
  % This is equivalent to @code{t = interp1 ([1, kt], rt, ik, 'linear')}.
  t = rt(1) + (rt(2) - rt(1)) * (ik - 1) / (kt - 1);

  qk(2 : end - 1) = ...
    (s * Bij .* qk(1 : end - 2) + ...
     (Cij - s * (3 * Bij - Bijp1)) .* qk(2 : end - 1) + ...
     s * (2 * Bij - Bijp1) .* qk(3 : end)) ./ Cij;

  qt = q (t, xk);
  p = ~isnan (qt);
  qk(p) = qt(p);

  if mod (ik - 1, dt) == 0
    qn(in, :) = qk(1 : dx : end);

    in = in + 1;
  end
end

end

%!error
%! diffuse1 ();
