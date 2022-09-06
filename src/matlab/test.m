clc;
clear('all');
close('all');

x = [1,0,0,0,0];
y = zeros(size(x));
for i=1:5
    y(i) = fixedPoint_IIR(x(i),0.1,0.1,0.1,18,16,17,15,17,16,17,16);
end