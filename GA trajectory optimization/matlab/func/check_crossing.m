function [Cindex Lindex]=check_crossing(intX,intY,chromlength,Obs,S_E)  %�ж����������Ƿ����ϰ����ཻ

M=length(Obs);%�ϰ�����
%%%%%%%%%%%%%%%%%%
%�ϰ���˵�ֱ�߲���abc
for i=1:M   
    N=length(Obs(i).S);%ÿ���ϰ���˵���--��Ӧ�ż�����
    for j=1:N-1
    Oindex(i).a(j)=Obs(i).S(j+1,2)-Obs(i).S(j,2);
    Oindex(i).b(j)=Obs(i).S(j,1)-Obs(i).S(j+1,1);
    Oindex(i).c(j)=Obs(i).S(j,2)*Obs(i).S(j+1,1)-Obs(i).S(j,1)*Obs(i).S(j+1,2);
    end
    Oindex(i).a(N)=Obs(i).S(N,2)-Obs(i).S(1,2);
    Oindex(i).b(N)=Obs(i).S(1,1)-Obs(i).S(N,1);
    Oindex(i).c(N)=Obs(i).S(1,2)*Obs(i).S(N,1)-Obs(i).S(1,1)*Obs(i).S(N,2);
end

%%%%%%%%%%%%%%%%%%
%·���߶ζ˵�ֱ�߲���abc
Lindex(1).a=intY(1)-S_E(1,2);
Lindex(1).b=S_E(1,1)-intX(1);
Lindex(1).c=S_E(1,2)*intX(1)-S_E(1,1)*intY(1);

for i=2:chromlength
    Lindex(i).a=intY(i)-intY(i-1);
    Lindex(i).b=intX(i-1)-intX(i);
    Lindex(i).c=intY(i-1)*intX(i)-intX(i-1)*intY(i);
end

Lindex(chromlength+1).a=S_E(2,2)-intY(chromlength);
Lindex(chromlength+1).b=intX(chromlength)-S_E(2,1);
Lindex(chromlength+1).c=intY(chromlength)*S_E(2,1)-intX(chromlength)*S_E(2,2);
%%%%%%%%%%%%%%%%%%

%��ÿ��·�����ϰ���߽�Ľ���

for i=1:chromlength+1 %·���߶���
    for j=1:M         %�ϰ�����
        for k=1:N     %����-%ÿ���ϰ���˵���--��Ӧ�ż�����
        crosspoint(i).p(j).xy(k,1)=(Oindex(j).c(k)*Lindex(i).b-Lindex(i).c*Oindex(j).b(k))/(Lindex(i).a*Oindex(j).b(k)-Oindex(j).a(k)*Lindex(i).b);
        crosspoint(i).p(j).xy(k,2)=(Lindex(i).a*Oindex(j).c(k)-Oindex(j).a(k)*Lindex(i).c)/(Oindex(j).a(k)*Lindex(i).b-Lindex(i).a*Oindex(j).b(k));
        end
    end 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NewX=[S_E(1,1);intX];
NewX=[NewX;S_E(2,1)];

NewY=[S_E(1,2);intY];
NewY=[NewY;S_E(2,2)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%��Ҫ�Ľ� ��Ŀǰ�����ڳ����Σ�
Cindex=[];
for i=1:chromlength+1 %·���߶���

    j=1;
    Flag=0;
    while (j<=M) && (Flag==0)       %MΪ�ϰ�����
        for k=1:N                   %N��ʾÿ���ϰ���˵���--��Ӧ�ż�����
            if    Obs(j).S(1,1)<=crosspoint(i).p(j).xy(k,1) && crosspoint(i).p(j).xy(k,1)<=Obs(j).S(2,1)....
               && Obs(j).S(3,2)<=crosspoint(i).p(j).xy(k,2) && crosspoint(i).p(j).xy(k,2)<=Obs(j).S(1,2)....
               && min(NewX(i),NewX(i+1))<=crosspoint(i).p(j).xy(k,1) && crosspoint(i).p(j).xy(k,1)<=max(NewX(i),NewX(i+1))....
               && min(NewY(i),NewY(i+1))<=crosspoint(i).p(j).xy(k,2) && crosspoint(i).p(j).xy(k,2)<=max(NewY(i),NewY(i+1)) %���ж�X
                Flag=1;
                break;
            end    
        end 
        j=j+1;
    end
    
    if Flag==1 
        Cindex=[Cindex i];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


