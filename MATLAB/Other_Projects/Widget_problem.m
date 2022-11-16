
clc
clear
close all

% The widget problem: used to calculate the number of widgets created to
% maximize the profit based on costs and materials using a brute force
% algorithm

% assign cost values
cost_a = 10;
cost_b = 5;
cost_c = 15;

% assign nickel and steel amounts
n = 100;
s = 200;

% assign amount of nickel per widget
na = 3;
nb = 3;
nc = 1;

% assign amount of steel per widget
sa = 4;
sb = 2;
sc = 8;

% calculate the maximum number of widget a we can produce
max_a = floor(min([n/na,s/sa]));

% assign initial profit value
profit = 0;

% check each amount of a that is possible to make
for i = max_a:-1:0
     % find out how much material is left
     n_left = n - na*i;
     s_left = s - sa*i;
     % how many bs can I make out of this?
     max_b_check = floor(min([n_left/nb,s_left/sb]));
     % check each amount of b that is possible to make
     for j = max_b_check:-1:0
         % find out how much material is left
         n_left_2 = n_left - nb*j;
         s_left_2 = s_left - sb*j;
         % how many cs can I make out of this?
         max_c_check = floor(min([n_left_2/nc,s_left_2/sc]));
         % calculate the profit for each combination of numbers of widgets
         % no need to check each number of c widgets, assume making the
         % maximum out of remaining material
         profit_check = i*cost_a + j*cost_b + max_c_check*cost_c;
         % check if the new profit is higher than the previous highest
         if profit_check > profit
             % assign a new profit value
             profit = profit_check;
             % assign the numbers vector with amounts of a b and c that
             % goes with the maximum profit
             nums = [i,j,max_c_check];
         end
     end
end

fprintf('The maximum profit that can come from these materials is %i dollars\n',profit)
fprintf('Number of widget A sold: %i\n',nums(1))
fprintf('Number of widget B sold: %i\n',nums(2))
fprintf('Number of widget C sold: %i\n',nums(3))

