clc; 
clear all;

n = input('Enter the number of elements present in the system: ');
data = zeros(n, 4);

for a = 1:n
    data(a, 1) = input('Enter the element number: ');
    data(a, 2) = input('Enter the sending end bus: ');
    data(a, 3) = input('Enter the receiving end bus: ');
    data(a, 4) = input('Enter the element value: ');
end

data

[ele, ~] = size(data);
zbus = [];
currentbusno = 0;

for count = 1:ele
    [rows, cols] = size(zbus);
    from = data(count, 2);
    to = data(count, 3);
    value = data(count, 4);
    newbus = max(from, to);
    ref = min(from, to);
    
    if newbus > currentbusno && ref == 0
        zbus = [zbus, zeros(rows, 1), zeros(1, cols), value];
        currentbusno = newbus;
        continue;
    end
    
    if newbus > currentbusno && ref ~= 0
        zbus = [zbus, zbus(:, ref), zbus(ref, :)', value + zbus(ref, ref)];
        currentbusno = newbus;
        continue;
    end
    
    if newbus <= currentbusno && ref == 0
        zbus = zbus - (1 / (zbus(newbus, newbus) + value)) * zbus(:, newbus) * zbus(newbus, :);
        continue;
    end
    
    if newbus <= currentbusno && ref ~= 0
        zbus = zbus - (1 / (value + zbus(from, from) + zbus(to, to) - 2 * zbus(from, to))) * ...
            ((zbus(:, from) - zbus(:, to)) * (zbus(from, :) - zbus(to, :)));
        continue;
    end
end

zbus
