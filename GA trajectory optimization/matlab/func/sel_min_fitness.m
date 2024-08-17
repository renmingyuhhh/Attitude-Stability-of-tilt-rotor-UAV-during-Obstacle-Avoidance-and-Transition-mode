 function [Q]=sel_min_fitness(index,Q,Pop_Qop,M)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_Q_size=length(Pop_Qop.fitness);
T=M-length(Q.fitness);
[S_Fit,newindex]=sort(Pop_Qop.fitness);

count=1;
i=1;
a=[];
while count<=T && i<=P_Q_size

        flag=0;   
        for j=1:length(index)
            if newindex(i)==index(j)
                     flag=1;
                    break;
            end    
        end
     
          if flag==1
              i=i+1;      
          elseif flag==0   
              a=[a newindex(i)];
               i=i+1;  
               if count==T
                   break;
               else
               count=count+1;
               end
         end
              
end

 for i=1:count
     Q.ch=[Q.ch Pop_Qop.ch(a(i))];
     Q.f=[Q.f;Pop_Qop.f(a(i),:)];
     Q.fitness=[Q.fitness Pop_Qop.fitness(a(i))];
 end

