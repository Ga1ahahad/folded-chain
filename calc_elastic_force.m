function [Fx, Fy] = calc_elastic_force(C1, C2, c, a)
    Fx = 0; Fy = 0;
    x1 = C1(1);
    y1 = C1(2);
    x2 = C2(1);
    y2 = C2(2);
    sin = (y2-y1)/sqrt((y2-y1)^2+(x2-x1)^2);
    cos = (x2-x1)/sqrt((y2-y1)^2+(x2-x1)^2);
    if (sqrt((y2-y1)^2+(x2-x1))-a)>0
        F = ( sqrt((y2-y1)^2+(x2-x1)^2)-a )/a*c;
        Fx = F*cos;
        Fy = F*sin;
    end
end