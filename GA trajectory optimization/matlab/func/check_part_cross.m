function Flag=check_part_cross(intX,intY,index1,index2,Obs,S_E)  %判断两点连线是否与障碍物相交

M=length(Obs);%障碍物数
%%%%%%%%%%%%%%%%%%
%障碍物端点直线参数abc
for i=1:M   
    N=length(Obs(i).S);%每个障碍物端点数--对应着几条边
    for j=1:N-1
    Oindex(i).a(j)=Obs(i).S(j+1,2)-Obs(i).S(j,2);
    Oindex(i).b(j)=Obs(i).S(j,1)-Obs(i).S(j+1,1);
    Oindex(i).c(j)=Obs(i).S(j,2)*Obs(i).S(j+1,1)-Obs(i).S(j,1)*Obs(i).S(j+1,2);
    end
    Oindex(i).a(N)=Obs(i).S(N,2)-Obs(i).S(1,2);
    Oindex(i).b(N)=Obs(i).S(1,1)-Obs(i).S(N,1);
    Oindex(i).c(N)=Obs(i).S(1,2)*Obs(i).S(N,1)-Obs(i).S(1,1)*Obs(i).S(N,2);
end

%P1点 P2点的连线的直线参数abc
    
    La=intY(index2)-intY(index1);
    Lb=intX(index1)-intX(index2);
    Lc=intY(index1)*intX(index2)-intX(index1)*intY(index2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NewX=intX;
NewY=intY;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j=1:M         %障碍物数
    for k=1:N     %边数-%每个障碍物端点数--对应着几条边
        crosspoint(j).xy(k,1)=(Oindex(j).c(k)*Lb-Lc*Oindex(j).b(k))/(La*Oindex(j).b(k)-Oindex(j).a(k)*Lb);
        crosspoint(j).xy(k,2)=(La*Oindex(j).c(k)-Oindex(j).a(k)*Lc)/(Oindex(j).a(k)*Lb-La*Oindex(j).b(k));
    end
end 


Flag=0;
j=1;

while (j<=M) && (Flag==0)       %M为障碍物数
        for k=1:N                   %N表示每个障碍物端点数--对应着几条边
            if    Obs(j).S(1,1)<=crosspoint(j).xy(k,1) && crosspoint(j).xy(k,1)<=Obs(j).S(2,1)....
               && Obs(j).S(3,2)<=crosspoint(j).xy(k,2) && crosspoint(j).xy(k,2)<=Obs(j).S(1,2)....
               && min(NewX(index1),NewX(index2))<=crosspoint(j).xy(k,1) && crosspoint(j).xy(k,1)<=max(NewX(index1),NewX(index2))....
               && min(NewY(index1),NewY(index2))<=crosspoint(j).xy(k,2) && crosspoint(j).xy(k,2)<=max(NewY(index1),NewY(index2)) %先判断X
                Flag=1;
                break;
            end    
        end 
        j=j+1;
end
    


