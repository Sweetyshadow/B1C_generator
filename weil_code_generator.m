% generate B1C code 

function weil_out = weil_code_generator(prn)
    load('./PRNList.mat');
    load('./residu.mat');
    w = PRNList(prn, 2);
    p = PRNList(prn, 3);
    N = 10243;
    N0 = 10230;
    i = 0:N - 1;
    l = ismember(i, residu);
    weil_code = zeros(1, N);
    weil_code(1:N - w) = mod(l(1:N - w) + l(w + 1:N), 2);
    if w ~= 0
        weil_code(N - w + 1:N) = mod(l(N - w + 1:N) + l(1:w), 2);
    end
    if N0 + p - 1 < N
        weil_out = weil_code(p:p + N0 - 1);
    else
        weil_out = [weil_code(p:end) weil_code(1:mod(p+N0 - 1, N))];
    end
    z = (weil_out == 0);
    o = (weil_out == 1);
    weil_out(z) = 1;
    weil_out(o) = -1;
end
