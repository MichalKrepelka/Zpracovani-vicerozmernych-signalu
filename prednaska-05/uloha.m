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
S_stfm = sftfm(S, hop, N, window);

% size(X_stfm) % pocet senzoru x frekvencni rozliseni(delka fft) x pocet framu(delka)

% na kazde frekvenci spocitam beamformer a aplikuju ho
aux = zeros(size(X_stfm));
for i=1:size(X_stfm, 2)
    C_X = cov(squeeze(X_stfm(i,:,:)));
    C_X_inv = inv(C_X);
    C_SX = cov(squeeze(S_stfm(i,:,:)), squeeze(X_stfm(i,:,:)));
    W_MMSE = C_X_inv * C_SX;
    aux(i,:,:) = W_MMSE' * squeeze(X_stfm(i,:,:)); % w'*x = s
end

% X_istft = istft(aux, 'OverlapLength', overlap, 'FFTLength', N, 'Window', rectwin(N));
