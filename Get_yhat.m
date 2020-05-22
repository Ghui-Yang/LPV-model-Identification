function [yhat] = Get_yhat(w,U)
    K = 0.6+w^2;
    T = 3+0.5*w^3;
    cnum = K;
    cden = [T,1];
    Ts = 1;
    sysc = tf(cnum,cden);
    sysd = c2d(sysc,Ts);
    [numd,dend]=tfdata(sysd,'v');
    yhat = filter(numd,dend,U);
end

