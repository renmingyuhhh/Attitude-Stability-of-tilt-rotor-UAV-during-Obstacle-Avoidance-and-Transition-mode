function  [F]=Goals(Pop,S_E,popsize,chromlength,Obs,Lindex)

[f1]=path_length(Pop,S_E,popsize,chromlength);     %计算路径总长度
[f2]=path_smooth(Pop,S_E,popsize);                 %计算余弦值（光滑度）
[f3]=path_safety(popsize,chromlength,Obs,Lindex);  %计算该路径距离最近障碍物的距离的倒数

F(:,1)=reshape(f1,popsize,1);
F(:,2)=reshape(f2,popsize,1);
F(:,3)=reshape(f3,popsize,1);
