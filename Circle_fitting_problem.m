
clc
clear
close all

% script to best fit a circle to a set of data points using least squares
% optimization

% import the given data
[u,v] = HW2Prob4;

% create A matrix and b vector based on residuals equation
A = [2*u, 2*v, -1*ones(length(u),1)];
b = u.^2 + v.^2;

% define vector of results using the pseudoinverse
x = pinv(A)*b;

% assign values to the desired variables
uc = x(1);
vc = x(2);
w = x(3);

% check to make sure this is positive and can be square rooted
check = uc^2 + vc^2 - w;

% define radius variable
R = sqrt(uc^2 + vc^2 - w);

% import code from assignment to plot results
t = linspace(0, 2*pi, 1000);
plot(u, v, 'o', R*cos(t) + uc, R*sin(t) + vc, '-');
axis square
axis equal

