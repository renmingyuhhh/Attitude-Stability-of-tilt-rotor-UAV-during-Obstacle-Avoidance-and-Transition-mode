function [pop]=cross_mutation(pop,Data,Obs,S_E,pc,pm,chromlength,k,R)    % 染色体交叉 突变

%只有变异才需要检查与障碍物之间的关系
%交叉操作
py=size(pop(1).ch,1);
px=length(pop);
%px表示种群数目
%py表示染色体长度


%采用两点之间部分交叉变换
for i=1:2:px-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    crossp=round(py*rand(1,2));
    for l=1:2
        if crossp(l)==0
            crossp(l)=1;     
        end
    end
    
    while crossp(2)-crossp(1)<=1             %该段产生交叉点crossp
        crossp=round(py*rand(1,2));
        for l=1:2
            if crossp(l)==0
                crossp(l)=1;     
            end
        end     
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
         if rand<=pc          
            temp1=pop(i).ch(crossp(1)+1:crossp(2)-1,:);
            temp2=pop(i+1).ch(crossp(1)+1:crossp(2)-1,:);
            pop(i+1).ch(crossp(1)+1:crossp(2)-1,:)=temp1;
            pop(i).ch(crossp(1)+1:crossp(2)-1,:)=temp2;

         end
         
         
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 变异操作
% 双点变异

for i=1:px
    if rand<pm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         mp=round(py*rand(1,2));
        for l=1:2
            if mp(l)==0
                mp(l)=1;     
            end
        end
    
    while mp(2)-mp(1)<1             %该段产生变异点mp
        mp=round(py*rand(1,2));
        for l=1:2
            if mp(l)==0
                mp(l)=1;     
            end
        end     
    end 
        
        [pop(i).ch]=newpop(pop(i).ch,Data,R,chromlength,k,mp); %生成新种群

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    end 
end


%检查交叉变异后的路径是否与障碍物相交
for i=1:px
    
   [Cindex Lindex]=check_crossing(pop(i).ch(:,1),pop(i).ch(:,2),chromlength,Obs,S_E);%检查是否路径段是否与障碍物相交

    while ~isempty(Cindex)           
            [pop(i).ch]=newpop(pop(i).ch,Data,R,chromlength,k,Cindex);   %生成新种群      
            [Cindex Lindex]=check_crossing(pop(i).ch(:,1),pop(i).ch(:,2),chromlength,Obs,S_E);%对新种群检查是否相交
            
            if ~isempty(Cindex)          
                [pop(i).ch]=newpop(pop(i).ch,Data,R,chromlength,k,Cindex);  
                [Cindex Lindex]=check_crossing(pop(i).ch(:,1),pop(i).ch(:,2),chromlength,Obs,S_E);
            end          
    end  
    
end

