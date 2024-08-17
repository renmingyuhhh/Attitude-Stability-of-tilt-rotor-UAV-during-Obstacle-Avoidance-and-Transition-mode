function [Pop R k]=intpop(Data,popsize,chromlength,Pop,R,k)

k=(Data.S_E(1,2)-Data.S_E(2,2))/(Data.S_E(1,1)-Data.S_E(2,1)); %kΪб��

X_line=Data.S_E(2,1)-Data.S_E(1,1);
Y_line=Data.S_E(2,2)-Data.S_E(1,2);

for i=1:chromlength
    Temp_X(i)=Data.S_E(1,1)+X_line/(chromlength+1)*i; %Temp_X  Temp_YΪ���ߵȷֵ�
end
Temp_Y=k*(Temp_X-Data.S_E(1,1)*ones(1,chromlength))+Data.S_E(1,2)*ones(1,chromlength);

a=Temp_X/k+Temp_Y;                                 %ÿ��������Y��(X=0)����  (0,a)��ʽ     
% b=(Temp_X-Data.B(2)*ones(1,chromlength))/k+Temp_Y; %ÿ��������X=Xbou�ύ��  (Xbou,b)��ʽ
c=Temp_Y*k+Temp_X;                                 %ÿ��������X��(Y=0)����  (c,0)��ʽ
d=(Temp_Y-Data.B(2)*ones(1,chromlength))*k+Temp_X; %ÿ��������Y=Ybou�ύ��  (d,Ybou)��ʽ 

R=zeros(chromlength,2); %R��ʾxȡֵ��Χ

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
    [index]=check_in(Pop.ch(i).x,Data);                           %����ʼ���Ƿ����ϰ�����
    
    if 1-isempty(index)
    [Pop.ch(i).x]=newpop(Pop.ch(i).x,Data,R,chromlength,k,index);  %�����ڵĻ����������ɵ㣨�����ϰ����ڵĵ㣩
    end
end




