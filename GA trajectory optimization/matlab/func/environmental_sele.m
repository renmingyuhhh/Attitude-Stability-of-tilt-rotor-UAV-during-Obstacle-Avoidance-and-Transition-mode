function [Q]=environmental_sele(Pop,Qop,Pop_Qop,M)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P_Q_size=length(Pop_Qop.fitness);
 
Q=[];
Q.ch=[];
Q.f=[];
Q.fitness=[];

index=[];
for i=1:P_Q_size
    if Pop_Qop.fitness(i) < 1
        Q.ch=[Q.ch Pop_Qop.ch(i)];
        Q.f=[Q.f;Pop_Qop.f(i,:)];
        Q.fitness=[Q.fitness Pop_Qop.fitness(i)];
        index=[index i];
    end
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 %ÐÞ¼ô¹ý³Ì
 
 Q_size=length(Q.fitness);
 if Q_size<M
    [Q]=sel_min_fitness(index,Q,Pop_Qop,M);
    
 elseif Q_size>M
   [Q]=truncation_procedure(Q,M);
 end