function Flag=check_part_cross(intX,intY,index1,index2,Obs,S_E)  %�ж����������Ƿ����ϰ����ཻ

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

%P1�� P2������ߵ�ֱ�߲���abc
    
    La=intY(index2)-intY(index1);
    Lb=intX(index1)-intX(index2);
    Lc=intY(index1)*intX(index2)-intX(index1)*intY(index2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NewX=intX;
NewY=intY;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:M         %�ϰ�����
    for k=1:N     %����-%ÿ���ϰ���˵���--��Ӧ�ż�����
        crosspoint(j).xy(k,1)=(Oindex(j).c(k)*Lb-Lc*Oindex(j).b(k))/(La*Oindex(j).b(k)-Oindex(j).a(k)*Lb);
        crosspoint(j).xy(k,2)=(La*Oindex(j).c(k)-Oindex(j).a(k)*Lc)/(Oindex(j).a(k)*Lb-La*Oindex(j).b(k));
    end
end 


Flag=0;
j=1;

while (j<=M) && (Flag==0)       %MΪ�ϰ�����
        for k=1:N                   %N��ʾÿ���ϰ���˵���--��Ӧ�ż�����
            if    Obs(j).S(1,1)<=crosspoint(j).xy(k,1) && crosspoint(j).xy(k,1)<=Obs(j).S(2,1)....
               && Obs(j).S(3,2)<=crosspoint(j).xy(k,2) && crosspoint(j).xy(k,2)<=Obs(j).S(1,2)....
               && min(NewX(index1),NewX(index2))<=crosspoint(j).xy(k,1) && crosspoint(j).xy(k,1)<=max(NewX(index1),NewX(index2))....
               && min(NewY(index1),NewY(index2))<=crosspoint(j).xy(k,2) && crosspoint(j).xy(k,2)<=max(NewY(index1),NewY(index2)) %���ж�X
                Flag=1;
                break;
            end    
        end 
        j=j+1;
end
    


