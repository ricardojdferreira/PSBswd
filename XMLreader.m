function [ Eventos,AttachedTo ] = XMLreader(filename,inicio,Fs)
% [ Eventos,AttachedTo ] = XMLreader(filename,inicio,Fs)
%Eventos: Matriz de eventos
%AttachedTo: legenda dos canais
%filename: nome do ficheiro
%inicio: [horas minutos segundos]
%Fs: sampling frequency

tic
disp('XMLreader: ON')
disp(filename)

%Importa o ficheiro
fid=fopen(filename);
while ~feof(fid)
    try
        A=fscanf(fid, '%c');
    catch
        continue
    end
end
fclose(fid);

%Procura a string <EventTypeId>S</EventTypeId> para calcular o número de
%eventos
EventTypeId=strfind(A,'<EventTypeId>S</EventTypeId>');
StartTime1=strfind(A,'<StartTime>');
StartTime2=strfind(A,'</StartTime>');
EndTime1=strfind(A,'<EndTime>');
EndTime2=strfind(A,'</EndTime>');
nEventos=size(EventTypeId,2);

%Criação da matriz para alojar os dados
Eventos=zeros(nEventos,10);

%Legenda dos canais
AttachedTo=char(zeros(nEventos,5));

for i=1:nEventos
    
    %A primeira coluna é o id
    Eventos(i,1)=i;
    
    %A segunda coluna identifica o canal
    for letracanal=48:52
        Eventos(i,2)=Eventos(i,2)+A(EventTypeId(i)+letracanal)*10^(letracanal-48);
        AttachedTo(i,letracanal-47)=A(EventTypeId(i)+letracanal);
    end
    
    %Da terceira à sexta tem-se horas minutos segundos frames iniciais
    tempoinicial=strsplit(A(StartTime1(i)+22:StartTime2(i)-1),':');
    Eventos(i,3)=str2num(cell2mat(tempoinicial(1)));%Horas
    Eventos(i,4)=str2num(cell2mat(tempoinicial(2)));%Minutos
    Eventos(i,5)=floor(str2num(cell2mat(tempoinicial(3))));%Segundos
    if Eventos(i,5)== 0
        Eventos(i,5) = 1;
        Eventos(i,6)=getTime(Eventos(i,3:5),inicio,Fs)-Fs;
    else
        Eventos(i,6)=getTime(Eventos(i,3:5),inicio,Fs);
    end
    %     disp('passou aqui')
    %     disp('inicio')
    %     disp(i)
    %     disp('--')
    
    %Da sétima à décima tem-se horas minutos segundos frames finais
    tempofinal=strsplit(A(EndTime1(i)+20:EndTime2(i)-1),':');
    Eventos(i,7)=str2num(cell2mat(tempofinal(1)));%Horas
    Eventos(i,8)=str2num(cell2mat(tempofinal(2)));%Minutos
    Eventos(i,9)=ceil(str2num(cell2mat(tempofinal(3))));%Segundos
    if Eventos(i,9)== 0
        Eventos(i,9) = 1;
        Eventos(i,9)=getTime(Eventos(i,3:5),inicio,Fs)-Fs;
    else
        Eventos(i,10)=getTime(Eventos(i,7:9),inicio,Fs);
    end
    %          disp('fim')
    %         disp(i)
    %         disp('--')
end

toc
disp('XMLreader: OFF')
end

