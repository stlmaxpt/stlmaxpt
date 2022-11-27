function [resultmat] = sudokusolver(puzzle)

N = size(puzzle,1);

% figure out number of clues for later
numclues = 0;
for v = 1:size(puzzle,1)
    for w = 1:size(puzzle,2)
        if puzzle(v,w) ~= 0
            numclues = numclues + 1;
        end
    end
end

% let's make some constraints

% rows

rowcon = zeros(N,N^3);
for i = N^2*(1:N) - N^2 + 1
    rowint = zeros(1,N^3);
    for j = N*(1:N) - N + 1
        rowint((i + j - 1):(i + j + N - 2)) = 1:N;
    end
    rowcon((i - 1 + N^2)/N^2,:) = rowint;
end

rowb = sum(1:N)*ones(N,1);

% columns

colcon = zeros(N,N^3);
for k = N*(1:N) - N + 1
    colint = zeros(1,N^2);
    colint(k:(k + N - 1)) = 1:N;
    colintlong = zeros(1,N^3);
    for l = N^2*(1:N) - N^2 + 1
        colintlong(l:(l + N^2 - 1)) = colint;
    end
    colcon((k - 1 + N)/N,:) = colintlong;
end

colb = sum(1:N)*ones(N,1);

% boxes

boxcon = zeros(N,N^3);
for m = 1:N
    boxintshort = zeros(1,sqrt(N^3));
    for n = N*(1:sqrt(N)) - N + 1
        boxintshort(n:(n + N - 1)) = 1:N;
    end
    boxintmid = zeros(sqrt(N),N^3/sqrt(N));
    for p = (1:sqrt(N))*sqrt(N)^3 - sqrt(N)^3 + 1
        for q = (1:sqrt(N))*N^2 - N^2 + 1
            boxintmid((p - 1 + sqrt(N)^3)/sqrt(N)^3,(p + q - 1):(p + q + length(boxintshort) - 2)) = boxintshort;
        end
    end
    s = 1;
    for r = (1:sqrt(N))*sqrt(N) - (sqrt(N) - 1)
        boxcon(r:(r + sqrt(N) - 1),s:(s + N^3/sqrt(N) - 1)) = boxintmid;
        s = s + N^3/sqrt(N);
    end
end

boxb = sum(1:N)*ones(N,1);

% sum of each number set must be 1, can't have multiple numbers

sumnumcon = zeros(N^2,N^3);
for t = 1:N^2
    sumnumcon(t,(N*t - N + 1):(N*t)) = ones(1,N);
end

sumnumb = ones(N^2,1);

% row, column, and box uniqueness

rowunique = zeros(N^2,N^3);
colunique = zeros(N^2,N^3);
boxunique = zeros(N^2,N^3);

for ii = 1:N
    numuniquerow = zeros(N,N^3);
    numuniquecol = zeros(N,N^3);
    numuniquebox = zeros(N,N^3);
    for jj = 1:N
        for kk = 1:N^3
            if rowcon(jj,kk) == ii
                numuniquerow(jj,kk) = 1;
            end
            if colcon(jj,kk) == ii
                numuniquecol(jj,kk) = 1;
            end
            if boxcon(jj,kk) == ii
                numuniquebox(jj,kk) = 1;
            end
        end
    end
    rowunique((N*ii - N + 1):(N*ii),:) = numuniquerow;
    colunique((N*ii - N + 1):(N*ii),:) = numuniquecol;
    boxunique((N*ii - N + 1):(N*ii),:) = numuniquebox;
end

rowuniqueb = ones(N^2,1);
coluniqueb = ones(N^2,1);
boxuniqueb = ones(N^2,1);

% hard constraints based on clues

clueconextra = zeros(N^3);
cluebextra = zeros(N^3,1);

for x = 1:size(puzzle,1)
    for y = 1:size(puzzle,2)
        if puzzle(x,y) ~= 0
            colind = (N*x - N + y)*N - N + 1;
            clueconextra(colind:(colind + N - 1),colind:(colind + N - 1)) = eye(N);
            cluebint = zeros(N,1);
            for z = 1:N
                if puzzle(x,y) == z
                    cluebint(z) = 1;
                end
            end
            cluebextra(colind:(colind + N - 1)) = cluebint;
        end
    end
end

% remove the extra

cluecon = zeros(N*numclues,N^3);
clueb = zeros(N*numclues,1);
next = 0;
for a = 1:N^3
    yes = 0;
    for b = 1:N^3
        if clueconextra(a,b) == 1
            yes = 1;
        end
    end
    if yes == 1
        next = next + 1;
        cluecon(next,:) = clueconextra(a,:);
        clueb(next) = cluebextra(a);
    end
end

% build A and b for equality constraints
A = [rowcon;
     colcon;
     boxcon;
     sumnumcon;
     cluecon;
     rowunique;
     colunique;
     boxunique];
b = [rowb;
     colb;
     boxb;
     sumnumb;
     clueb;
     rowuniqueb;
     coluniqueb;
     boxuniqueb];

% use cvx and mosek
cvx_begin
    cvx_solver mosek
    variables xnums(N^3)
    minimize(norm(xnums,1))
    subject to
        A*xnums == b;
cvx_end

% guesser

guesses = zeros(N^2,1);
for c = (1:N^2)*N - N + 1
    possibles = xnums(c:(c + N - 1));
    guessval = 0;
    for d = 1:N
        if possibles(d) > guessval
            guessval = possibles(d);
            guessnum = d;
        end
    end
    guesses((c - 1 + N)/N) = guessnum;
end

resultmat = zeros(N);
guessnext = 0;
for f = 1:N
    for g = 1:N
        guessnext = guessnext + 1;
        resultmat(f,g) = guesses(guessnext);
    end
end

end