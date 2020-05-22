function [dnum,dden] = Get_dnumden(w)
%UNTITLED2 根据工作点求取离散传函的分子和分母
    K = 0.6+w^2;
    T = 3+0.5*w^3;
    cnum = K; % 分子
    cden = [T,1]; % 分母
    Ts = 1;
    sysc = tf(cnum,cden);
    sysd = c2d(sysc,Ts);
    [dnum,dden]=tfdata(sysd,'v'); 
end
