function [index]=check_in(pop,Data)

% pop=Pop.ch(1).x;
%�ж��Ƿ����ϰ�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%����������(Ŀǰ�����ڳ�����)
%ֱ���ж��Ƿ��ڳ�������
chromlength=Data.length;
m=length(Data.Obs);
% n=2*m;
% cross=[];
% cross.a=[];
index=[];
for i=1:chromlength
%     k=1;
%     cross(i).a=zeros(n,2);
    for j=1:m
        if Data.Obs(j).S(1,1)<=pop(i,1) && pop(i,1)<=Data.Obs(j).S(2,1) && Data.Obs(j).S(3,2)<=pop(i,2) && pop(i,2)<=Data.Obs(j).S(1,2)  %���ж�X
             index=[index i];
             break;
%         cross(i).a(k,:)=[Data.Obs(j).S(1,1),pop(i,2)];      %���һ���ߵĽ���
%         cross(i).a(k+1,:)=[Data.Obs(j).S(2,1),pop(i,2)];    %��ڶ����ߵĽ���   
%         if j~=m
%             k=k+2;
        end    
    end 
end 
