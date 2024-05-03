clc;
clear all;

j = sqrt(-1);

% Input parameters
pe = input('Enter the given power: ');
h = input('Enter the inertia constant: ');
kd = input('Enter the KD value: ');
f = input('Enter the frequency value: ');
del10 = input('Enter the initial value of del: ');
n = input('Enter the number of reactances: ');

% Reactance input
for i = 1:n
    x(i) = input('Enter the reactance value: ');
end

s = 0;
for i = 2:n
    s = s + x(i);
end

x12 = j * s;
x12m = abs(x12);
theta = asin(pe * x12m);
[a, b] = pol2cart(theta, 1);
et = complex(a, b);
ct = (et - 1) / x12;
e1 = et + (j * x(1) * ct);
val = abs(e1);

d = 0;
for i = 1:n
    d = d + x(i);
end

val1 = val / d;
del0 = asin(pe / val1);

% Calculating system parameters
ks = (val * cos(del0)) / d;
wn = sqrt((ks * 2 * pi * f) / (2 * h));
zeta = (kd / (2 * h * wn)) / 2;
wd = wn * sqrt(1 - (zeta ^ 2));
theta0 = acos(zeta);
time = 1 / (zeta * wn);

p1 = (del10 / sqrt(1 - (zeta ^ 2)));
p2 = -zeta * wn;

t = 0:0.1:5;

% Response calculation
for k = 1:length(t)
    y(k) = p1 * exp(p2 * t(k)) * sin((wd * t(k)) + theta0);
end

p3 = -p1 * wn;

for k = 1:length(t)
    z(k) = p3 * exp(p2 * t(k)) * sin(wd * t(k));
end

% Plotting
figure
subplot(2, 1, 1)
plot(t, y)
xlabel('Time in secs')
ylabel('Angle in degrees')

subplot(2, 1, 2)
plot(t, z)
xlabel('Time in secs')
ylabel('Speed in rps')
