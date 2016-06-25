%Gen data
M=1;N=100;
x=random('unif',0,10,N,M);
y=zeros(N,1);
for i = 1:size(x,1)
    %if(x(i,1)<5&&x(i,2)<5)
    if(x(i)<8)
        y(i)=1;
    end
end

theta=ones(M+1,1);theta2=ones(M+1,1);
x=[ones(N,1),x];
count=0;err=1000;alpha=0.01;
while(abs(err)>=0.0001&&count<10000)
   err=0;
   s=0;s2=0;
   for j=1:M+1;
       for i=1:N
           s=s+(y(i)-sigmoid(theta,x(i,:)))*x(i,j);
           s2=s2+(y(i)-percpt(theta2,x(i,:)))*x(i,j);
       end
       s=s/N*alpha;
       s2=s2/N*alpha;
       if(abs(s)>abs(err))
           err=s;
       end
       if(abs(s2)>abs(err))
           err=s2;
       end
       theta(j)=theta(j)+s;
       theta2(j)=theta2(j)+s2;
   end
   count=count+1;
end

err
count

for i = 1:N
    h(i)=sigmoid(x(i,:),theta);
    h2(i)=percpt(x(i,:),theta2);
end
plot(x(:,2),h,'b*',x(:,2),h2,'r*');
legend('Sigmoid','Perceptron');