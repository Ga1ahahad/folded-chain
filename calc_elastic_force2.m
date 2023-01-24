function [Fx, Fy] = calc_elastic_force2(C1, C2, C3, c, a)
    Fx = 0; Fy = 0;
    xprev = C1(1);
    yprev = C1(2);
    xcurr = C2(1);
    ycurr = C2(2);
    xnext = C3(1);
    ynext = C3(2);
    Fx = (xprev - 2*xcurr + xnext)*c/a;
    Fy = (yprev - 2*ycurr + ynext)*c/a;
end