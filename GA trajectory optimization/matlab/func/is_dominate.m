function flag=is_dominate(ind1,ind2)     %判断是否支配
F1=ind1;
F2=ind2;

V=size(F1,2);
dom_less = 0; 
dom_equal = 0; 
dom_more = 0; 
        
                

 for k = 1 : V
     if F1(1,k)  <  F2(1,k) 
         dom_less = dom_less + 1; 
     elseif F1(1,k)  ==  F2(1,k)
         dom_equal = dom_equal + 1; 
     else 
         dom_more = dom_more + 1; 
     end 
 end 
            
 if dom_more == 0 & dom_equal ~= V     % j 支配 i  i解好
     flag=1;
 else
     flag=0;
 end
  