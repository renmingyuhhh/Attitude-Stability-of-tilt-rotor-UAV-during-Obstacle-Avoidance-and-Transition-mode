function  [F]=Goals(Pop,S_E,popsize,chromlength,Obs,Lindex)

[f1]=path_length(Pop,S_E,popsize,chromlength);     %����·���ܳ���
[f2]=path_smooth(Pop,S_E,popsize);                 %��������ֵ���⻬�ȣ�
[f3]=path_safety(popsize,chromlength,Obs,Lindex);  %�����·����������ϰ���ľ���ĵ���

F(:,1)=reshape(f1,popsize,1);
F(:,2)=reshape(f2,popsize,1);
F(:,3)=reshape(f3,popsize,1);
