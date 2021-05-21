clear;clc;

% nacteni souboru
load('F01_421C0201_BUS.mat')

aux = mystft(X(1,:),1024,12,1024,hamming(1024));

%imagesc(log(abs(aux)))