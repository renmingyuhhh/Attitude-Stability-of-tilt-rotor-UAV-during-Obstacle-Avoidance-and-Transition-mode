clc;
clear;
close all;
warning off;
addpath(genpath(pwd));

%�趨����
Data=[];
Data.B=[25 25];           %X��Y��߽�
Data.S_E=[0,5;20,5.01];     %��㣬�յ�
Data.size=100;             %��Ⱥ��С
Data.length=30;           %Ⱦɫ�峤��
M=round(Data.size/2);     %�ⲿ�浵����ģ
MaxIte=20;                %����������

pm=0.3;%�������
pc=0.6;%�������
% Obs.S=[];%�ϰ����������
Data.Obs(1).S=[1,4;2,4;2,3;1,3];%ÿ������洢����˳ʱ��˳������
Data.Obs(2).S=[3,6;4,6;4,3;3,3];
Data.Obs(3).S=[6,4;7,4;7,2;6,2];
Data.Obs(4).S=[8,6;9,6;9,5;8,5];
Data.Obs(5).S=[10,14;14,14;14,12;10,12];
Data.Obs(6).S=[14,8;18,8;18,6;14,6];
[Pop R k]=intpop(Data,Data.size,Data.length); %���ɳ�ʼ��Ⱥ

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chromlength=Data.length;%Ⱦɫ�峤��
Obs=Data.Obs;           %�ϰ�������  �� Data.Obs��ͬ
S_E=Data.S_E;           %��㣬�յ�  ��Data.S_E ��ͬ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Lindex=[];   %ÿ����Ⱥ��ÿ���߶ε�ֱ�߲���a b c   ax+by+c=0
Lindex.abc=[];

for i=1:Data.size
    [Cindex P_Lindex]=check_crossing(Pop.ch(i).x(:,1),Pop.ch(i).x(:,2),chromlength,Obs,S_E); %����Ƿ�·�����Ƿ����ϰ����ཻ
    %Cindex��ʾ���ֽ����ĵ�λ���±�
    while 1-isempty(Cindex)
           [Pop.ch(i).x]=newpop(Pop.ch(i).x,Data,R,chromlength,k,Cindex);   %��������Ⱥ   %��֤�㲻���ϰ�����   
           [Cindex P_Lindex]=check_crossing(Pop.ch(i).x(:,1),Pop.ch(i).x(:,2),chromlength,Obs,S_E);%������Ⱥ����Ƿ��ཻ
%             Cindex
            if 1-isempty(Cindex)          
                [Pop.ch(i).x]=newpop(Pop.ch(i).x,Data,R,chromlength,k,Cindex);    
                [Cindex P_Lindex]=check_crossing(Pop.ch(i).x(:,1),Pop.ch(i).x(:,2),chromlength,Obs,S_E);
            end

    end
     Lindex(i).abc=P_Lindex;
end


[F]=Goals(Pop,S_E,Data.size,chromlength,Obs,Lindex); %����Ŀ�꺯��ֵ
Pop.f=F;

Qop.ch=[];%�ⲿ�浵��
Qop.f=[];
Qop.fitness=[];


%��ʼѭ��
for t=1:MaxIte
     t
     [Pop Qop Pop_Qop]=cal_Fitness(Pop,Qop);%������Ӧ��   
     [Qop]=environmental_sele(Pop,Qop,Pop_Qop,M); %����ѡ��

     if t==MaxIte       
        [NDSet]=sel_NDSet(Qop);  %ѡ���֧�����  
         break;
     else
         [NewQ_ch]=binary_tournament_selection(Qop);  % ������ѡ�� 
         [NewQ_ch]=cross_mutation(NewQ_ch,Data,Obs,S_E,pc,pm,chromlength,k,R);% Ⱦɫ�彻�� ͻ��
         [NewQ_ch]=delete_point(NewQ_ch,Data,chromlength,Obs,S_E,k,R);  %ƽ�����ӣ��д��Ľ���
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%���¸�ֵ
         Q_size=length(NewQ_ch);
         Qop.ch=[];
         
         for q=1:Q_size
              Qop.ch(q).x=NewQ_ch(q).ch;                    %���¸�ֵȾɫ��
         end
         
         Qop.f=Goals(Qop,S_E,Q_size,chromlength,Obs,Lindex); %���¼���Ŀ�꺯��ֵ
         Qop.fitness=[];
     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����Ϊ��ͼ����
S_size=6; %�ܹ����ٸ���
S(1).xy=[1,4;2,4;2,1;1,1;1,4];
S(2).xy=[3,6;4,6;4,3;3,3;3,6];
S(3).xy=[6,4;7,4;7,1;6,1;6,4];
S(4).xy=[8,10;9,10;9,5;8,5;8,10];
% S(5).xy=[12, 12; 12, 14; 19, 14; 19, 12;12,12];
S(5).xy=[10,14;14,14;14,12;10,12;10,14];
S(6).xy=[14,8;18,8;18,6;14,6;14,8];

ND_size=length(NDSet.ch);
% ND_size=Data.size;
for example=1:ND_size;   %�ڼ�����Ⱥ
    if mod(example,4)==1
    P=[Data.S_E(1,:);NDSet.ch(example).x];
    P=[P;Data.S_E(2,:)];
    figure(example);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    for i=1:S_size
        for j=1:4
            plot([S(i).xy(j,1) S(i).xy(j+1,1)],[S(i).xy(j,2) S(i).xy(j+1,2)],'-r');
         hold on; 
        end  
    end
    grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    plot(P(:,1),P(:,2),'.b');
    hold on
    plot(P(:,1),P(:,2),'-b');
    hold on
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

