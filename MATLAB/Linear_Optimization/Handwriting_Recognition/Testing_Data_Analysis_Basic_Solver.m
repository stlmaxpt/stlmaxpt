
clc
clear
close all

% load given data and data that I created
load mnist.mat
load Hyperplanes_Ptasiewicz

% recreate the data in the way I developed my code
a = [A'; b'];

% preallocate the testing images matrix
images_cut_test = zeros(size(images_test,1),(sqrt(size(images_test,2)) - 2)^2);

% trim the data using the same algorithm as before
for i = 1:size(images_test,1)
    count = 1;
    for j = 1:size(images_test,2)
        if j > sqrt(size(images_test,2)) && j < (size(images_test,2) - sqrt(size(images_test,2)))
            if mod(j,sqrt(size(images_test,2))) ~= 0 && mod(j,sqrt(size(images_test,2))) ~= 1
                images_cut_test(i,count) = images_test(i,j);
                count = count + 1;
            end
        end
    end
end

% normalize the data and preallocate a vector for guesses
images_cut_test_dub = images_cut_test./255;
nums = zeros(size(images_cut_test_dub,1),1);

% calculating guesses for each test image
for k = 1:size(images_cut_test_dub,1)
    % reset a results vector to store resulting values of hyperplane
    % multiplication for each digit
    results = zeros(10,1);
    % calculate the result for each hyperplane
    for l = 1:10
        results(l) = a(1:(end - 1),l)'*images_cut_test_dub(k,:)' + a(end,l);
    end
    % reset values for difference values and guess values
    check_diff = 100;
    check_num = -5;
    % check how close to 1 each result value is and the closest will be the
    % guess of the number
    for m = 1:10
        if abs(results(m) - 1) < check_diff
            check_diff = abs(results(m) - 1);
            check_num = m - 1;
        end
    end
    % fill the number vector with the guess after each image is checked
    nums(k) = check_num;
end

% change data type of labels
labels_test_dub = double(labels_test);

% preallocate the test confusion matrix
confusion_testing = zeros(11);

% fill the confusion matrix with correct values, just increasing the
% correct loaction in the matrix if the guess is right or wrong
for p = 1:numel(labels_test_dub)
    if labels_test_dub(p) == nums(p)
        confusion_testing(nums(p) + 1,nums(p) + 1) = confusion_testing(nums(p) + 1,nums(p) + 1) + 1;
    else
        confusion_testing(labels_test(p) + 1,nums(p) + 1) = confusion_testing(labels_test(p) + 1,nums(p) + 1) + 1;
    end
end

% fill the outside edges of the confusion matrix with totals
for q = 1:10
    confusion_testing(end,q) = sum(confusion_testing(1:(end - 1),q));
    confusion_testing(q,end) = sum(confusion_testing(q,1:(end - 1)));
end

% fill the final value in the matrix
confusion_testing(end,end) = sum(confusion_testing(end,1:(end - 1)));

% now do the confusion matrix for the training data, requires some more
% preprocessing

% preallocate the training images matrix
images_cut_training = zeros(size(images,1),(sqrt(size(images,2)) - 2)^2);

% trim the data using the same algorithm as before
for r = 1:size(images,1)
    count_training = 1;
    for s = 1:size(images,2)
        if s > sqrt(size(images,2)) && s < (size(images,2) - sqrt(size(images,2)))
            if mod(s,sqrt(size(images,2))) ~= 0 && mod(s,sqrt(size(images,2))) ~= 1
                images_cut_training(r,count_training) = images(r,s);
                count_training = count_training + 1;
            end
        end
    end
end

% normalize the data and preallocate a vector for guesses
images_cut_training_dub = images_cut_training./255;
nums_training = zeros(size(images_cut_training_dub,1),1);

% calculating guesses for each training image
for t = 1:size(images_cut_training_dub,1)
    % reset a results vector to store resulting values of hyperplane
    % multiplication for each digit
    results_training = zeros(10,1);
    % calculate the result for each hyperplane
    for u = 1:10
        results_training(u) = a(1:(end - 1),u)'*images_cut_training_dub(t,:)' + a(end,u);
    end
    % reset values for difference values and guess values
    check_diff_training = 100;
    check_num_training = -5;
    % check how close to 1 each result value is and the closest will be the
    % guess of the number
    for v = 1:10
        if abs(results_training(v) - 1) < check_diff_training
            check_diff_training = abs(results_training(v) - 1);
            check_num_training = v - 1;
        end
    end
    % fill the number vector with the guess after each image is checked
    nums_training(t) = check_num_training;
end

% change data type of labels
labels_training_dub = double(labels);

% preallocate the test confusion matrix
confusion_training = zeros(11);

% fill the confusion matrix with correct values, just increasing the
% correct loaction in the matrix if the guess is right or wrong
for w = 1:numel(labels_training_dub)
    if labels_training_dub(w) == nums_training(w)
        confusion_training(nums_training(w) + 1,nums_training(w) + 1) = confusion_training(nums_training(w) + 1,nums_training(w) + 1) + 1;
    else
        confusion_training(labels(w) + 1,nums_training(w) + 1) = confusion_training(labels(w) + 1,nums_training(w) + 1) + 1;
    end
end

% fill the outside edges of the confusion matrix with totals
for c = 1:10
    confusion_training(end,c) = sum(confusion_training(1:(end - 1),c));
    confusion_training(c,end) = sum(confusion_training(c,1:(end - 1)));
end

% fill the final value in the matrix
confusion_training(end,end) = sum(confusion_training(end,1:(end - 1)));

right_test = 0;
for i = 1:numel(nums)
    if nums(i) == labels_test_dub(i)
        right_test = right_test + 1;
    end
end

percentage_test = right_test/i;

right_training = 0;
for j = 1:numel(nums_training)
    if nums_training(j) == labels_training_dub(j)
        right_training = right_training + 1;
    end
end

percentage_training = right_training/j;

% image like 14.1
% generate matrix for plotting
img141 = zeros(28);
img141(1,:) = 1;
img141(end,:) = 1;
img141(:,1) = 1;
img141(:,end) = 1;

% plot the created image that illustrates trimming
figure(1)
imagesc(img141)
colormap(flipud(gray(256)))
axis square

% create example image of a number
imgtest = reshape(images_cut_training(1,:),[26, 26]);
figure(2)
imagesc(imgtest')
colormap(flipud(gray(256)))
axis square

% create an image similar to 14.3 using imagesc
% create a mesh to make the colormap
x = linspace(-10,10,26);
[X, Y] = meshgrid(x);
a1 = a(1:(end - 1),3);
a2 = reshape(a1,26,26,[]);
figure(3)
imagesc(a2,[-.1 .1])
colorbar
axis square

% create a histogram, similar to 14.4

% initialize the histogram I want to create
find_num = 0;

% preallocate vectors for data for the histogram and counter values
histgood = zeros(7000,1);
histbad = zeros(size(images_cut_training_dub,1),1);
countgood = 1;
countbad = 1;

% store each hyperplane result in the correct vector
for ii = 1:size(images,1)
    % calculate the hyperplane result for each image using the hyperplane
    % associated with the data in find_num
    histdata = a(1:(end - 1),find_num + 1)'*images_cut_training_dub(ii,:)' + a(end,find_num + 1);
    if labels(ii) == find_num
        histgood(countgood) = histdata;
        countgood = countgood + 1;
    else
        histbad(countbad) = histdata;
        countbad = countbad + 1;
    end
end

% remove the extra zeros at the end of each vector
histgood(all(~histgood,2),:) = [];
histbad(all(~histbad,2),:) = [];

% generate the histogram
figure(4)
histogram(histgood,'Binwidth',.05,'Normalization','probability','FaceAlpha',.3,'EdgeColor','b','FaceColor','b')
hold on
histogram(histbad,'Binwidth',.05,'Normalization','probability','FaceAlpha',.3,'EdgeColor','r','FaceColor','r')
xline(0,'--')
legend('Positive','Negative')
xlabel('Guessed value')
ylabel('Fraction')

