clear; clc; close all;

%nacteni souboru
load("EKG3channels_sinus.mat")

eegplot(x, 'title', 'Zaruseny signal')

W = efica(x, eye(3));

Y = W*x;

% Vymazu 1 a 2 komponentu - 3. komponenta pravdepodobne obsahuje uzitecny signal
Y1 = Y;
Y1(1:2,:)=0;
XX = inv(W) * Y1;
eegplot(XX, 'title', 'Komponenta 3')

% Vymazu 2 a 3 komponentu -  zustava jen sum
% Y2 = Y;
% Y2(2:end,:)=0;
% XX = inv(W) * Y2;
% eegplot(XX, 'title', 'Komponenta 1')

% Vymazu 1 a 3 komponentu
Y3 = Y;
Y3(1,:)=0;
Y3(3,:)=0;
XX = inv(W) * Y3;
eegplot(XX, 'title', 'Komponenta 2')

% Vymazu pouze 1
Y4 = Y;
Y4(1,:)=0;
XX = inv(W) * Y4;
eegplot(XX, 'title', 'Komponenta 2 a 3')