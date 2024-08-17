clc;
clear;
close all;
warning off;
addpath(genpath(pwd));

%设定数据
Data=[];
Data.B=[25 25];           %X轴Y轴边界
Data.S_E=[0,5;20,5.01];     %起点，终点
Data.size=100;             %种群大小
Data.length=30;           %染色体长度
M=round(Data.size/2);     %外部存档集规模
MaxIte=20;                %最大迭代次数

pm=0.3;%变异概率
pc=0.6;%交叉概率
% Obs.S=[];%障碍物各个顶点
Data.Obs(1).S=[1,4;2,4;2,3;1,3];%每个顶点存储按照顺时针顺序排列
Data.Obs(2).S=[3,6;4,6;4,3;3,3];
Data.Obs(3).S=[6,4;7,4;7,2;6,2];
Data.Obs(4).S=[8,6;9,6;9,5;8,5];
Data.Obs(5).S=[10,14;14,14;14,12;10,12];
Data.Obs(6).S=[14,8;18,8;18,6;14,6];
[Pop R k]=intpop(Data,Data.size,Data.length); %生成初始种群

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chromlength=Data.length;%染色体长度
Obs=Data.Obs;           %障碍物坐标  与 Data.Obs相同
S_E=Data.S_E;           %起点，终点  与Data.S_E 相同
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Lindex=[];   %每个种群中每个线段的直线参数a b c   ax+by+c=0
Lindex.abc=[];

for i=1:Data.size
    [Cindex P_Lindex]=check_crossing(Pop.ch(i).x(:,1),Pop.ch(i).x(:,2),chromlength,Obs,S_E); %检查是否路径段是否与障碍物相交
    %Cindex表示出现交叉点的点位置下标
    while 1-isempty(Cindex)
           [Pop.ch(i).x]=newpop(Pop.ch(i).x,Data,R,chromlength,k,Cindex);   %生成新种群   %保证点不在障碍物内   
           [Cindex P_Lindex]=check_crossing(Pop.ch(i).x(:,1),Pop.ch(i).x(:,2),chromlength,Obs,S_E);%对新种群检查是否相交
%             Cindex
            if 1-isempty(Cindex)          
                [Pop.ch(i).x]=newpop(Pop.ch(i).x,Data,R,chromlength,k,Cindex);    
                [Cindex P_Lindex]=check_crossing(Pop.ch(i).x(:,1),Pop.ch(i).x(:,2),chromlength,Obs,S_E);
            end

    end
     Lindex(i).abc=P_Lindex;
end


[F]=Goals(Pop,S_E,Data.size,chromlength,Obs,Lindex); %计算目标函数值
Pop.f=F;

Qop.ch=[];%外部存档集
Qop.f=[];
Qop.fitness=[];


%开始循环
for t=1:MaxIte
     t
     [Pop Qop Pop_Qop]=cal_Fitness(Pop,Qop);%计算适应度   
     [Qop]=environmental_sele(Pop,Qop,Pop_Qop,M); %环境选择

     if t==MaxIte       
        [NDSet]=sel_NDSet(Qop);  %选择非支配个体  
         break;
     else
         [NewQ_ch]=binary_tournament_selection(Qop);  % 锦标赛选择 
         [NewQ_ch]=cross_mutation(NewQ_ch,Data,Obs,S_E,pc,pm,chromlength,k,R);% 染色体交叉 突变
         [NewQ_ch]=delete_point(NewQ_ch,Data,chromlength,Obs,S_E,k,R);  %平滑算子（有待改进）
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%重新赋值
         Q_size=length(NewQ_ch);
         Qop.ch=[];
         
         for q=1:Q_size
              Qop.ch(q).x=NewQ_ch(q).ch;                    %重新赋值染色体
         end
         
         Qop.f=Goals(Qop,S_E,Q_size,chromlength,Obs,Lindex); %重新计算目标函数值
         Qop.fitness=[];
     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%以下为画图程序
S_size=6; %总共多少个点
S(1).xy=[1,4;2,4;2,1;1,1;1,4];
S(2).xy=[3,6;4,6;4,3;3,3;3,6];
S(3).xy=[6,4;7,4;7,1;6,1;6,4];
S(4).xy=[8,10;9,10;9,5;8,5;8,10];
% S(5).xy=[12, 12; 12, 14; 19, 14; 19, 12;12,12];
S(5).xy=[10,14;14,14;14,12;10,12;10,14];
S(6).xy=[14,8;18,8;18,6;14,6;14,8];

ND_size=length(NDSet.ch);
% ND_size=Data.size;
for example=1:ND_size;   %第几个种群
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

