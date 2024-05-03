% Given parameters
Ef = 10000;
L = 0.004;
Zc = 400;

% Transfer functions
n1 = [2*Ef 0];
d1 = [1 Zc/L];

n2 = [2*Ef/L];
d2 = [1 Zc/L];

% Step response
t = 0:0.00001:0.0001;
It = step(n2, d2, t);

% Plotting
plot(t, It, 'r');
hold on;

% Calculate currents
If = Ef / Zc;
Ir = It - If;

% Plotting currents
plot(t, Ir, 'b');
xlabel('Time (s)');
ylabel('Current (A)');
legend('Total Current (It)', 'Residual Current (Ir)');
title('Step Response of the System');
