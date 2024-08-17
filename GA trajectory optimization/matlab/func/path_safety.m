 function [f3]=path_safety(popsize,chromlength,Obs,Lindex) 

%��ȫ���ܣ�1/d����d��ʾ·���о��������ϰ���ĵ���̾���  

M=length(Obs);              %MΪ�ϰ������
 for i=1:popsize                %��Ⱥ��Ŀ
     d2=zeros(1,chromlength+1);
    for j=1:chromlength+1       %jΪ·����ֱ����Ŀ           
        d1=[];
        for k=1:M                   
            N=size(Obs(k).S,1);  %NΪ�ϰ���˵���
            A=zeros(1,N);

            for t=1:N
               A(t)=abs(Obs(k).S(t,1)*Lindex(i).abc(j).a+Obs(k).S(t,2)*Lindex(i).abc(j).b+Lindex(i).abc(j).c)/sqrt(Lindex(i).abc(j).a^2+Lindex(i).abc(j).b^2);         
            end
              d1(k)=min(A);        %��k���ϰ�����뱾��·���εľ���            
        end  
        d2(j)=min(d1);
    end
     d=min(d2);
     f3(i)=1/d;
end