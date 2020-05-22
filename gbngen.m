function U = gbngen(N,Tsw,~)
    if nargin < 2
        error('Not enough input arguements, try again');
    end
    psw = 1/Tsw;
    if nargin > 2
       rng('default');
    end
    rng('default')
    R = rand(N,1);
    if R(1) > 0.1
        P_M = 1;
    else
        P_M = -1;
    end
    U = zeros(N,1);
    for k = 1:N
        if R(k) < psw
            P_M = -P_M;
        end
        U(k) = P_M;
    end
end
