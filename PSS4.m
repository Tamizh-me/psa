clear all;
clc;

t = 0;
tf = 0;
f = input('Enter the input frequency: ');
s = input('Enter the machine rating: ');
ang(1) = input('Enter the initial angle: ');
h = input('Enter the moment of inertia constant: ');
tfinal = input('Enter the end time: ');
tstep = input('Enter the time step: ');
tc = input('Enter the clearing time: ');
pm = input('Enter the power transfer: ');
pmaxbf = input('Enter the prefault power: ');
pmaxdf = input('Enter the power during fault: ');
pmaxaf = input('Enter the postfault power: ');

m = (s * h) / (180 * f);
delta = ang(1) * pi / 180;
i = 2;
ddelta = 0;

time(1) = 0;

while t < tfinal
    if t == tf
        paminus = pm - pmaxbf * sin(delta);
        paplus = pm - pmaxdf * sin(delta);
        paav = (paminus + paplus) / 2;
        pa = paav;
    end
    if (t == tc)
        paminus = pm - pmaxdf * sin(delta);
        paplus = pm - pmaxaf * sin(delta);
        paav = (paminus + paplus) / 2;
        pa = paav;
    end
    if (t > tf) && (t < tc)
        pa = pm - pmaxdf * sin(delta);
    end
    if (t > tc)
        pa = pm - pmaxaf * sin(delta);
    end
    
    t;
    ddelta = ddelta + (tstep * tstep * pa / m);
    delta = ((delta * 180 / pi) + ddelta) * (pi / 180);
    deltadeg = delta * 180 / pi;
    t = t + tstep;
    pause;
    time(i) = t;
    ang(i) = deltadeg;
    i = i + 1;
end

axis([0 0.6 0 180]);
plot(time, ang, 'ko-');

