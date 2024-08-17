function [Pop]=newpoint(Pop,Data,R,chromlength,k,index) %生成新点  但是不知道是否在障碍物内

M=length(index);

if M>0
    if index(M)>chromlength
        index(M)=chromlength;
    end
end


s=sqrt((Data.S_E(1,2)-Data.S_E(2,2))^2+(Data.S_E(1,1)-Data.S_E(2,1))^2)/(chromlength+1);
p=s*sqrt(1+k^2)/k;

for j=1:M
    Pop(index(j),1)=R(index(j),1)+rand*(R(index(j),2)-R(index(j),1));
    Pop(index(j),2)=-(Pop(index(j),1)-Data.S_E(1,1))/k+Data.S_E(1,2)+p*index(j);
end