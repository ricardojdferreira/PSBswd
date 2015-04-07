function [e] = testef( filename,horainicial,Fs,fi,ff,di,df,WL,step )
%function [ output_args ] = Untitled5( filename1,filename2,horainicial,Fs,fi,ff,di,df )
e=0;
t0=tic;
filename=num2str(filename);

% Cria pasta
mkdir(filename);

% Carrega o ficheiro
load (strcat('Values',filename,'.mat'));

% Carregar tempos
[eventos, attachedto]=XMLreader(strcat(filename,'events.txt'),horainicial,Fs);

% Criar SW
[SW,vf,vg]=Sawtoothw(fi,ff,di,df,Fs);


a=(ff-fi)*10+1;
b=(df-di)+1;
c=size(eventos,1);
for k=1:c
    q=eventos(k,6);
    w=eventos(k,10);
    mxcorr=cell(a,b);
    for i=1:a
        for j=1:b
            disp('---')
            disp(k)
            disp(i)
            disp(j)
            [t,dente]=GetSawtooth(SW,vf(i),vg(j),vf,vg,128);
            [A]=correlacao2(values(q:w),dente);
            mxcorr{i,j}=A;
            clear dente
            clear A
        end
    end
    
    %encontrar posicoes dos maximos [x y]=ind2sub(size(A),find(A == max(max(A))))
    
    z=strcat('17/mxcorr',num2str(k));
    disp(z)
    save(z,'mxcorr');
    clear mxcorr
    clear A
    clear dente
end
toc(t0)
end

