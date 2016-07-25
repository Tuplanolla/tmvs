% -*- texinfo -*-
% @deftypefn {Function File} {[@var{y}, @var{T}] =} tmvs_simulate (@var{x})
%
% Simulates a heat-and-moisture process inside a wall?
% Note: time is given in days.
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

function [y, T] = tmvs_simulate (U, L, c_p, rho, t, n)

warning ('this is unreliable');

% Assumed US7.
U = 160e-3;
L = 240e-3;
c_p = 1.4e+3; % Some approximates: EPS: 1.4e+3, PUR: 1.8e+3, MW: 840e+3.
rho = 20e-3; % Some approximates: EPS: 20e-3, PUR: 0.1e-3, MW: 50e-3.
t = 0.1;
n = 1e+6;

t = 24 * 60 * 60 * t;
Delta_t = t / n;
a = 0;
b = L;
c = 1 / 4;
k = U / L;
alpha = k / (c_p * rho);
Delta_y = sqrt (alpha * Delta_t / rho);
C = [c, 1 - 2 * c, c];

y = linspace (a, b);
T = y > mean ([a, b]);

figure (1);
clf ();
h = plot (y, T);
axis ([a, b, (min (T)), (max (T))]);

for i = 1 : n
  T0 = T;
  t0 = t * i / n;

  T = conv (T, C, 'same');

  % T(end) = 1;
  omega = 0.1;
  T(end) = cos (omega * t0 / 2) ^ 2;

  if mod (i, 100) == 0
    set (h, 'YData', T);
    sleep (0.1);
  end
end

end
