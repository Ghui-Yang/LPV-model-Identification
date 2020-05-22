function [StepR] = Get_stepresponse(w,span)
    K=0.6+w^2;
    T=3+0.5*w^3;
    num=K;
    den=[T,1];
    Ts=1;
    sysc=tf(num,den);
    sysd=c2d(sysc,Ts);
    StepR=step(sysc,1:span);
end
