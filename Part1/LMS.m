clear;
% generate data
N=1000; %sample size
M=2;    %sample dimension
A=random('unif',0,100,M,N);
para=random('unif',-10,10,1,M+1);
for i = 1:N
    y=h(A(1:M,i),para);
    A(M+2,i)=y+random('norm',0,25)+para(M+1);
    A(M+1,i)=y+para(M+1);
end
figure(1);
plot((1:N),A(M+1,:)-A(M+2,:));
title('initial error');

alpha=0.0000001;err2=100;

%LMS
para2=ones(1,M+1);
para3=ones(1,M+1);
count=0;
while(abs(err2)>=0.001&&count<10000)
   err2=0;
   for i = 1:M+1
      delta=0;
      for j = 1:N
          SUM=h(A(1:M,j),para2);
          if(i<M+1)
              SUM=(SUM-A(M+1,j))*A(i,j);
          else
              SUM=(SUM-A(M+1,j));
          end
    %     disp(sprintf('SUM:%d',SUM));
          delta=delta+SUM;
          %disp(delta);
      end
      if abs(delta*alpha)>abs(err2)
        err2=delta*alpha;
      end
      para3(i)=para2(i)-alpha*delta;
   end
   para2=para3;
   count=count+1;
end
disp(count);
y=0;
for i=1:N
    y(i)=h(A(1:M,i),para2);
end
y=y+para2(M+1);
figure(2);
plot((1:N),y-A(M+1,:));
title('LMS');
disp(para2-para);

%stochastic LMS
err2=1000;count=0;
para21=zeros(1,M+1);para3=ones(1,M+1);
alpha=alpha*100;
while(err2>=0.001&&count<10000)
   for i=1:N
       err2=0;      %where?
       for j=1:M+1
           SUM=h(A(1:M,i),para21);
           if(j<M+1)
               delta=(SUM-A(M+1,i))*A(j,i);
           else
               delta=SUM-A(M+1,i);
           end
           if abs(err2)<abs(delta*alpha)
               err2=delta*alpha;
           end
           para3(j)=para21(j)-delta*alpha;
       end
       para21=para3;
   end
%    disp(err2);
   count=count+1;
end
disp(err2);
for i=1:N
    y2(i)=h(A(1:M,i),para21);
end
figure(3);
plot((1:N),y2-A(M+1,:),'b',(1:N),y2-A(M+2,:),'r');
title('stochastic LMS');
disp(para21-para);
disp(sum(abs(y2-A(M+1,:)))/N);
disp(sum(abs(y2-A(M+2,:)))/N);
figure(4);
plot(A(1:M,:),A(3,:),'b.',A(1:M,:),A(2,:),'r.',A(1:M,:),y2,'g.',A(1:M,:),y,'black.');

%with matrix calc
X=A(1:M,:);
X=[X;ones(1,N)];
Y=A(M+1,:);
X=X';Y=Y';
theta=inv(X'*X)*X'*Y;
for i=1:N
    y3(i)=h(X(i,1:M),theta);
end
hold on;
plot(A(1,:),y3,'y.');