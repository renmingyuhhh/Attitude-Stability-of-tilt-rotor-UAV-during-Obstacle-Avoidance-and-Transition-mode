function [f2]=path_smooth(pop,S_E,popsize) %余弦定理

for j=1:popsize
    P=[S_E(1,:);pop.ch(j).x];
    P=[P;S_E(2,:)];
    [m,n]=size(P);  
    sum=0;  
    for i=2:m-1
        a=sqrt((P(i,1)-P(i-1,1))^2+(P(i,2)-P(i-1,2))^2);
        b=sqrt((P(i,1)-P(i+1,1))^2+(P(i,2)-P(i+1,2))^2);
        c=sqrt((P(i+1,1)-P(i-1,1))^2+(P(i+1,2)-P(i-1,2))^2);
        sum=sum+a^2+b^2-c^2;  
    end 
    f2(j)=sum/(m-2); %平均距离均值
end


