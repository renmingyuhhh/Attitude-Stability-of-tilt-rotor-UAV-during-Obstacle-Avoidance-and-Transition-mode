function [Pop R k]=intpop(Data,popsize,chromlength,Pop,R,k)

k=(Data.S_E(1,2)-Data.S_E(2,2))/(Data.S_E(1,1)-Data.S_E(2,1)); %k为斜率

X_line=Data.S_E(2,1)-Data.S_E(1,1);
Y_line=Data.S_E(2,2)-Data.S_E(1,2);

for i=1:chromlength
    Temp_X(i)=Data.S_E(1,1)+X_line/(chromlength+1)*i; %Temp_X  Temp_Y为连线等分点
end
Temp_Y=k*(Temp_X-Data.S_E(1,1)*ones(1,chromlength))+Data.S_E(1,2)*ones(1,chromlength);

a=Temp_X/k+Temp_Y;                                 %每条垂线与Y轴(X=0)交点  (0,a)形式     
% b=(Temp_X-Data.B(2)*ones(1,chromlength))/k+Temp_Y; %每条垂线与X=Xbou轴交点  (Xbou,b)形式
c=Temp_Y*k+Temp_X;                                 %每条垂线与X轴(Y=0)交点  (c,0)形式
d=(Temp_Y-Data.B(2)*ones(1,chromlength))*k+Temp_X; %每条垂线与Y=Ybou轴交点  (d,Ybou)形式 

R=zeros(chromlength,2); %R表示x取值范围

for i=1:chromlength
    if a(i)<=Data.B(2)
       R(i,:)=[0,c(i)];
    elseif a(i)>Data.B(2) && c(i)<=Data.B(1)
       R(i,:)=[d(i),c(i)];
    elseif a(i)>Data.B(2) && c(i)>Data.B(1)
       R(i,:)=[d(i),Data.B(1)];
    end
end

intX=zeros(popsize,chromlength);

for i=1:popsize
    for j=1:chromlength
       intX(i,j)=R(j,1)+rand*(R(j,2)-R(j,1));
    end
end


s=sqrt((Data.S_E(1,2)-Data.S_E(2,2))^2+(Data.S_E(1,1)-Data.S_E(2,1))^2)/(chromlength+1);
p=s*sqrt(1+k^2)/k;

intY=zeros(popsize,chromlength);
for i=1:popsize
    for j=1:chromlength
        intY(i,j)=-(intX(i,j)-Data.S_E(1,1))/k+Data.S_E(1,2)+p*j;
    end
end

Pop=[];
Pop.ch=[];
for i=1:popsize
    Pop.ch(i).x(:,1)=reshape(intX(i,:),chromlength,1);
    Pop.ch(i).x(:,2)=reshape(intY(i,:),chromlength,1);
    index=[];
    [index]=check_in(Pop.ch(i).x,Data);                           %检查初始点是否在障碍物内
    
    if 1-isempty(index)
    [Pop.ch(i).x]=newpop(Pop.ch(i).x,Data,R,chromlength,k,index);  %假如在的话则重新生成点（不在障碍物内的点）
    end
end




