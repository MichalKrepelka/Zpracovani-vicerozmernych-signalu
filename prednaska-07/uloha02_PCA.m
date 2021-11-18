clear; clc; close all;

%nacteni souboru
load("foetalECG.mat")
X = foetal_ecg';

% Pozn:
% Prvni senzor je kalibrace? (neni dulezity)
% Posledni tri senzory jsou na hrudniku matky.
% Zbyle na brise
eegplot(X, 'title', 'Zaruseny signal')

C = X*X'/length(X); 
[V D] = eig(C); 

Z = V'*X; % spoctu vsechny hl. komponenty

% Na senzoru 5 je zda se videt srdce ditete
% Z(1:2,:)=0; 
% Z(8:end,:)=0; 
% XX = V' * Z; % transpozice jako inverze (viz slidy)
% eegplot(XX, 'title', 'Komponenty 3-7')

% Mezi 3-7 a 4-7 neni viditelny rozdil => 3 je sum
% Z(1:3,:)=0;
% Z(8:end,:)=0;
% XX = V' * Z;
% eegplot(XX, 'title', 'Komponenty 4-7')

% Mezi 4-6 a 4-7 je videt rozdil hlavne na senzorech matky => 7 je matka 
Z(1:3,:)=0;
Z(7:end,:)=0;
X1 = V' * Z;
eegplot(X1, 'title', 'Komponenty 4-6')

% 5 signal je ciste srdce ditete, ale prijde mi, ze ztraci detaily
Z(1:4,:)=0; % sum
Z(6:end,:)=0; % matka
X2 = V' * Z;
eegplot(X2, 'title', 'Komponenta 5')

% souhrn pro prehled
XXX = zeros(3,size(X,2));
XXX(1,:) = X(2,:); % originalni signal ze 2. senzoru
XXX(2,:) = X1(5,:); % komponenta 4-6 z 5. senzoru
XXX(3,:) = X2(5,:); % komponenta 5 z 5. senzoru
eegplot(XXX, 'title', 'Souhrn 2. orig senzor a 5. po vycisteni')