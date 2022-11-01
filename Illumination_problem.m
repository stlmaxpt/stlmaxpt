
clc
clear
close all

% script to optimize the power given to each light to successfully
% illuminate an oddly shaped floor to the desired illumination value

% load in data from the given function
[A,Ides] = HW2Prob2;

% create a b vector
b = Ides*ones(size(A,1),1);

% guess the initial x vector using the pseudoinverse definition
x = pinv(A)*b;

% go through the initial guess and replace "bad" values with acceptable
% ones
for i = 1:numel(x)
    if x(i) < 0
        x(i) = 0;
    elseif x(i) > 1
        x(i) = 1;
    end
end

% guess the initial illumination values based on the non optimized x vector
Is_init = A*x;

% create a vector to represent the desired illumination
Ides_vec = Ides*ones(size(Is_init));

% calculate the cost function based on the inital illumination values
% calculated earlier using the non optimized x vector
cost_func = sum((Is_init - Ides_vec).^2);

% set a final cost function value to minimize
cost_func_final = 10000;

% iterate through different mu values until a value is found that creates
% an x vector with values in the acceptable range
for mu = 1:20
    % create the A matrix to be added 
    A_add = sqrt(mu)*eye(7);
    
    % create a vector of .5s to act as the bottom of the b vector
    point5s = sqrt(mu)*.5*ones(7,1);

    % concatenate the additional A matrix to the bottom of the original
    A_final = [A; A_add];

    % concatenate the additional b vector to the bottom of the original
    b_final = [b; point5s];
    
    % guess the x vector based on the current mu and the larger A matrix
    x_guess = pinv(A_final)*b_final;
    
    % do a check to see if mu is sufficient
    check = 0;
    for i = 1:numel(x_guess)
        if x_guess(i) < 0
            x_guess(i) = 0;
            check = check + 1;
        elseif x_guess(i) > 1
            x_guess(i) = 1;
            check = check + 1;
        end
    end
    % if the check value never gets updated, that means that all of the
    % values were between 0 and 1, and the mu value was acceptable.
    if check == 0
        % calculate a new set of illumination values based on the updated x vector
        Is_final = A*x_guess;

        % calculate the final cost function to compare to the original, hopefully
        % it is smaller
        cost_func_guess = sum((Is_final - Ides_vec).^2);
        if cost_func_guess < cost_func_final
            cost_func_final = cost_func_guess;
        end
    end
end


