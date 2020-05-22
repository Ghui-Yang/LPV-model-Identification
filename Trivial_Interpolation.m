function [w_x_1l,w_x_2l,w_x_3l] = Trivial_Interpolation(w_x)
%UNTITLED5 计算线性插值权重
    if w_x <= 1
        w_x_1l = 1; 
        w_x_2l = 0;
        w_x_3l = 0;
    elseif w_x > 1 && w_x <= 2.25
        w_x_1l = (2.25-w_x)/(2.25-1); 
        w_x_2l = (w_x-1)/(2.25-1);
        w_x_3l = 0;
    elseif w_x > 2.25 && w_x <= 4
        w_x_1l = 0; 
        w_x_2l = (4-w_x)/(4-2.25);
        w_x_3l = (w_x-2.25)/(4-2.25);
    elseif w_x > 4
        w_x_1l = 0; 
        w_x_2l = 0;
        w_x_3l = 1;
    end
end

