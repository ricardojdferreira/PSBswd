function [ values,frame] = ReadandFilt( file,channel,freq_low,freq_high)
%Fun��o que recebe um ficheiro edf e um canal (ambos na forma de strings)
%e responde o sinal desse canal filtrado por um filtro passa baixo com
%frequ�ncia de corte 10 Hz(retira o ru�do de alta frequ�ncia) e por um filtro passa alto com frequ�ncia de corte 0.2 hz(retira o DC).
%Devolve tamb�m um vector de frames para se fazer a correspond�ncia com o
%XML reader
[hdr,record]=edfread(file);%l� o ficheiro edf
ind=find(ismember(hdr.label,channel));%guarda o n�mero da linha do edf onde est� o canal pedido
fs=hdr.samples(ind)/hdr.duration;%guarda o sampling rate
dat=record(ind,:);%tira os valores do canal correspondente
%divide as horas,minutos e segundos do start time em 3 cells
tempoinicialintmat=zeros(1,3);
tempoinicial=strsplit(hdr.starttime,'.');%inicia a matriz que ir� conter os a hora, minuto e segundo inicial
tempoinicialintmat(1)=str2num(cell2mat(tempoinicial(1)));%coloca nessa matriz a hora
tempoinicialintmat(2)=str2num(cell2mat(tempoinicial(2)));%coloca nessa matriz o minuto
tempoinicialintmat(3)=str2num(cell2mat(tempoinicial(3)));%coloca nessa matriz o segundo
framein=tempoinicialintmat(1)*3600*fs+tempoinicialintmat(2)*60*fs+tempoinicialintmat(3)*fs;%calcula o frame inicial
frame=zeros(1,length(dat));%forma o vector de frames
frame(1)=framein;%preenche a primeira posi��o do vector de frames com o frame inicial
for i=2:length(dat)
    frame(i)=frame(i-1)+1;%enche o vector de frames
end
[B,A]=butter(10,freq_low/(fs/2),'low');
[B1,A1]=butter(10,freq_high/(fs/2),'high');
values=filtfilt(B,A,dat);%filtragem passa-baixo com dupla passagem(para n�o haver distor��o de fase)
%values=filtfilt(B1,A1,dat);%filtragem passa-alto com dupla passagem(para n�o haver distor��o de fase)

end

