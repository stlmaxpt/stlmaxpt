
clc
clear
close all

% Solving the traveling salesman problem using a brute force algorithm

% choose number of cities, will work with m > 9 as well but is very slow
m = 11;

% calculate x and y values for random points
xs = rand(m,1)*100;
ys = rand(m,1)*100;

% fill up a labels cell array for labeling on the figure
labels = cell(m,1);
for g = 1:m
    labels{g} = num2str(g);
end

% plot each of the random points
figure(1)
scatter(xs,ys,'filled')
axis([0 100 0 100])
hold on

% add the text labels to the figure
for i = 1:length(xs) 
    text(xs(i) + 1,ys(i) + 1,labels{i}) 
end

% ask the user to input an the desired order of points
numsVec = input('Enter the guess for the optimal path:\n');

% make sure that the input vector is the correct length
if length(numsVec) == m
    % draw lines between each point in the order requested by user
    for j = 1:(m - 1)
        plot([xs(numsVec(j)),xs(numsVec(j + 1))],[ys(numsVec(j)),ys(numsVec(j + 1))],'Color','r')
    end
    plot([xs(numsVec(m)),xs(numsVec(1))],[ys(numsVec(m)),ys(numsVec(1))],'Color','r')
    
    % guess the distance using a function that performs calculation on all
    % points to find the entire distance
    guessDist = calcDist(xs,ys,numsVec,m);
    
    % output the length of the guessed path
    fprintf('Length of guessed path is: %f units\n',guessDist)
    
    % finding optimal path:
    % determine every possible path
    p = perms(numsVec);
    % initialize optimal distance value as something definitely larger than
    % the optimal distance
    opDist = 10000;
    % check every possible path
    for k = 1:size(p,1)
        % calculate the distance of each possible path
        checkDist = calcDist(xs,ys,p(k,:),m);
        % if the new distance is shorter, update both the final distance
        % value and the new order vector
        if checkDist < opDist
            opDist = checkDist;
            opVec = p(k,:);
        end
    end

    % draw the optimal path on the figure
    for l = 1:(m - 1)
        plot([xs(opVec(l)),xs(opVec(l + 1))],[ys(opVec(l)),ys(opVec(l + 1))],'Color','g','Linestyle','--')
    end
    plot([xs(opVec(m)),xs(opVec(1))],[ys(opVec(m)),ys(opVec(1))],'Color','g','Linestyle','--')
    
    % display the length of the optimal path
    fprintf('Length of optimal path is: %f units\n',opDist)
    
    % (not required) check if the guess was correct
    if opDist == guessDist
        fprintf('Congrations, you guessed the optimal path!\n')
    else
        fprintf('Better luck next time!\n')
    end
    beep
else
    % error message for incorrect inputs
    fprintf('Incorrect number of inputs\n')
end

function dist = calcDist(xs,ys,numsVec,m)
% this function will calculate the distance of any path given to it using
% the x and y values and the distance formula

% initialize distance to 0
dist = 0;

% calculate the distance between consecutive points as determined by the
% order vector and then add them up
for i = 1:(m - 1)
    dist = dist + sqrt((xs(numsVec(i)) - xs(numsVec(i + 1)))^2 + (ys(numsVec(i)) - ys(numsVec(i + 1)))^2);
end

% this is just the final distance between the first and last point, simpler
% to code if I put it after the loop
dist = dist + sqrt((xs(numsVec(m)) - xs(numsVec(1)))^2 + (ys(numsVec(m)) - ys(numsVec(1)))^2);

end
