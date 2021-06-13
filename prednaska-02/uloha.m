clear; clc; close all;

d = 10;     % pocet signalu
N = 1024;   % delka signalu
A = randn(d,d); % nahodna matice zeslabeni signalu

% 1. vygeneruju umely signal podle iid modelu
S = randn(d,N); % Cs=I, tj. nulova stredni hodnota

% 2. Pozorovani signalu
X = A * S;

% 3. Odhad kovariancni matice Cx a porovnani se skutecnou (teoretickou, analytickou) 
% matici (prumer pres vzorky)
Cx_estimated = cov(X'); % Transpozice, ptz nas zajima korelace signalu ze senzoru (v radcich)
                        % cim vic vzorku N, tim presnejsi odhad
Cx_analytic = A*eye(d)*A';  % viz. odvozeni. eye(d), protoze pri generovani platilo Cs=I

% teplota bodu odpovida hodnote
% identicke az na odchylku 
imagesc(Cx_estimated)
figure
imagesc(Cx_analytic)

% chyba odhadu a analytickeho vyjadreni
err = sum(sum((Cx_analytic - Cx_estimated)^2))





