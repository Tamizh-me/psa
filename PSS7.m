pd = input('Enter the demand of power in MW: ');
O = input('With limit, enter 1; else enter 0: ');
n = input('Enter the number of buses: ');

for i = 1:n
    disp(['Enter the cost function for bus ', num2str(i)]);
    a(i) = input('Coefficient of a: ');
    b(i) = input('Coefficient of b: ');
    c(i) = input('Coefficient of c: ');
    
    if O == 1
        pmax(i) = input('PMAX: ');
        pmin(i) = input('PMIN: ');
    end
end

s = 0;
s1 = 0;

for i = 1:n
    s = s + (b(i) / (2 * a(i)));
    s1 = s1 + (1 / (2 * a(i)));
end

if O == 1
    lam = input('Enter the value of lambda: ');
else
    lam = (pd + s) / (s1);
end

for k = 1:50
    for i = 1:n
        pg(i) = (lam - b(i)) / (2 * a(i));
        
        if O == 1
            if pg(i) > pmax(i)
                pg(i) = pmax(i);
            elseif pg(i) < pmin(i)
                pg(i) = pmin(i);
            end
        end
    end
    
    ptot = sum(pg);
    del_p = pd - ptot;
    
    if del_p == 0
        break;
    else
        del_lamda = del_p / s1;
        lam = lam + del_lamda;
    end
    
    % Calculate total cost
    totalcost = 0;
    for i = 1:n
        F(i) = c(i) + (b(i) * pg(i)) + (a(i) * pg(i) * pg(i));
        totalcost = totalcost + F(i);
    end
    
    disp(['Iteration: ', num2str(k)]);
    disp(['Pg: ', num2str(pg)]);
    disp(['Lambda: ', num2str(lam)]);
    disp(['Total cost: ', num2str(totalcost)]);
end
