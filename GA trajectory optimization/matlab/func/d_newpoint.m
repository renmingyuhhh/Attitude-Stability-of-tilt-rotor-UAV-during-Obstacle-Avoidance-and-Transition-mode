function [Pop]=d_newpoint(Pop,Data,index,chromlength,k) %生成新点 可以确定不在障碍物内

d=index(2)-index(1);

X=Pop(index(2),1)-Pop(index(1),1);
Y=Pop(index(2),2)-Pop(index(1),2);

tx=X/d;
ty=Y/d;


s=sqrt((Data.S_E(1,2)-Data.S_E(2,2))^2+(Data.S_E(1,1)-Data.S_E(2,1))^2)/(chromlength+1);
p=s*sqrt(1+k^2)/k;

for j=1:d-1
    Pop(index(1)+j,1)=Pop(index(1),1)+tx*j;
    Pop(index(1)+j,2)=Pop(index(1),2)+ty*j;
end