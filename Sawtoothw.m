function [res vectorfreqs vectorgraus] = Sawtoothw(freqmin, freqmax, graumin,graumax, freqs)
% [res vectorfreqs vectorgraus] = Sawtoothw(freqmin, freqmax,graumin, graumax, freqs)
% res: tensor que contem o conjunto de sawtooths gerados
% vectorfreqs: vector com a gama de frequ�ncias utilizada para gerar os
% sawtooths
% vectorgraus: vector com a gama de inclina��es para gerar os sawtooths
%freqmin: frequ�ncia minima para a constru��o dos sawtooths
%freqmax: frequ�ncia m�xima para a constru��o dos sawtooths
%graumin: inclinal�o minima para a constru��o dos sawtooths
%graumax: inclina��o m�xima para a cosntru�a� dos sawtooths
%freqs: frequ�ncia de sampling do sinal
vectorfreqs = freqmin:0.1:freqmax; %cria um vector com valores entre a freqmin e a freqmax
%declivemin = tan((graumin*pi)/180);
%declivemax = tan((graumax*pi)/180);
vectorgraus = graumin:graumax; % cria um vector com valores entre o slopemin e o slopemax
dimN = round((1/freqmin - 1/freqs)/(1/freqs)+1); % gera a dimenss�o do vector tempo
tensorsawtooths = zeros(length(vectorfreqs),length(vectorgraus),dimN*2); % tensor que ir� armazenar os dentes de serra

for i = 1:length(vectorfreqs)
    T = 1/vectorfreqs(i);   % constru��o do vector tempo
    t = (0:1/freqs:T-1/freqs);
    zeroM = zeros(1, dimN-length(t)); % matriz de zeros que se funde com o vector tempo caso este seja de dimens�o inferior a dimN
    tcat = cat(2,t,zeroM); % junta as matrizes t e zeroM segundo a segunda direc��o
    
    for j = 1:length(vectorgraus)  
        s = sawtooth(t/(2*pi));% gera o dente de serra associado ao vector tempo definido pela freq i
        %%%%Normaliza��o do declive
        t1 = t(1,10);
        t2 = t(1,20);
        s1 = s(1,10);
        s2 = s(1,20);
        deltat = t2 - t1;
        deltas = s2 - s1;
        declive = deltas/deltat;
        s = s / declive; 
        %%%%
        s = s*tan((vectorgraus(j)*pi)/180); % define a inclina��o do dente
        s = s +abs(s(1,round(length(s)/2))); % define o integral do dente como sendo 0;
        s = cat(2,s,zeroM); % junta as matrizes s e zeroM segundo a dire��o 2
        tensorsawtooths(i,j,:) = [tcat s]; % insere no tensor os vectores tempo e sawtooth associados a frequencia i e ao declive j
    end
    
end
res = tensorsawtooths;
end

