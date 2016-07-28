% -*- texinfo -*-
% @deftypefn {Function File} {[@var{y}, @var{T}] =} tmvs_simulate (@var{x})
%
% Simulates a heat-and-moisture process inside a wall?
% Note: time is given in days.
% Note: cprho = cp * rho.
% Note: k = U / L.
% Note: Dy = y / ny.
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

function [y, T] = tmvs_simulate (cprho, k, L, t, ny, nt, T0)

warning ('this is unreliable');

% Assume AP5 or US7b.
% cp e+3 - EPS: 1.4, PUR: 1.8, MW: 840
% rho e-3 - EPS: 20, PUR: 0.1, MW: 50
cprho = [40, 28, 34, 42] * 1e+3;
U = [10, 1400, 800, 3400] * 1e-3;
L = [5, 100, 200, 300] * 1e-3;
k = U ./ L;
t = 0.0005;
ny = 1e+2;
nt = 5e+3;
T = ifelse (linspace (0, sum (L), ny) < 105e-3, 270, 300);
A = interp1 ([0, 1], [20e-3, 20e-3], linspace (0, 1, ny));

% Dew density: 20e-3, wool density: 50e-3 => coupling significant!

t = 24 * 60 * 60 * t;
Dy = sum (L) / ny;
Dt = t / nt;

ys = linspace (0, sum (L), ny);
cprhos = interp1 ([0, (sum (L))], cprho, ys, 'nearest');
ks = interp1 ([0, (sum (L))], k, ys, 'nearest');
Ts = (Ts - 270) / 30;
As = A;

if ~(ks(2 : end) < 2 * ks(1 : end - 1))
  error ('thermal conductivity ''k'' too strongly discontinuous');
end

r = Dt / Dy ^ 2;

if ~(r > 0 && r < cprhos(1 : end - 1) ./ (3 * ks(1 : end - 1) - ks(2 : end)))
  error ('combination of position step ''Dy'' and time step ''Dt'' unstable');
end

% TODO Work this out properly.
tmvs_cc = @(A, T) 0.263e-3 * 101325 * A .* exp (-(17.67 * (T - 273.15)) ./ (T - 29.65));

figure (1);
clf ();
h = plot (ys, Ts, ys, As, ys, tmvs_cc (A, T));
Ls = cumsum (L)(1 : end - 1);
codom = [(min (Ts) - std (Ts)), (max (Ts) + std (Ts))];
for i = 1 : numel (Ls)
  line ([Ls(i), Ls(i)], codom);
end
xlabel ('Position');
ylabel ('Varied Nonsense');
axis ([0, (sum (L)), codom]);

Ts = T;

for i = 1 : n
  Ts(2 : end - 1) = ...
    (r * ks(2 : end - 1) .* Ts(1 : end - 2) ...
   + (cprhos(2 : end - 1) ...
    - 3 * r .* ks(2 : end - 1) ...
    + r * ks(3 : end)) .* Ts(2 : end - 1) ...
   + (2 * r * ks(2 : end - 1) ...
    - r * ks(3 : end)) .* Ts(3 : end)) ...
    ./ (cprhos(2 : end - 1));

  Ts(1) = 270;
  Ts(end) = 300;
  % omega = 10;
  % t0 = t * i / n;
  % Ts(end) = cos (omega * t0 / 2) ^ 2;

  if mod (i, 100) == 0
    set (h(1), 'YData', (Ts - 270) / 30);
    set (h(2), 'YData', As);
    set (h(3), 'YData', tmvs_cc (As, Ts));
    sleep (0.1);
  end
end

end
