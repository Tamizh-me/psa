clc;
clear all;
a=[0.08;0.08]; 
b=[16;12];
c=[0;0];
Pd=100;
B=[0.001 -0.0005;
   -0.0005 0.0024];
lambda=(Pd+sum(b./(2*a)))/sum(1./(2*a));
P_initial=(lambda-b)./(2*a);
P=P_initial;
Delp=10;
iter=0;
ngg=length(B(:,1));
while abs(Delp)>=0.1
    iter=iter+1;
    for k=1:ngg
        BP=0;
        for m=1:ngg
            if m~=k
                BP=BP+2*lambda*B(k,m)*P(m);
            end
        end
        P(k)=(lambda-b(k)-BP)./((2*a(k))+(2*lambda*B(k,k)));
    end
    P_loss=(P(1)^2*B(1,1))+(2*P(1)*P(2)*B(1,2))+(P(2)^2*B(2,2));
    Delp=Pd+P_loss-sum(P);
    if Delp<0
        lambda=lambda-(0.1*lambda);
    elseif Delp>0 
        lambda=lambda+(0.1*lambda);
    else
    end
end
iter
lambda 
P 
P_loss
totalcost=sum(c+b.*P+a.*P.^2)
