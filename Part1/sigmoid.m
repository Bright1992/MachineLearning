function h=sigmoid(x,theta)
%     h=percpt(x,theta);
    l=length(theta);
    h=0;
    for i=1:l
        h=h+theta(i)*x(i);
    end
    h=1/(1+exp(-h));
    