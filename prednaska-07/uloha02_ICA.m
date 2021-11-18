clear; clc; close all;

%nacteni souboru
load("foetalECG.mat")
X = foetal_ecg';

% Pozn:
% Prvni senzor je kalibrace? (neni dulezity)
% Posledni tri senzory jsou na hrudniku matky.
% Zbyle na brise
eegplot(X, 'title', 'Zaruseny signal')

W = efica(X, eye(size(X,1)));

Y = W*X;

% Metodou pokus-omyl tipnu, co je srdce ditete, srdce matky a sum
Y1 = Y;
Y1(1,:)=0; % sum
Y1(2,:)=0; % matka
Y1(3,:)=0; % matka
% Y1(4,:)=0; % dite
Y1(5,:)=0; % sum
% Y1(6,:)=0; % dite
Y1(7,:)=0; % matka
Y1(8,:)=0; % matka
Y1(9,:)=0; % matka
XX = inv(W) * Y1;
eegplot(XX, 'title', 'Vycistene EKG')

% souhrn pro prehled
XXX = zeros(3,size(X,2));
XXX(1,:) = X(2,:); % originalni signal ze 2. senzoru
XXX(2,:) = XX(2,:); % 2. senzor
XXX(3,:) = XX(7,:); % 7. senzor
eegplot(XXX, 'title', 'Souhrn 2. orig senzor a 2. a 7. po vycisteni')