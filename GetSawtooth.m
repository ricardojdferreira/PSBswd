function [ t dente ] = GetSawtooth(tensorsawtooths,freq,grau,vectorfreqs,vectoramps,freqs)
%[t dente] = GetSawtooth(tensorsawtooths,freq,grau,vectorfreqs,vectorgraus,freqs)
%t: vector de tempo associado ao dente de serra
%dente: vector associado aos valores do dente de serra
%tensorsawtooths: tensor que contem o conjunto de dentes de serra gerado
%freq: frequ�ncia pretendida para o dente de serra;
%grau: inclina��o pretendida para o dente de serra;
% vectorfreqs: vector com a gama de frequ�ncias utilizada para gerar os
% sawtooths
% vectorgraus: vector com a gama de inclina��es para gerar os sawtooths
%freqs: frequencia de sampling
i = find(vectorfreqs==freq); %determina em que posi��o do vector de frequencias est� a frequ�ncia desejada
j = find(vectoramps==grau); %determina em que posi��o do vetode de amplitudes est� a amplitude desejada

dim = size(tensorsawtooths,3); %dim corresponde ao dobro do tamando do vector que contem os valores do dente de serra
dimN = floor((1/freq - 1/freqs)/(1/freqs)+1); %dimens�o do vector tempo
t = tensorsawtooths(i,j,1:dim/2); %define o vector temporal associado ao dente de serra
t = reshape(t,1,dim/2); %elimina uma dimens�o, tornando o vector temporal numa matriz
t = t(1,1:dimN); %dimens�o do vector tempo
dente = tensorsawtooths(i,j,dim/2+1:dim); %define o vector contendo os valores associados ao dente de serra
dente = reshape(dente,1,dim/2); %elimina um dimens�o, tornando dente numa matriz
dente = dente(1,1:dimN); %dimens�o do vector dente
end

