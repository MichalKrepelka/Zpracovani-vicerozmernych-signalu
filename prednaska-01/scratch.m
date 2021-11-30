clear; clc; close all;

% nacteni souboru
load('F01_421C0201_BUS.mat')

N = 1024;     % delka okenka
hop = 128;  % posunuti dalsiho okenka
overlap = N - hop;  % prekryv dvou okenek

% pro zjednoduseni delam jen na prvnich 4096 vzorcich
X = X(:,1:4096);

% moje stft-istft
aux = mystft(X(1,:), N, hop, N, rectwin(N));
Xorig = myistft(aux, N, hop, N, rectwin(N));

% podle matlabu
% aux2 = stft(X(1,:), 'OverlapLength', overlap, 'FFTLength', N, 'Window', rectwin(N));
% Xorig2 = istft(aux2, 'OverlapLength', overlap, 'FFTLength', N, 'Window', rectwin(N));

figure
plot(X(1,:))
hold on
plot(Xorig)
% hold on
% plot(Xorig2')
legend('Puvodni signal','Moje stft-istft','Matlab stft-istft')