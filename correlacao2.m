function [ c ] = correlacao2( signal1,signal2 )
%[ c ] = Correlacao( signal1,signal2,WL,step,Fs )


    x=xcorr(signal1,signal2);
    a=length(signal1);
    b=length(signal2);
    c=zeros(1,a-b+1);
    c(1,1:end)=x(1,a:a+length(c)-1);
    %del=0:1:length(c)-1;
    

end




