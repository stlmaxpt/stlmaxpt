
clc
clear
close all

% this is a driver script which calls my solver function using each of the
% test cases, and prints results to the command window

tic

test4x4 = [0 0 4 0;
           1 0 0 0;
           0 0 0 3;
           0 1 0 0];
MatrixInitial1 = [0 5 0 0 2 0 3 7 0;
                 0 3 0 9 4 0 0 0 1;
                 0 0 0 7 0 0 0 0 0;
                 0 0 5 8 0 0 9 2 0;
                 3 0 0 0 0 0 0 0 5;
                 0 7 8 0 0 9 1 0 0;
                 0 0 0 0 0 2 0 0 0;
                 8 0 0 0 7 6 0 5 0;
                 0 2 1 0 8 0 0 6 0];

% EVIL LEVEL
MatrixInitial2 = [0 6 9 7 0 0 4 3 0;
                 0 1 0 0 0 0 0 7 0;
                 3 0 0 0 0 5 0 0 2;
                 0 3 0 0 0 0 0 0 1;
                 0 0 0 0 9 0 0 0 0;
                 6 0 0 0 0 0 0 2 0;
                 7 0 0 2 0 0 0 0 3;
                 0 9 0 0 0 0 0 4 0;
                 0 4 2 0 0 3 5 1 0];

% %EVIL LEVEL
MatrixInitial3 = [0 9 0 4 0 8 5 0 0;
                 0 0 0 0 0 0 0 0 6;
                 2 0 1 0 7 0 9 0 0;
                 5 0 0 0 8 0 0 0 7;
                 0 0 7 9 0 4 1 0 0;
                 8 0 0 0 2 0 0 0 9;
                 0 0 2 0 3 0 4 0 5;
                 4 0 0 0 0 0 0 0 0;
                 0 0 5 8 0 7 0 9 0];
             
% %Hardest Sudoku Ever
MatrixInitial4 = [8 0 0 0 0 0 0 0 0;
                 0 0 3 6 0 0 0 0 0;
                 0 7 0 0 9 0 2 0 0;
                 0 5 0 0 0 7 0 0 0;
                 0 0 0 0 4 5 7 0 0;
                 0 0 0 1 0 0 0 3 0;
                 0 0 1 0 0 0 0 6 8;
                 0 0 8 5 0 0 0 1 0;
                 0 9 0 0 0 0 4 0 0];

test1 = sudokusolver(test4x4);
test2 = sudokusolver(MatrixInitial1);
test3 = sudokusolver(MatrixInitial2);
test4 = sudokusolver(MatrixInitial3);
test5 = sudokusolver(MatrixInitial4);

fprintf('Solution of the 4x4 puzzle:\n')
printpuzzle(test1)
fprintf('Solution of the intermediate 9x9:\n')
printpuzzle(test2)
fprintf('Solution of the first evil 9x9:\n')
printpuzzle(test3)
fprintf('Solution of the second evil 9x9:\n')
printpuzzle(test4)
fprintf('Solution of the hardest 9x9 ever:\n')
printpuzzle(test5)

toc
