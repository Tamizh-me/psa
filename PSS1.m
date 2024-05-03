clc; clear all;
disp('CALCULATION OF INDUCTANCE AND CAPACITANCE');
D=input('Enter the diameter'); Dab=input('Dab='); Dbc=input('Dbc='); Dca=input('Dca='); d=input('Enter the spacing'); r=d/2;
GMD=[Dab*Dbc*Dca]^(1/3); disp(GMD); GMR=(D*d^3)^(1/4); GMR1=1.09*GMR;
disp(GMR1); C=0.0556/log(GMD/GMR); L=0.2*log(GMD/GMR);
disp('INDUCTANCE VALUE IN HENRY');
disp(L);
disp('CAPACITANCE VALUE IN FARAD');
disp(C);
