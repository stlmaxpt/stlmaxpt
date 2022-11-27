
clc
clear
close all

load('sumhypemosek.mat')
load('mnist.mat')

% preallocate the new matrix to be filled with trimmed images
images_cut_training = zeros(size(images,1),(sqrt(size(images,2)) - 2)^2);

% trimming the edges of each image
for i = 1:size(images,1)
    % set counter variable to 0
    count_training = 1;
    % trimming the data, simply saving the desired parts of the matrix
    for j = 1:size(images,2)
        if j > sqrt(size(images,2)) && j < (size(images,2) - sqrt(size(images,2)))
            if mod(j,sqrt(size(images,2))) ~= 0 && mod(j,sqrt(size(images,2))) ~= 1
                images_cut_training(i,count_training) = images(i,j);
                count_training = count_training + 1;
            end
        end
    end
end

% normalize the data, it is already double type but it needs to be divided
images_cut_dub_training = images_cut_training./255;

% preallocate matrices for each digit, to reorder
char0_training = zeros(7000,size(images_cut_dub_training,2));
char1_training = zeros(7000,size(images_cut_dub_training,2));
char2_training = zeros(7000,size(images_cut_dub_training,2));
char3_training = zeros(7000,size(images_cut_dub_training,2));
char4_training = zeros(7000,size(images_cut_dub_training,2));
char5_training = zeros(7000,size(images_cut_dub_training,2));
char6_training = zeros(7000,size(images_cut_dub_training,2));
char7_training = zeros(7000,size(images_cut_dub_training,2));
char8_training = zeros(7000,size(images_cut_dub_training,2));
char9_training = zeros(7000,size(images_cut_dub_training,2));

% set counter variables
count0_training = 1;
count1_training = 1;
count2_training = 1;
count3_training = 1;
count4_training = 1;
count5_training = 1;
count6_training = 1;
count7_training = 1;
count8_training = 1;
count9_training = 1;

% fill the matrices of each digit with the correct images
for k = 1:size(images_cut_dub_training,1)
    if labels(k) == 0
        char0_training(count0_training,:) = images_cut_dub_training(k,:);
        count0_training = count0_training + 1;
    elseif labels(k) == 1
        char1_training(count1_training,:) = images_cut_dub_training(k,:);
        count1_training = count1_training + 1;
    elseif labels(k) == 2
        char2_training(count2_training,:) = images_cut_dub_training(k,:);
        count2_training = count2_training + 1;
    elseif labels(k) == 3
        char3_training(count3_training,:) = images_cut_dub_training(k,:);
        count3_training = count3_training + 1;
    elseif labels(k) == 4
        char4_training(count4_training,:) = images_cut_dub_training(k,:);
        count4_training = count4_training + 1;
    elseif labels(k) == 5
        char5_training(count5_training,:) = images_cut_dub_training(k,:);
        count5_training = count5_training + 1;
    elseif labels(k) == 6
        char6_training(count6_training,:) = images_cut_dub_training(k,:);
        count6_training = count6_training + 1;
    elseif labels(k) == 7
        char7_training(count7_training,:) = images_cut_dub_training(k,:);
        count7_training = count7_training + 1;
    elseif labels(k) == 8
        char8_training(count8_training,:) = images_cut_dub_training(k,:);
        count8_training = count8_training + 1;
    elseif labels(k) == 9
        char9_training(count9_training,:) = images_cut_dub_training(k,:);
        count9_training = count9_training + 1;
    end
end

% get rid of all the extra rows made of zeros
char0_training(all(~char0_training,2),:) = [];
char1_training(all(~char1_training,2),:) = [];
char2_training(all(~char2_training,2),:) = [];
char3_training(all(~char3_training,2),:) = [];
char4_training(all(~char4_training,2),:) = [];
char5_training(all(~char5_training,2),:) = [];
char6_training(all(~char6_training,2),:) = [];
char7_training(all(~char7_training,2),:) = [];
char8_training(all(~char8_training,2),:) = [];
char9_training(all(~char9_training,2),:) = [];

% store the number of each digit we have in the each vector
each_training = zeros(10,1);
each_training(1) = size(char0_training,1);
each_training(2) = size(char1_training,1);
each_training(3) = size(char2_training,1);
each_training(4) = size(char3_training,1);
each_training(5) = size(char4_training,1);
each_training(6) = size(char5_training,1);
each_training(7) = size(char6_training,1);
each_training(8) = size(char7_training,1);
each_training(9) = size(char8_training,1);
each_training(10) = size(char9_training,1);

big_A_training = [char0_training; char1_training; char2_training;
                  char3_training; char4_training; char5_training;
                  char6_training; char7_training; char8_training;
                  char9_training];

% preallocate the new matrix to be filled with trimmed images
images_cut = zeros(size(images_test,1),(sqrt(size(images_test,2)) - 2)^2);

% trimming the edges of each image
for i = 1:size(images_test,1)
    % set counter variable to 0
    count = 1;
    % trimming the data, simply saving the desired parts of the matrix
    for j = 1:size(images_test,2)
        if j > sqrt(size(images_test,2)) && j < (size(images_test,2) - sqrt(size(images_test,2)))
            if mod(j,sqrt(size(images_test,2))) ~= 0 && mod(j,sqrt(size(images_test,2))) ~= 1
                images_cut(i,count) = images_test(i,j);
                count = count + 1;
            end
        end
    end
end

% normalize the data, it is already double type but it needs to be divided
images_cut_dub = images_cut./255;

% preallocate matrices for each digit, to reorder
char0 = zeros(7000,size(images_cut_dub,2));
char1 = zeros(7000,size(images_cut_dub,2));
char2 = zeros(7000,size(images_cut_dub,2));
char3 = zeros(7000,size(images_cut_dub,2));
char4 = zeros(7000,size(images_cut_dub,2));
char5 = zeros(7000,size(images_cut_dub,2));
char6 = zeros(7000,size(images_cut_dub,2));
char7 = zeros(7000,size(images_cut_dub,2));
char8 = zeros(7000,size(images_cut_dub,2));
char9 = zeros(7000,size(images_cut_dub,2));

% set counter variables
count0 = 1;
count1 = 1;
count2 = 1;
count3 = 1;
count4 = 1;
count5 = 1;
count6 = 1;
count7 = 1;
count8 = 1;
count9 = 1;

% fill the matrices of each digit with the correct images
for k = 1:size(images_cut_dub,1)
    if labels_test(k) == 0
        char0(count0,:) = images_cut_dub(k,:);
        count0 = count0 + 1;
    elseif labels_test(k) == 1
        char1(count1,:) = images_cut_dub(k,:);
        count1 = count1 + 1;
    elseif labels_test(k) == 2
        char2(count2,:) = images_cut_dub(k,:);
        count2 = count2 + 1;
    elseif labels_test(k) == 3
        char3(count3,:) = images_cut_dub(k,:);
        count3 = count3 + 1;
    elseif labels_test(k) == 4
        char4(count4,:) = images_cut_dub(k,:);
        count4 = count4 + 1;
    elseif labels_test(k) == 5
        char5(count5,:) = images_cut_dub(k,:);
        count5 = count5 + 1;
    elseif labels_test(k) == 6
        char6(count6,:) = images_cut_dub(k,:);
        count6 = count6 + 1;
    elseif labels_test(k) == 7
        char7(count7,:) = images_cut_dub(k,:);
        count7 = count7 + 1;
    elseif labels_test(k) == 8
        char8(count8,:) = images_cut_dub(k,:);
        count8 = count8 + 1;
    elseif labels_test(k) == 9
        char9(count9,:) = images_cut_dub(k,:);
        count9 = count9 + 1;
    end
end

% get rid of all the extra rows made of zeros
char0(all(~char0,2),:) = [];
char1(all(~char1,2),:) = [];
char2(all(~char2,2),:) = [];
char3(all(~char3,2),:) = [];
char4(all(~char4,2),:) = [];
char5(all(~char5,2),:) = [];
char6(all(~char6,2),:) = [];
char7(all(~char7,2),:) = [];
char8(all(~char8,2),:) = [];
char9(all(~char9,2),:) = [];

% store the number of each digit we have in the each vector
each = zeros(10,1);
each(1) = size(char0,1);
each(2) = size(char1,1);
each(3) = size(char2,1);
each(4) = size(char3,1);
each(5) = size(char4,1);
each(6) = size(char5,1);
each(7) = size(char6,1);
each(8) = size(char7,1);
each(9) = size(char8,1);
each(10) = size(char9,1);

big_A = [char0; char1; char2; char3; char4; char5; char6; char7; char8; char9];

% data sorted

guesses = zeros(sum(each),1);

for p = 1:(sum(each))
    img = big_A(p,:);
    guesses(p) = node9(img,A,b);
end

key = sort(labels_test);

num_right = 0;
for q = 1:numel(guesses)
    if guesses(q) == key(q)
        num_right = num_right + 1;
    end
end

percentage = num_right/numel(guesses);

guesses_training = zeros(sum(each_training),1);

for p = 1:(sum(each_training))
    img = big_A_training(p,:);
    guesses_training(p) = node9(img,A,b);
end

key_training = sort(labels);

num_right_training = 0;
for q = 1:numel(guesses_training)
    if guesses_training(q) == key_training(q)
        num_right_training = num_right_training + 1;
    end
end

percentage_training = num_right_training/numel(guesses_training);


labels_testing_dub = double(key);
labels_training_dub = double(key_training);

% preallocate the test confusion matrix
confusion_testing = zeros(11);

% fill the confusion matrix with correct values, just increasing the
% correct loaction in the matrix if the guess is right or wrong
for w = 1:numel(labels_testing_dub)
    if labels_testing_dub(w) == guesses(w)
        confusion_testing(guesses(w) + 1,guesses(w) + 1) = confusion_testing(guesses(w) + 1,guesses(w) + 1) + 1;
    else
        confusion_testing(labels_test(w) + 1,guesses(w) + 1) = confusion_testing(labels_test(w) + 1,guesses(w) + 1) + 1;
    end
end

% fill the outside edges of the confusion matrix with totals
for c = 1:10
    confusion_testing(end,c) = sum(confusion_testing(1:(end - 1),c));
    confusion_testing(c,end) = sum(confusion_testing(c,1:(end - 1)));
end

% fill the final value in the matrix
confusion_testing(end,end) = sum(confusion_testing(end,1:(end - 1)));








% preallocate the test confusion matrix
confusion_training = zeros(11);

% fill the confusion matrix with correct values, just increasing the
% correct loaction in the matrix if the guess is right or wrong
for w = 1:numel(labels_training_dub)
    if labels_training_dub(w) == guesses_training(w)
        confusion_training(guesses_training(w) + 1,guesses_training(w) + 1) = confusion_training(guesses_training(w) + 1,guesses_training(w) + 1) + 1;
    else
        confusion_training(labels(w) + 1,guesses_training(w) + 1) = confusion_training(labels(w) + 1,guesses_training(w) + 1) + 1;
    end
end

% fill the outside edges of the confusion matrix with totals
for c = 1:10
    confusion_training(end,c) = sum(confusion_training(1:(end - 1),c));
    confusion_training(c,end) = sum(confusion_training(c,1:(end - 1)));
end

% fill the final value in the matrix
confusion_training(end,end) = sum(confusion_training(end,1:(end - 1)));





function [next] = node1(img,A,b)

if img*A{1,2} - b{1,2} > 0
    next = 0;
else
    next = 1;
end

end

function [next] = node2(img,A,b)

if img*A{1,3} - b{1,3} > 0
    next = node1(img,A,b);
else
    next = node10(img,A,b);
end

end

function [next] = node3(img,A,b)

if img*A{1,4} - b{1,4} > 0
    next = node2(img,A,b);
else
    next = node11(img,A,b);
end

end

function [next] = node4(img,A,b)

if img*A{1,5} - b{1,5} > 0
    next = node3(img,A,b);
else
    next = node12(img,A,b);
end

end

function [next] = node5(img,A,b)

if img*A{1,6} - b{1,6} > 0
    next = node4(img,A,b);
else
    next = node13(img,A,b);
end

end

function [next] = node6(img,A,b)

if img*A{1,7} - b{1,7} > 0
    next = node5(img,A,b);
else
    next = node14(img,A,b);
end

end

function [next] = node7(img,A,b)

if img*A{1,8} - b{1,8} > 0
    next = node6(img,A,b);
else
    next = node15(img,A,b);
end

end

function [next] = node8(img,A,b)

if img*A{1,9} - b{1,9} > 0
    next = node7(img,A,b);
else
    next = node16(img,A,b);
end

end

function [next] = node9(img,A,b)

if img*A{1,10} - b{1,10} > 0
    next = node8(img,A,b);
else
    next = node17(img,A,b);
end

end

function [next] = node10(img,A,b)

if img*A{2,3} - b{2,3} > 0
    next = 1;
else
    next = 2;
end

end

function [next] = node11(img,A,b)

if img*A{2,4} - b{2,4} > 0
    next = node10(img,A,b);
else
    next = node18(img,A,b);
end

end

function [next] = node12(img,A,b)

if img*A{2,5} - b{2,5} > 0
    next = node11(img,A,b);
else
    next = node19(img,A,b);
end

end

function [next] = node13(img,A,b)

if img*A{2,6} - b{2,6} > 0
    next = node12(img,A,b);
else
    next = node20(img,A,b);
end

end

function [next] = node14(img,A,b)

if img*A{2,7} - b{2,7} > 0
    next = node13(img,A,b);
else
    next = node21(img,A,b);
end

end

function [next] = node15(img,A,b)

if img*A{2,8} - b{2,8} > 0
    next = node14(img,A,b);
else
    next = node22(img,A,b);
end

end

function [next] = node16(img,A,b)

if img*A{2,9} - b{2,9} > 0
    next = node15(img,A,b);
else
    next = node23(img,A,b);
end

end

function [next] = node17(img,A,b)

if img*A{2,10} - b{2,10} > 0
    next = node16(img,A,b);
else
    next = node24(img,A,b);
end

end

function [next] = node18(img,A,b)

if img*A{3,4} - b{3,4} > 0
    next = 2;
else
    next = 3;
end

end

function [next] = node19(img,A,b)

if img*A{3,5} - b{3,5} > 0
    next = node18(img,A,b);
else
    next = node25(img,A,b);
end

end

function [next] = node20(img,A,b)

if img*A{3,6} - b{3,6} > 0
    next = node19(img,A,b);
else
    next = node26(img,A,b);
end

end

function [next] = node21(img,A,b)

if img*A{3,7} - b{3,7} > 0
    next = node20(img,A,b);
else
    next = node27(img,A,b);
end

end

function [next] = node22(img,A,b)

if img*A{3,8} - b{3,8} > 0
    next = node21(img,A,b);
else
    next = node28(img,A,b);
end

end

function [next] = node23(img,A,b)

if img*A{3,9} - b{3,9} > 0
    next = node22(img,A,b);
else
    next = node29(img,A,b);
end

end

function [next] = node24(img,A,b)

if img*A{3,10} - b{3,10} > 0
    next = node23(img,A,b);
else
    next = node30(img,A,b);
end

end

function [next] = node25(img,A,b)

if img*A{4,5} - b{4,5} > 0
    next = 3;
else
    next = 4;
end

end

function [next] = node26(img,A,b)

if img*A{4,6} - b{4,6} > 0
    next = node25(img,A,b);
else
    next = node31(img,A,b);
end

end

function [next] = node27(img,A,b)

if img*A{4,7} - b{4,7} > 0
    next = node26(img,A,b);
else
    next = node32(img,A,b);
end

end

function [next] = node28(img,A,b)

if img*A{4,8} - b{4,8} > 0
    next = node27(img,A,b);
else
    next = node33(img,A,b);
end

end

function [next] = node29(img,A,b)

if img*A{4,9} - b{4,9} > 0
    next = node28(img,A,b);
else
    next = node34(img,A,b);
end

end

function [next] = node30(img,A,b)

if img*A{4,10} - b{4,10} > 0
    next = node29(img,A,b);
else
    next = node35(img,A,b);
end

end

function [next] = node31(img,A,b)

if img*A{5,6} - b{5,6} > 0
    next = 4;
else
    next = 5;
end

end

function [next] = node32(img,A,b)

if img*A{5,7} - b{5,7} > 0
    next = node31(img,A,b);
else
    next = node36(img,A,b);
end

end

function [next] = node33(img,A,b)

if img*A{5,8} - b{5,8} > 0
    next = node32(img,A,b);
else
    next = node37(img,A,b);
end

end

function [next] = node34(img,A,b)

if img*A{5,9} - b{5,9} > 0
    next = node33(img,A,b);
else
    next = node38(img,A,b);
end

end

function [next] = node35(img,A,b)

if img*A{5,10} - b{5,10} > 0
    next = node34(img,A,b);
else
    next = node39(img,A,b);
end

end

function [next] = node36(img,A,b)

if img*A{6,7} - b{6,7} > 0
    next = 5;
else
    next = 6;
end

end

function [next] = node37(img,A,b)

if img*A{6,8} - b{6,8} > 0
    next = node36(img,A,b);
else
    next = node40(img,A,b);
end

end

function [next] = node38(img,A,b)

if img*A{6,9} - b{6,9} > 0
    next = node37(img,A,b);
else
    next = node41(img,A,b);
end

end

function [next] = node39(img,A,b)

if img*A{6,10} - b{6,10} > 0
    next = node38(img,A,b);
else
    next = node42(img,A,b);
end

end

function [next] = node40(img,A,b)

if img*A{7,8} - b{7,8} > 0
    next = 6;
else
    next = 7;
end

end

function [next] = node41(img,A,b)

if img*A{7,9} - b{7,9} > 0
    next = node40(img,A,b);
else
    next = node43(img,A,b);
end

end

function [next] = node42(img,A,b)

if img*A{7,10} - b{7,10} > 0
    next = node41(img,A,b);
else
    next = node44(img,A,b);
end

end

function [next] = node43(img,A,b)

if img*A{8,9} - b{8,9} > 0
    next = 7;
else
    next = 8;
end

end

function [next] = node44(img,A,b)

if img*A{8,10} - b{8,10} > 0
    next = node43(img,A,b);
else
    next = node45(img,A,b);
end

end

function [next] = node45(img,A,b)

if img*A{9,10} - b{9,10} > 0
    next = 8;
else
    next = 9;
end

end
