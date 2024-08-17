 function [f3]=path_safety(popsize,chromlength,Obs,Lindex) 

%安全性能：1/d——d表示路径中距离所有障碍物的的最短距离  

M=length(Obs);              %M为障碍物个数
 for i=1:popsize                %种群数目
     d2=zeros(1,chromlength+1);
    for j=1:chromlength+1       %j为路径段直线数目           
        d1=[];
        for k=1:M                   
            N=size(Obs(k).S,1);  %N为障碍物端点数
            A=zeros(1,N);

            for t=1:N
               A(t)=abs(Obs(k).S(t,1)*Lindex(i).abc(j).a+Obs(k).S(t,2)*Lindex(i).abc(j).b+Lindex(i).abc(j).c)/sqrt(Lindex(i).abc(j).a^2+Lindex(i).abc(j).b^2);         
            end
              d1(k)=min(A);        %第k个障碍物距离本段路径段的距离            
        end  
        d2(j)=min(d1);
    end
     d=min(d2);
     f3(i)=1/d;
end