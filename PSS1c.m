clear all;

% Input parameters
ab = input('Value of ab: ');
bc = input('Value of bc: ');
ca = input('Value of ca: ');
pr = input('Receiving end power in MW: ');
vr = input('Receiving end voltage in kV: ');
pfr = input('Receiving end power factor: ');
l = input('Length of the line in km: ');
r = input('Resistance/ph/km: ');
f = input('Frequency: ');
D = input('Diameter in m: ');

% Calculating equivalent parameters
rad = D / 2;
newrad = 0.7788 * rad;
deq = (ab * bc * ca)^(1/3);
L = 2 * 10^(-7) * log(deq / rad);
C = (2 * pi * 8.854 * 10^(-12)) / log(deq / rad);
XL = 2 * pi * f * L * l * 1000;
rnew = r * l;

% Calculating series impedance and shunt admittance
Z = rnew + 1i * XL;
Y = 1i * (2 * pi * f * C * l * 1000);

% ABCD parameters
a = 1 + ((Z * Y) / 2);
d = a;
b = Z;
c = Y * (1 + ((Z * Y) / 4));

% Calculating currents and voltages
vrph = (vr * 10^3) / sqrt(3);
irold = (pr * 10^6) / (sqrt(3) * vr * 10^3 * 0.8);
k = sin(acos(pfr));
ir = irold * (pfr - (1j * k));
vs = (a * vrph) + (b * ir);
is = (c * vrph) + (d * ir);

% Results
fprintf('Series impedance (Z): %.4f + %.4fi\n', real(Z), imag(Z));
fprintf('Shunt admittance (Y): %.4f + %.4fi\n', real(Y), imag(Y));
fprintf('ABCD parameters:\n');
fprintf('a = %.4f, b = %.4f, c = %.4f, d = %.4f\n', a, b, c, d);
fprintf('Voltage magnitude (Vs): %.4f\n', abs(vs));
fprintf('Current magnitude (Is): %.4f\n', abs(is));
fprintf('Voltage angle (Vs): %.4f degrees\n', angle(vs) * 180 / pi);
fprintf('Current angle (Is): %.4f degrees\n', angle(is) * 180 / pi);
fprintf('Power factor at receiving end (PFS): %.4f\n', cos(angle(vs) - angle(is)));
fprintf('Efficiency: %.4f %%\n', ((pr * 10^6) / (3 * abs(vs) * abs(is) * cos(angle(vs) - angle(is)))) * 100);
fprintf('Regulation: %.4f %%\n', (((abs(vs) / abs(a)) - abs(vrph)) / abs(vrph)) * 100);
fprintf('Line inductance (L): %.4f\n', L);
fprintf('Line capacitance (C): %.4f\n', C);
fprintf('Line inductive reactance (XL): %.4f\n', XL);
fprintf('Line resistance (rnew): %.4f\n', rnew);
fprintf('Receiving end voltage (vrph): %.4f\n', vrph);
fprintf('Receiving end current (ir): %.4f\n', abs(ir));
