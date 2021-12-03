clear; clc; close all;

% nacteni souboru
load('F01_421C0201_BUS.mat')

m=size(X,1);    % pocet filtru
L=16;   % delka filtru

% inicializace generatoru nahodnych cisel
rng('default');
rng(33);

%%% bod 1 ulohy %%%

% pripravim si m nahodnych filtru delky L
h = randn(m, L);

% dam si za sebe m nahodnych filtru do vektoru
h_tilde = h';
h_tilde = h_tilde(:); % oprator : spoji sloupce matice do sloupcoveho vektoru

% pripravim si matici vstupu
Xt_tilde = [];  % bude mit rozmery m*L x length(X)
for i=1:m
    Xi=toeplitz(X(i,1)*eye(L,1),X(i,:));
    Xt_tilde=[Xt_tilde; Xi];
end

% vystup pro bod 1 teto ulohy
Y1 = h_tilde' * Xt_tilde;

%%% bod 2 ulohy %%%

% vlozim si stftm a istftm z 5. prednasky
addpath(genpath("../prednaska-05"));

N = 1024;   % delka okenka odpovida delce filtru
hop = 128;  % posunuti dalsiho okenka
window = rectwin(N); % zvolim stejne okno pro stft i istft

% spoctu transformace jednotlivych filtru h_i
h_theta = zeros(m, N);
for i=1:size(h,1)
    h_theta(i,:) = fft(h(i,:), N);
end

% prevedu X do casove frekvencnio oblasti pomoci stfm
X_theta = stftm(X, hop, N, window); % 6x16x56666

% pro kazde theta spoctu radek Y
M = size(X_theta,3); % pocet framu

Y_theta = zeros(N, M);
for i=1:N %size(X_theta,2)
    x = squeeze(X_theta(:,i,:));
    y = h_theta(:,i).' * x; % h_theta je komplexni
    Y_theta(i,:) = y;
end
Y2 = reshape(Y_theta, 1, N, M); % 1 x size(Y_theta)
% prevedu zpet
Y2 = real(istftm(Y2, hop, N, window));

%%% bod 3 ulohy %%%
% Vystupy nebudou stejne, ptz bod 1 byl udelan linearni konvoluci
% a bod 2 kruhovou, navic pouzito framovani
figure
plot(Y1)
hold on
plot(Y2)
legend('Y1','Y2')
