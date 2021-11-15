clear; clc; close all;

% nacteni souboru
load('F01_421C0201_BUS.mat')
% X jsou signaly z mikrofonu
% S odpovida "cistemu" signalu (bez ruchu)

N = 128;     % delka okenka
hop = 64;  % posunuti dalsiho okenka
window = rectwin(N); % zvolim stejne okno pro stft i istft

% prevedu do casove frekvencnio oblasti pomoci stfm
X_stfm = sftfm(X, hop, N, window);
Xorig = istftm(X_stfm, hop, N, window);


figure
plot(X(1,:))
hold on
plot(Xorig(1,:))
legend('Puvodni signal', 'stftm-istftm')