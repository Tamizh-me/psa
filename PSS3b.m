disp('(a) Fault at the sending end, ...both lines intact when fault is cleared')
Pm = 0.8;
E = 1.17;
V = 1.0;
X1 = 0.65;
X2 = inf;
X3 = 0.65;
H = 5;

P1max = E * V / X1;
P2max = E * V / X2;
P3max = E * V / X3;

d0 = asin(Pm / P1max);
dmax = pi - d0;

dc = acos((Pm * (dmax - d0) + P3max * cos(dmax) - P2max * cos(d0)) / (P3max - P2max));
dcdeg = dc * 180 / pi;
disp(['Critical clearing angle = ', num2str(dcdeg)])

tc = sqrt(2 * H * (dc - d0) / (pi * 60 * Pm));
disp(['Critical clearing time = ', num2str(tc)])

disp('(b) Fault at the mid-point of one line, ....faulted line is isolated')
Pm = 0.8;
E = 1.17;
V = 1.0;
X1 = 0.65;
X2 = 1.8;
X3 = 0.8;
H = 5.0;

P1max = E * V / X1;
P2max = E * V / X2;
P3max = E * V / X3;
d0 = asin(Pm / P1max);
dmax = pi - d0;

dc = acos((Pm * (dmax - d0) + P3max * cos(dmax) - P2max * cos(d0)) / (P3max - P2max));
dcdeg = dc * 180 / pi;
disp(['Critical clearing angle = ', num2str(dcdeg)])

tc = sqrt(2 * H * (dc - d0) / (pi * 60 * Pm));
disp(['Critical clearing time = ', num2str(tc)])
