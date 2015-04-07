function [ frame] = getTime( tempo,tempoinicial,fs )
%[ frame] = getTime( tempo,tempoinicial,fs )
%frame: número de frames para o tempo indicado
%tempo: tempo a converter
%tempoinicial: tempo inicial
%fs: sampling frequency

h=tempo(1);
m=tempo(2);
s=tempo(3);
hi=tempoinicial(1);
mi=tempoinicial(2);
si=tempoinicial(3);
frame=1;

 %hi*3600*1+mi*60*10+si*100 ~= h*3600*1+m*60*10+s*100
while hi*60^0+mi*60^1+si*60^2 ~= h*60^0+m*60^1+s*60^2
    switch si || mi || hi
        case si == 59 && mi ~= 59 
            si=0;
            mi=mi+1;
                        frame=frame+1;

            

        case si == 59 && mi == 59 && hi ~= 23
            si=0;
            mi=0;
            hi=hi+1;
            frame=frame+60;

        case si == 59 && mi == 59 && hi == 23
            si=0;
            mi=0;
            hi=0;
            frame=frame+1;

        otherwise
            si=si+1;
            frame=frame+1;

    end
end
frame=frame-1;
end
      


