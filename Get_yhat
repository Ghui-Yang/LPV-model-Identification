function [yhat] = Get_yhat(w,U)
%UNTITLED6 此处显示有关此函数的摘要
    K = 0.6+w^2;
    T = 3+0.5*w^3;
    cnum = K; % 分子
    cden = [T,1]; % 分母
    Ts = 1;
    sysc = tf(cnum,cden);
    sysd = c2d(sysc,Ts);
    [numd,dend]=tfdata(sysd,'v');
    yhat = filter(numd,dend,U);
end

