function [Pop]=newpop(Pop,Data,R,chromlength,k,index); %���ɲ����ϰ���ĵ�

[Pop]=newpoint(Pop,Data,R,chromlength,k,index); %�����������
[index]=check_in(Pop,Data);                     %���ж��Ƿ����ϰ�����


%ѭ�����֪���㲻���ϰ�����
while 1-isempty(index)   
    [Pop]=newpoint(Pop,Data,R,chromlength,k,index); %�����µ�  ���ǲ�֪���Ƿ����ϰ�����
    [index]=check_in(Pop,Data);                      
end