%Gen data
M=2;N=100;
x=random('unif',0,10,N,M);
y=zeros(N,1);
for i = 1:size(x,1)
    %if(x(i,1)<5&&x(i,2)<5)
    if(x(i,1)+2*x(i,2)<10)
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
plot3(x(:,2),x(:,3),h,'b*',x(:,2),x(:,3),h2,'r*');
legend('Sigmoid','Perceptron');
x1=[];x2=[];x3=[];x4=[];
figure(2);
axis([0,10,0,10]);
for i=1:N
    if(x(i,2)+2*x(i,3)<10)
        x1=[x1,x(i,2)];
        x2=[x2,x(i,3)];
    else
        x3=[x3,x(i,2)];
        x4=[x4,x(i,3)];
    end
end
plot(x1,x2,'o');
hold on;
plot(x3,x4,'x');
theta12=theta./theta(3);
theta22=theta2./theta2(3);
A1=[0,10];B1=[-theta12(1),-theta12(1)-10*theta12(2)];
A2=[0,10];B2=[-theta22(1),-theta22(1)-10*theta22(2)];
p=plot(A1,B1,'r',A2,B2,'b');
legend(p,'Sigmoid','Perceptron');
hold off;