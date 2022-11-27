function [] = printpuzzle(resultmat)

% all of this is a convoluted way of making a nice grid
N = size(resultmat,1);

fprintf('|')
for pp = 1:(N + sqrt(N) - 1)
    if pp < N + sqrt(N) - 1
        fprintf('--')
    else
        fprintf('-')
    end
end
fprintf('|')
fprintf('\n')
for ll = 1:sqrt(N)
    for mm = 1:sqrt(N)
        for nn = 1:sqrt(N)
            if nn == 1
                fprintf('|')
            end
            for oo = 1:sqrt(N)
                if nn ~= sqrt(N) || oo ~= sqrt(N)
                    fprintf('%d ',resultmat(sqrt(N)*ll - sqrt(N) + mm,sqrt(N)*nn - sqrt(N) + oo))
                else
                    fprintf('%d',resultmat(sqrt(N)*ll - sqrt(N) + mm,sqrt(N)*nn - sqrt(N) + oo))
                end
            end
            if nn < sqrt(N)
                fprintf('| ')
            else
                fprintf('|\n')
            end
        end
    end
    if ll < sqrt(N)
        fprintf('|')
    end
    for rr = 1:sqrt(N)
        if rr < sqrt(N) && ll < sqrt(N)
            for ss = 1:(sqrt(N) + 1)
                fprintf('--')
            end
        elseif ll < sqrt(N)
            for tt = 1:(sqrt(N) - 1)
                fprintf('--')
            end
        end
        if rr == sqrt(N) && ll < sqrt(N)
            fprintf('-|\n')
        end
    end
end
fprintf('|')
for qq = 1:(N + sqrt(N) - 1)
    if qq < N + sqrt(N) - 1
        fprintf('--')
    else
        fprintf('-')
    end
end
fprintf('|')
fprintf('\n')

end