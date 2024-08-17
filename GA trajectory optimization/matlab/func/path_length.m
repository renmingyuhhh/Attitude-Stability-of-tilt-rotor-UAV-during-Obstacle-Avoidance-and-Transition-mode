function [f1]=path_length(pop,S_E,popsize,chromlength) %ÿ��Ⱦɫ��·���ܳ���

for j=1:popsize
    sum=0;  
    sum=sum+sqrt((pop.ch(j).x(1,1)-S_E(1,1))^2+(pop.ch(j).x(1,2)-S_E(1,2))^2); %������һ����ľ���
    sum=sum+sqrt((pop.ch(j).x(chromlength,1)-S_E(2,1))^2+(pop.ch(j).x(chromlength,2)-S_E(2,2))^2);%���һ�������յ�ľ���
    for i=2:chromlength
        sum=sum+sqrt((pop.ch(j).x(i,1)-pop.ch(j).x(i-1,1))^2+(pop.ch(j).x(i,2)-pop.ch(j).x(i-1,2))^2);
    end
    f1(j)=sum;
end

