clear;clc;

% nacteni souboru
load('F01_421C0201_BUS.mat')

m=3;    % pocet filtru
L=16;   % delka filtru

%%% bod 1 ulohy %%%

% dam si za sebe m nahodnych filtru do vektoru
h_tilde = randn(m*L,1);

% pripravim si matici vstupu
Xt_tilde = [];  % bude mit rozmery m*L x length(X)
for i=1:m
    Xi=toeplitz(X(i,1)*eye(L,1),X(i,:));
    Xt_tilde=[Xt_tilde; Xi];
end

% vystup pro bod 1 teto ulohy
y1 = h_tilde' * Xt_tilde;

%%% bod 2 ulohy %%%

% spoctu transformace jednotlivych filtru
hitheta = mydft(h_tilde);   %tohle se lisi
tmp=mydft(h_tilde(1:L));

