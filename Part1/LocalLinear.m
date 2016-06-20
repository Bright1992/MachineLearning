clear;
close all;
N=1000;M=1;
x=random('unif',0,1,N,M);
y=sin(x*30)+x+random('norm',0,0.2,N,M);
%plot(x,y,'.');
x=[ones(N,1),x];
t=0.01;
W=zeros(N,N);
theta=zeros(M+1,N);
for i=1:N
   for j=1:N
      W(j,j)=exp(-(x(i,2)-x(j,2))^2/2/t^2);
   end
   theta(:,i)=inv(x'*W*x)*x'*W*y;
end
y2=zeros(N,1);
for i=1:N
   y2(i)=x(i,:)*theta(:,i); 
end
plot(x(:,2),y,'b.',x(:,2),y2,'.r');