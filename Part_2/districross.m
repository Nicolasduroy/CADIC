function [c1, c2] = districross(pv1,pv2,eta)
    u = rand;
    if u<0.5 
        beta = (2*u)^(1/(eta+1));
    else
        beta = (1/(2*(1-u)))^(1/(eta+1));
    end
    if beta>1
        pbeta = 0.5*(eta+1)/(beta^(eta+2));
    elseif beta>=0
        pbeta = 0.5*(eta+1)*beta^(eta);
    else
        pbeta = 0;
    end
    c1 = 0.5*((1-pbeta)*pv1+(1+pbeta)*pv2);
    c2 = 0.5*((1+pbeta)*pv1+(1-pbeta)*pv2);
end