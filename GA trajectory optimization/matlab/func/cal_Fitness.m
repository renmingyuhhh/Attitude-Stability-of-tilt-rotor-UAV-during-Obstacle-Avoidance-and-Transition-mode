 function [Pop Qop Pop_Qop]=cal_Fitness(Pop,Qop) 
P_size=size(Pop.ch,2);
Q_size=size(Qop.ch,2);

k=round(sqrt(P_size + Q_size));
Pop_Qop=[];
Pop_Qop.ch=[Pop.ch Qop.ch];
Pop_Qop.f=[Pop.f;Qop.f];

F=Pop_Qop.f;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%计算R(i)  i属于(Pop+NDSet)

%一个表示个体支配别人的数  一个表示个体被其他个体支配数目

for i=1:P_size+Q_size
    S(i)=0;
    for j=1:P_size+Q_size
        if j~=i
            flag=is_dominate(F(i,:),F(j,:));
            if flag==1
                S(i)=S(i)+1;     %计算S(i)
            end
        end
    end
end

for i=1:P_size+Q_size
    sum=0;
    for j=1:P_size+Q_size
        if j~=i
            flag=is_dominate(F(j,:),F(i,:));
            if flag==1
                sum=sum+S(j);
            end
        end
    end
    R(i)=sum;
end

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
 %计算D(i)
 
         Y=pdist(F,'euclidean');
         MMM=squareform(Y);   
           
         for i=1:P_size+Q_size
             [a index]=sort(MMM(i,:));            
             deta=MMM(i,index(k+1));             
             D(i)=1/(deta+2);          
         end
               
       for   i=1:P_size+Q_size
           Pop_Qop.fitness(i)=R(i)+D(i);
       end
            
       Pop.fitness=Pop_Qop.fitness(1:P_size);
       Qop.fitness=Pop_Qop.fitness(P_size+1:P_size+Q_size);
       