
clc
clear
close all

% load in the given data
load mnist.mat

% preallocate the new matrix to be filled with trimmed images
images_cut = zeros(size(images,1),(sqrt(size(images,2)) - 2)^2);

% trimming the edges of each image
for i = 1:size(images,1)
    % set counter variable to 0
    count = 1;
    % trimming the data, simply saving the desired parts of the matrix
    for j = 1:size(images,2)
        if j > sqrt(size(images,2)) && j < (size(images,2) - sqrt(size(images,2)))
            if mod(j,sqrt(size(images,2))) ~= 0 && mod(j,sqrt(size(images,2))) ~= 1
                images_cut(i,count) = images(i,j);
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
    if labels(k) == 0
        char0(count0,:) = images_cut_dub(k,:);
        count0 = count0 + 1;
    elseif labels(k) == 1
        char1(count1,:) = images_cut_dub(k,:);
        count1 = count1 + 1;
    elseif labels(k) == 2
        char2(count2,:) = images_cut_dub(k,:);
        count2 = count2 + 1;
    elseif labels(k) == 3
        char3(count3,:) = images_cut_dub(k,:);
        count3 = count3 + 1;
    elseif labels(k) == 4
        char4(count4,:) = images_cut_dub(k,:);
        count4 = count4 + 1;
    elseif labels(k) == 5
        char5(count5,:) = images_cut_dub(k,:);
        count5 = count5 + 1;
    elseif labels(k) == 6
        char6(count6,:) = images_cut_dub(k,:);
        count6 = count6 + 1;
    elseif labels(k) == 7
        char7(count7,:) = images_cut_dub(k,:);
        count7 = count7 + 1;
    elseif labels(k) == 8
        char8(count8,:) = images_cut_dub(k,:);
        count8 = count8 + 1;
    elseif labels(k) == 9
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

% preallocate matrices for creation of hyperplanes
% big_A is all of the images in order with a 1 added to the end of each
% image
big_A = [char0; char1; char2; char3; char4; char5; char6; char7; char8; char9];
big_A(:,size(images_cut_dub,2) + 1) = ones(size(images_cut_dub,1),1);
a = zeros(size(big_A,2),10);
check = 1;

% create hyperplanes
for m = 1:10
    % make a new B vector each time, as we want 10 unique hyperplanes. This
    % will adjust the locations of the positive 1s to the correct locations
    % for each digit
    B = -1*ones(size(images_cut_dub,1),1);
    B(check:(check - 1 + each(m))) = ones(each(m),1);
    check = check + each(m);
    % fill the hyperplane matrix using the least squares closed form
    % solution
    a(:,m) = pinv(big_A)*B;
end

% create A and b in the requested format
A = a(1:(end - 1),:)';
b = a(end,:)';

% save the generated hyperplanes
save Hyperplanes_Ptasiewicz A b


