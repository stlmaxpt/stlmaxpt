
clc
clear
close all

% script to remove noise from data using least squares optimization

% import data from the given function
xcor = HW2Prob3;

% create a t vector to use for plotting
t = linspace(0,1000,length(xcor));

% plot the corrupted data
plot(t,xcor)

% set mu values
mu1 = 1;
mu2 = 100;
mu3 = 10000;

% create the D matrix as a sparse matrix for efficiency using the code
% given
D = sparse(999,1000);
D(:,1:999) = -speye(999);
D(:,2:1000) = D(:,2:1000) + speye(999);

% create an xhat vector with each mu value
xhat1 = (speye(1000) + mu1*(D')*D)\xcor;
xhat2 = (speye(1000) + mu2*(D')*D)\xcor;
xhat3 = (speye(1000) + mu3*(D')*D)\xcor;

% plot the cleaned data using each of the mu values
hold on
plot(t,xhat1,'Color','y')
plot(t,xhat2,'Color','r')
plot(t,xhat3,'Color','k')
legend('Corrupted Data','mu = 1','mu = 100','mu = 10000')

% create check values to verify that the equations work as expected
xcheck1 = (speye(1000) + mu1*(D')*D)*xhat1;
xcheck2 = (speye(1000) + mu2*(D')*D)*xhat2;
xcheck3 = (speye(1000) + mu3*(D')*D)*xhat3;

% check that the values are relatively the same
if ((norm(xcheck1 - xcor) < 1e-10) && (norm(xcheck2 - xcor) < 1e-10)) && (norm(xcheck3 - xcor) < 1e-10)
    fprintf('Values are the same\n')
end




