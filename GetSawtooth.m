function [ t dente ] = GetSawtooth(tensorsawtooths,freq,grau,vectorfreqs,vectoramps,freqs)
%[t dente] = GetSawtooth(tensorsawtooths,freq,grau,vectorfreqs,vectorgraus,freqs)
%t: vector de tempo associado ao dente de serra
%dente: vector associado aos valores do dente de serra
%tensorsawtooths: tensor que contem o conjunto de dentes de serra gerado
%freq: frequência pretendida para o dente de serra;
%grau: inclinação pretendida para o dente de serra;
% vectorfreqs: vector com a gama de frequÊncias utilizada para gerar os
% sawtooths
% vectorgraus: vector com a gama de inclinações para gerar os sawtooths
%freqs: frequencia de sampling
i = find(vectorfreqs==freq); %determina em que posição do vector de frequencias está a frequência desejada
j = find(vectoramps==grau); %determina em que posição do vetode de amplitudes está a amplitude desejada

dim = size(tensorsawtooths,3); %dim corresponde ao dobro do tamando do vector que contem os valores do dente de serra
dimN = floor((1/freq - 1/freqs)/(1/freqs)+1); %dimensão do vector tempo
t = tensorsawtooths(i,j,1:dim/2); %define o vector temporal associado ao dente de serra
t = reshape(t,1,dim/2); %elimina uma dimensão, tornando o vector temporal numa matriz
t = t(1,1:dimN); %dimensão do vector tempo
dente = tensorsawtooths(i,j,dim/2+1:dim); %define o vector contendo os valores associados ao dente de serra
dente = reshape(dente,1,dim/2); %elimina um dimensão, tornando dente numa matriz
dente = dente(1,1:dimN); %dimensão do vector dente
end

