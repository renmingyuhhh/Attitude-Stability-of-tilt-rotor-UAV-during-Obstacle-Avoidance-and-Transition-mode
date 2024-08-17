function [Q]=sel_NDSet(P)

 P_size=length(P.fitness);
 
Q=[];
Q.ch=[];
Q.f=[];
Q.fitness=[];

for i=1:P_size
    if P.fitness(i) < 1
        Q.ch=[Q.ch P.ch(i)];
        Q.f=[Q.f;P.f(i,:)];
        Q.fitness=[Q.fitness P.fitness(i)];
    end
end
 