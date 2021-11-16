clear; clc; close all;

% nacteni souboru
load('F01_421C0201_BUS.mat')
% X jsou signaly z mikrofonu
% S odpovida "cistemu" signalu (bez ruchu)

N = 128;     % delka okenka
hop = 64;  % posunuti dalsiho okenka
window = rectwin(N); % zvolim stejne okno pro stft i istft

% prevedu do casove frekvencnio oblasti pomoci stfm
X_stftm = sftfm(X, hop, N, window);
S_stftm = sftfm(S, hop, N, window);

% size(X_stfm) % pocet senzoru x frekvencni rozliseni(delka fft) x pocet framu(delka)

% na kazde frekvenci spocitam beamformer a aplikuju ho
aux = zeros(size(X_stftm));
for i=1:size(X_stftm, 2)
    X_f = squeeze(X_stftm(:,i,:));
    S_f = squeeze(S_stftm(:,i,:));

%     C_X = cov(squeeze(X_stftm(:,i,:)));
    C_X = X_f * X_f' / length(X_f);
    C_X_inv = inv(C_X);

%     C_SX = cov(squeeze(S_stftm(:,i,:)), squeeze(X_stftm(:,i,:)));
    C_SX = S_f * X_f' / length(X_f);
    
    W_MMSE = C_X_inv * C_SX;
    aux(:,i,:) = W_MMSE' * X_f; % w'*x = s
end

S_aux = istftm(aux, hop, N, window);

% soundsc(X(1,:), Fs)
soundsc(S_aux(1,:), Fs)
% soundsc(S(1,:), Fs)
