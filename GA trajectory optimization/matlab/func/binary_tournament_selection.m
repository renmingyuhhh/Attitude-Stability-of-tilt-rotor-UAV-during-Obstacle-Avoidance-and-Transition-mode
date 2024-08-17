function [Mop]=binary_tournament_selection(Pop)

pool_size=round(length(Pop.fitness)/2);

m = length(Pop.fitness); 

%��һ����  ��Ԫ������ѡ�� Pop ����
for i = 1 : pool_size 
    for j = 1 : 2 
        candidate(j) = round(m*rand(1)); %ÿ��ѡ�񶼲�һ��candidate-----���ѡ�������
        if candidate(j) == 0 
            candidate(j) = 1; 
        end 
        
        if j > 1 
            while ~isempty(find(candidate(1 : j - 1) == candidate(j))) % ����Ƿ����ظ���λ��-----�ó����Żص�ʵ��
                candidate(j) = round(m*rand(1)); 
                if candidate(j) == 0 
                    candidate(j) = 1; 
                end 
            end 
        end 
    end 
    
    
%      candidate
   
  %������ѡ�����  
  if Pop.fitness(candidate(1)) <  Pop.fitness(candidate(2))
      index=candidate(1);
  else
      index=candidate(2);    
  end
     Mop(i).ch=Pop.ch(index).x;
end

