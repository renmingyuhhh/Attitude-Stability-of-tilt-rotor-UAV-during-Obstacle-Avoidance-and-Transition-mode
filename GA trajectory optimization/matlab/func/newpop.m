function [Pop]=newpop(Pop,Data,R,chromlength,k,index); %生成不在障碍物的点

[Pop]=newpoint(Pop,Data,R,chromlength,k,index); %先生成随机点
[index]=check_in(Pop,Data);                     %再判断是否在障碍物内


%循环检查知道点不在障碍物内
while 1-isempty(index)   
    [Pop]=newpoint(Pop,Data,R,chromlength,k,index); %生成新点  但是不知道是否在障碍物内
    [index]=check_in(Pop,Data);                      
end