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
            C_flag=check_part_cross(intX,intY,j,u,Obs,S_E);%判断两点连线是否与障碍物相交  1代表相交 0代表不相交
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
   [Cindex Lindex]=check_crossing(Pop1(i).ch(:,1),Pop1(i).ch(:,2),DD,Obs,S_E);%检查是否路径段是否与障碍物相交

    while ~isempty(Cindex)           
            [Pop1(i).ch]=newpop(Pop1(i).ch,Data,R,DD,k,Cindex);   %生成新种群      
            [Cindex Lindex]=check_crossing(Pop1(i).ch(:,1),Pop1(i).ch(:,2),DD,Obs,S_E);%对新种群检查是否相交
            
            if ~isempty(Cindex)          
                [Pop1(i).ch]=newpop(Pop1(i).ch,Data,R,DD,k,Cindex);  
                [Cindex Lindex]=check_crossing(Pop1(i).ch(:,1),Pop1(i).ch(:,2),DD,Obs,S_E);
            end          
    end  
    
end





