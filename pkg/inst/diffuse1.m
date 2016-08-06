% -*- texinfo -*-
% @deftypefn {Function File} {[@var{qn}, @var{tn}, @var{xn}] =} diffuse1 (@var{q0}, @var{q}, @var{C}, @var{B}, @var{rt}, @var{rx}, @var{nt}, @var{nx}, @var{dt}, @var{dx})
%
% Simulates a diffusion process inside a wall or floor.
% Note: time is given in days.
% Note: cprho = cp * rho.
% Note: k = U / L.
% Note: Dt = t / nt.
%
% The following examples demonstrate basic usage.
%
% @example
% @code{false}
% @result{} false
% @end example
%
% @seealso{tmvs}
%
% @end deftypefn

function [qn, tn, xn] = diffuse1 (q0, q, ...
  C = @(x) 1 + 0 * x, B = @(x) 1 + 0 * x, ...
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
  t = interp1 ([1, kt], rt, ik, '*linear');

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

% TODO Write an example using real data and get rid of this shit.

% rt = [0, 100];
% rx = [0, 500] * 1e-3;
% C = @(x) interp1 (rx, [24, 16], x, 'linear');
% B = @(x) interp1 (rx, [100, 10] * 1e-3, x, 'nearest');
% q0 = @(x) interp1 (rx, [260, 280], x, 'linear');
% q = @(t, x) [260 + 20 * (sin (t / 20)), nan * x(2 : end - 1), 280];
% [qn, tn, xn] = diffuse1 (q0, q, C, B, rt, rx, 100, 10, 10, 1);
% plota (10, xn, qn);

%!error
%! diffuse1 ();
