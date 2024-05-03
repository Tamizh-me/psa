clear all; format long
f=50;tstep=0.01;h=[12 9]';
pgnetterm=[3.25 2.10]';
qgnetterm=[0.6986 0.3110]';
xg=[0.067 0.10]';
v0=[pol2cart(1.03,8.235) pol2cart(1.02,7.16)].'; m=2;
v0conj=conj(v0); Ig0=conj((pgnetterm+j*qgnetterm)./v0); Edash0=v0+j*(xg.*Ig0); Pg0=real(Edash0.*conj(Ig0)); x1_r=angle(Edash0);
Pg_r=Pg0; x2_r=[0 0]';
x1dot_r=[0 0]';
x2dot_r=[0 0]';
x1dotrplus1=[0 0]';
x2dotrplus=[0 0]';
Ybusdf=[5.7986-j*35.6301	0	-0.0681+j*5.1661
0	-j*11.236	0
-0.0581+j*5.1661	0	0.1362-j*6.2737]; Ybuspf=[1.3932-j*13.8731 -0.2214+j*7.6289	-0.0901+j*6.0975
-00.2214+j*7.6289	0.5+j*7.7898	0
-0.0901+j*6.0975	0	0.1591-j*6.1168];
t=0;tc=0.08;tfinal=1.0; r=1;
Edash_r=Edash0;Edash_rplus1=Edash0;
while t< tfinal
    if t<tc 
        Ybus=Ybusdf;
    else
        Ybus=Ybuspf;
    end 
    i=Ybus(2:m+1,:)*[1; Edash_r];  % Fix here
    Pg_r=real(Edash_r.*conj(i)); 
    x1dot_r=x2_r;
    for k=1:m
        x2dot_r(k,1)=(pi*f/h(k))*(Pg0(k)-Pg_r(k)); 
    end
    x1_rplus1=x1_r+x1dot_r*tstep; 
    x2_rplus1=x2_r+x2dot_r*tstep; 
    Edash_rplus1=abs(Edash0).*(cos(x1_rplus1)+j*sin(x1_rplus1)); 
    i=Ybus(2:m+1,:)*[1; Edash_rplus1]; % Fix here
    Pg_rplus1=real(Edash_rplus1.*conj(i)); 
    x1dot_rplus1=[0 0]';
    x2dot_rplus1=[0 0]'; 
    for k=1:m
        x1dot_rplus1(k,1)=x2_rplus1(k,1); 
        x2dot_rplus1(k,1)=pi*f/h(k)*(Pg0(k)- Pg_rplus1(k));
    end 
    x1dotav_r=(x1dot_r+x1dot_rplus1)/2.0; 
    x2dotav_r=(x2dot_r+x2dot_rplus1)/2.0; 
    x1_rplus1=x1_r+x1dotav_r*tstep; 
    x2_rplus1=x2_r+x2dotav_r*tstep; 
    Edash_rplus1=abs(Edash0).*(cos(x1_rplus1)+j*sin(x1_rplus1)); 
    x2_r=x2_rplus1; 
    x1_r=x1_rplus1; 
    Edash_r=Edash_rplus1; 
    time(r)=t; 
    for k=1:m
        ang(r,k)=(x1_r(k)*180)/pi; 
    end 
    t=t+tstep; 
    r=r+1;
end 
plot(time,ang)

