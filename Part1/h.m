function y=h(x,para)
    y=0;
    for i = 1:length(x)
        y=y+x(i)*para(i);
    end
    y=y+para(length(x)+1);