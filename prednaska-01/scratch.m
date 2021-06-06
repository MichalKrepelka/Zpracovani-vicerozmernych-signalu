clear; clc; close all;

% nacteni souboru
load('F01_421C0201_BUS.mat')

N = 1024;     % delka okenka
hop = 128;  % posunuti dalsiho okenka
overlap = N - hop;  % prekryv dvou okenek

X = X(:,1:4096);

aux = mystft(X(1,:), N, hop, N, hamming(N));
Xorig = myistft(aux, N, hop, N, hamming(N));

figure
imagesc(abs(X(1,:)))

figure
imagesc(abs(Xorig))

% podle matlabu
aux2 = stft(X(1,:), 'OverlapLength', overlap, 'FFTLength', N, 'Window', hamming(N));
Xorig2 = istft(aux, 'OverlapLength', overlap, 'FFTLength', N, 'Window', hamming(N));
figure
imagesc(abs(Xorig2'))