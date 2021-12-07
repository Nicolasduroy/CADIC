function [c1, c2] = districross(pv1,pv2,eta)
    beta = (2*rand)^(1/(eta+1));
    if beta>1
        pbeta = 0.5*(eta+1)/(beta^(eta+2));
    else
        pbeta = 0.5*(eta+1)*beta^(eta);
    end
    c1 = 0.5*((1-pbeta)*pv1+(1+pbeta)*pv2);
    c2 = 0.5*((1+pbeta)*pv1+(1-pbeta)*pv2);
end