clear all
close all

x = [1 4 5  8 12];
y = [15 10 11 7 3];

objectives = [x; y];
T=transpose(objectives);




figure
plot(T(:,1) ,T(:,2))
area(T(:,1) ,T(:,2))
[k,A]=boundary(T(:,1) ,T(:,2))

t = 1:numel(x);
xy = [x;y];
pp = spline(t,xy);
tInterp = linspace(1,numel(x));
xyInterp = ppval(pp, tInterp);
%Show the result
figure
plot(x,y,'o:')
hold on
plot(xyInterp(1,:),xyInterp(2,:))
legend({'Original data','Spline interpolation'},'FontSize',12)
[k,A] = boundary(transpose(xyInterp(1,:)),transpose(xyInterp(2,:)))
% 
x = 0:6; 
y = [0 0 0 3 6 6 6]; 
xq1 = 0:.01:6;
p = pchip(x,y,xq1);
s = spline(x,y,xq1);
m = makima(x,y,xq1);
plot(x,y,'o',xq1,p,'-',xq1,s,'-.',xq1,m,'--')
legend('Sample Points','pchip','spline','makima','Location','SouthEast')

%q = integral(m,-1,6)

area(m)




% clear;clc;
% x=[1;5;5;1;2];
% y=[5;5;1;1;3];
% %plot(x,y,'. ')
% k = boundary(x,y);% generate boundary of data points.
% hold on;
% plot(x(k),y(k));
% A = polyarea(x,y);