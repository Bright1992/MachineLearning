function p=percpt(x,theta)
    l=length(theta);
    h=0;
    for i=1:l
        h=h+theta(i)*x(i);
    end
    p=(h>=0);
end