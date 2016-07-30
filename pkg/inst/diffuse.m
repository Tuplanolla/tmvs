% -*- texinfo -*-
% @deftypefn {Function File} {[@var{qn}, @var{tn}, @var{xn}] =} diffuse (@var{varargin})
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

function [qn, tn, xn] = diffuse (q, ...
  C = @(t, x) 1 + 0 * t * x, ...
  B = @(t, x) 1 + 0 * t * x, ...
  rt = [0, 1], rx = [0, 1], nt = 100, nx = 100, mt = 1, mx = 1)

qn = nan (nt, nx);
tn = linspace (num2cell (rt){:}, nt)';
xn = linspace (num2cell (rx){:}, nx);

kt = mt * nt;
kx = mx * nx;

Dt = diff (rt) / kt;
Dx = diff (rx) / kx;
s = Dt / Dx ^ 2;

xk = xn(1 : mx : end);
qk = q (rt(1), xk);

in = 1;
for ik = 1 : kt
  t = interp1 ([1, kt], rt, ik);

  Ci = C (t, xk);
  Bi = B (t, xk);

  Cij = Ci(2 : end - 1);
  Cijp1 = Ci(3 : end);
  Bijm1 = Bi(1 : end - 2);
  Bij = Bi(2 : end - 1);
  Bijp1 = Bi(3 : end);
  qkjm1 = qk(1 : end - 2);
  qkj = qk(2 : end - 1);
  qkjp1 = qk(3 : end);

  if ~(Bijp1 < 2 * Bij && s < Cij ./ (3 * Bij - Bijp1))
    error ('simulation diverged');
  end

  qk(2 : end - 1) = ...
    (s * Bij .* qkjm1 + ...
     (Cij - s * (3 * Bij - Bijp1)) .* qkj + ...
     s * (2 * Bij - Bijp1) .* qkjp1) ./ Cij;

  qi = q (t, xk);
  p = ~isnan (qi);
  qk(p) = qi(p);

  if mod (ik - 1, mt) == 0
    qn(in, :) = qk(1 : mx : end);

    in = in + 1;
  end
end

end

% TODO Write an example using real data and get rid of this shit.

rt = [0, 100];
rx = [0, 500] * 1e-3;
C = @(t, x) interp1 (rx, [24, 16], x, 'linear');
B = @(t, x) interp1 (rx, [100, 10] * 1e-3, x, 'nearest');
q = @(t, x) ifelse (t == 0, ...
  interp1 (rx, [260 + 20 * (sin (t / 20)), 280], x, 'linear'), ...
  [260 + 20 * (sin (t / 20)), nan * x(2 : end - 1), 280]);
[qn, tn, xn] = diffuse (q, C, B, rt, rx, 100, 10, 10, 1);
plota (10, xn, qn);
