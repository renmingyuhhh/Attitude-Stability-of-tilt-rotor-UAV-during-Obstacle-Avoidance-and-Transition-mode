function [Mop]=binary_tournament_selection(Pop)

pool_size=round(length(Pop.fitness)/2);

m = length(Pop.fitness); 

%第一部分  二元锦标赛选择 Pop 部分
for i = 1 : pool_size 
    for j = 1 : 2 
        candidate(j) = round(m*rand(1)); %每次选择都产一组candidate-----随机选则的数列
        if candidate(j) == 0 
            candidate(j) = 1; 
        end 
        
        if j > 1 
            while ~isempty(find(candidate(1 : j - 1) == candidate(j))) % 检查是否有重复的位数-----拿出不放回的实验
                candidate(j) = round(m*rand(1)); 
                if candidate(j) == 0 
                    candidate(j) = 1; 
                end 
            end 
        end 
    end 
    
    
%      candidate
   
  %锦标赛选择操作  
  if Pop.fitness(candidate(1)) <  Pop.fitness(candidate(2))
      index=candidate(1);
  else
      index=candidate(2);    
  end
     Mop(i).ch=Pop.ch(index).x;
end

