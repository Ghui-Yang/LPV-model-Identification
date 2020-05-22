function [dnum,dden] = Get_dnumden(w)
    K = 0.6+w^2;
    T = 3+0.5*w^3;
    cnum = K; 
    cden = [T,1];
    Ts = 1;
    sysc = tf(cnum,cden);
    sysd = c2d(sysc,Ts);
    [dnum,dden]=tfdata(sysd,'v'); 
end
