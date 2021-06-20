clear; clc; close all;

% nacteni souboru
load('F01_421C0201_BUS.mat')

N = 1024;     % delka okenka
hop = 128;  % posunuti dalsiho okenka
overlap = N - hop;  % prekryv dvou okenek

X = X(:,1:4096);

% aux = mystft(X(1,:), N, hop, N, hamming(N));
% Xorig = myistft(aux, N, hop, N, hamming(N));
aux = mystft(X(1,:), N, hop, N, rectwin(N));
Xorig = myistft(aux, N, hop, N, rectwin(N));

% podle matlabu
% aux2 = stft(X(1,:), 'OverlapLength', overlap, 'FFTLength', N, 'Window', hamming(N));
% Xorig2 = istft(aux2, 'OverlapLength', overlap, 'FFTLength', N, 'Window', hamming(N));
aux2 = stft(X(1,:), 'OverlapLength', overlap, 'FFTLength', N, 'Window', rectwin(N));
Xorig2 = istft(aux2, 'OverlapLength', overlap, 'FFTLength', N, 'Window', rectwin(N));

plot(X(1,:))
hold on
plot(Xorig)
% hold on
% plot(Xorig2')
legend('Puvodni signal','Moje stft-istft','Matlab stft-istft')