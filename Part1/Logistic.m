%Gen data
M=2;N=100;
x=random('unif',0,10,N,M);
y=zeros(N,1);
for i = 1:size(x,1)
    if(x(i,1)<5&&x(i,2)<5)
        y(i)=1;
    end
end

theta=ones(M+1,1);
x=[ones(N,1),x];
count=0;err=1000;alpha=0.01;
while(abs(err)>=0.0001&&count<10000)
   err=0;
   s=0;
   for j=1:M+1;
       for i=1:N
           s=s+(y(i)-sigmoid(theta,x(i,:)))*x(i,j);
       end
       s=s/N*alpha;
       if(abs(s)>abs(err))
           err=s;
       end
       theta(j)=theta(j)+s;
   end
   count=count+1;
end

err
count