function [Q]=truncation_procedure(Q,N)

Q_size=length(Q.fitness);
Ns=Q_size;

while Ns<N

Y=pdist(Q.f,'euclidean');
Distance=squareform(Y);   

 Min=Distance(2,1);
               
for k=1:Ns
    for j=k+1:Ns
        if Distance(j,k)<Min;
             Min=Distance(j,k);
             index=[j k];
        end
    end
end
a=index(2);
b=index(1);

[S1 S1_index]=sort(Distance(a,:));
[S2 S2_index]=sort(Distance(b,:));

for i=1:Ns
      if S1(i)<S2(i)
          Del_num=a;
          break;
      elseif S1(i)>S2(i)
          Del_num=b;
          break;
      end
end
     
Q.ch(Del_num)=[];
Q.f(Del_num,:)=[];
Q.fitness(Del_num)=[];

Ns=Ns-1;
end
         