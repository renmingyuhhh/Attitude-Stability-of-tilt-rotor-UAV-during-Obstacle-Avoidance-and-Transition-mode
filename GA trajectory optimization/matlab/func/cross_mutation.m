function [pop]=cross_mutation(pop,Data,Obs,S_E,pc,pm,chromlength,k,R)    % Ⱦɫ�彻�� ͻ��

%ֻ�б������Ҫ������ϰ���֮��Ĺ�ϵ
%�������
py=size(pop(1).ch,1);
px=length(pop);
%px��ʾ��Ⱥ��Ŀ
%py��ʾȾɫ�峤��


%��������֮�䲿�ֽ���任
for i=1:2:px-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    crossp=round(py*rand(1,2));
    for l=1:2
        if crossp(l)==0
            crossp(l)=1;     
        end
    end
    
    while crossp(2)-crossp(1)<=1             %�öβ��������crossp
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

% �������
% ˫�����

for i=1:px
    if rand<pm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         mp=round(py*rand(1,2));
        for l=1:2
            if mp(l)==0
                mp(l)=1;     
            end
        end
    
    while mp(2)-mp(1)<1             %�öβ��������mp
        mp=round(py*rand(1,2));
        for l=1:2
            if mp(l)==0
                mp(l)=1;     
            end
        end     
    end 
        
        [pop(i).ch]=newpop(pop(i).ch,Data,R,chromlength,k,mp); %��������Ⱥ

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    end 
end


%��齻�������·���Ƿ����ϰ����ཻ
for i=1:px
    
   [Cindex Lindex]=check_crossing(pop(i).ch(:,1),pop(i).ch(:,2),chromlength,Obs,S_E);%����Ƿ�·�����Ƿ����ϰ����ཻ

    while ~isempty(Cindex)           
            [pop(i).ch]=newpop(pop(i).ch,Data,R,chromlength,k,Cindex);   %��������Ⱥ      
            [Cindex Lindex]=check_crossing(pop(i).ch(:,1),pop(i).ch(:,2),chromlength,Obs,S_E);%������Ⱥ����Ƿ��ཻ
            
            if ~isempty(Cindex)          
                [pop(i).ch]=newpop(pop(i).ch,Data,R,chromlength,k,Cindex);  
                [Cindex Lindex]=check_crossing(pop(i).ch(:,1),pop(i).ch(:,2),chromlength,Obs,S_E);
            end          
    end  
    
end

