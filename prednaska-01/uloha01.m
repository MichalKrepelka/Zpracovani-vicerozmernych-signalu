clear;clc;

% nacteni souboru
load('F01_421C0201_BUS.mat')

N = 1024;     % delka okenka
hop = 128;  % posunuti dalsiho okenka
overlap = N - hop;  % prekryv dvou okenek

X = X(:,1:4096);

% Zbynek pouziva hop, Matlab overlap
aux = mystft(X(1,:), N, hop, N, hamming(N));
figure
imagesc(log(abs(aux)))

aux = stft(X(1,:), 'OverlapLength', overlap, 'FFTLength', N, 'Window', hamming(N));
figure
imagesc(log(abs(aux)))