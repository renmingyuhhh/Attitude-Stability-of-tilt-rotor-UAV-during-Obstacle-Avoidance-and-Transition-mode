function [Pop1]=delete_point(Pop1,Data,chromlength,Obs,S_E,k,R)  


popsize=length(Pop1);
DD=chromlength;
chromlength=chromlength+2;


for i=1:popsize
    Pop2=Pop1(i).ch;
    Pop2=[S_E(1,:);Pop2];
    Pop2=[Pop2;S_E(2,:)];
    
    intX=Pop2(:,1);
    intY=Pop2(:,2);
    
    j=1;
    while j<=chromlength-3 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        index=[];
        A=[];
        for u=j+2:j+3
            C_flag=check_part_cross(intX,intY,j,u,Obs,S_E);%�ж����������Ƿ����ϰ����ཻ  1�����ཻ 0�����ཻ
            if C_flag==0 
                A=[A;u]; 
            end
        end
        c=length(A);
        if c~=0
            index=[j A(c)];
            [Pop2]=d_newpoint(Pop2,Data,index,chromlength,k);
        end
        j=j+1;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    Pop1(i).ch=Pop2(2:chromlength-1,:);
end


for i=1:popsize
   [Cindex Lindex]=check_crossing(Pop1(i).ch(:,1),Pop1(i).ch(:,2),DD,Obs,S_E);%����Ƿ�·�����Ƿ����ϰ����ཻ

    while ~isempty(Cindex)           
            [Pop1(i).ch]=newpop(Pop1(i).ch,Data,R,DD,k,Cindex);   %��������Ⱥ      
            [Cindex Lindex]=check_crossing(Pop1(i).ch(:,1),Pop1(i).ch(:,2),DD,Obs,S_E);%������Ⱥ����Ƿ��ཻ
            
            if ~isempty(Cindex)          
                [Pop1(i).ch]=newpop(Pop1(i).ch,Data,R,DD,k,Cindex);  
                [Cindex Lindex]=check_crossing(Pop1(i).ch(:,1),Pop1(i).ch(:,2),DD,Obs,S_E);
            end          
    end  
    
end





