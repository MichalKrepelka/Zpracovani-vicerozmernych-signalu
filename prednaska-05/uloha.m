clear; clc; close all;

% nacteni souboru
load('F01_421C0201_BUS.mat')
% X jsou signaly z mikrofonu
% S odpovida "cistemu" signalu (bez ruchu)

N = 128;     % delka okenka
hop = 64;  % posunuti dalsiho okenka
overlap = N - hop;  % prekryv dvou okenek

% prevedu do casove frekvencnio oblasti pomoci stfm
% Note: Nemelo by se pouzit spis mstfm z 1. prednasky?
X_stfm = stft(X(1,:), 'OverlapLength', overlap, 'FFTLength', N, 'Window', rectwin(N));
S_stfm = stft(S(1,:), 'OverlapLength', overlap, 'FFTLength', N, 'Window', rectwin(N));

size(X_stfm) % frekvencni rozliseni(delka fft) x pocet framu(delka)

% na kazde frekvenci spocitam beamformer a aplikuju ho
aux = zeros(size(X_stfm));
for i=1:size(X_stfm, 1)
    C_X = cov(X_stfm(i,:));
    C_SX = cov(S_stfm(i,:), X_stfm(1,:));
    W_MMSE = inv(C_X) * C_SX;
    aux(i,:) = W_MMSE' * X_stfm(i,:); % w'*x = s
end

X_istft = istft(aux, 'OverlapLength', overlap, 'FFTLength', N, 'Window', rectwin(N));
