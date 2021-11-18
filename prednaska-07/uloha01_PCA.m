clear; clc; close all;

%nacteni souboru
load("EKG3channels_sinus.mat")

% eegplot(x, 'title', 'Zaruseny signal')

C = x*x'/length(x); 
[V D] = eig(C); 

% Vymazu komponentu s nejmensi energii (1. radek Z)
Z = V'*x; % spoctu vsechny hl. komponenty
Z(1,:)=0;
XX = V' * Z; % transpozice jako inverze (viz slidy)
eegplot(XX, 'title', 'Odstranena komponenta s nejnizsi energii')

% Vymazu komponentu s nejmensi energii (1. sloupec V)
VV = V(:,2:3);
Z = VV'*x; % spoctu hl. komponenty vybrane v predchozim kroku
XX = VV * Z; % transpozice jako inverze (viz slidy)
eegplot(XX, 'title', 'Odstranena komponenta s nejnizsi energii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nejsilnejsi komponenta - je to jen sum
% Z = V'*x; % spoctu vsechny hl. komponenty
% Z(1,:)=0;
% Z(2,:)=0;
% XX = V' * Z; % transpozice jako inverze (viz slidy)
% eegplot(XX, 'title', 'Nejsilnejsi komponenta')

% Dve nejslabsi komponenty - sum a divna amplituda, moc zubate
% Z = V'*x; % spoctu vsechny hl. komponenty
% Z(3,:)=0;
% XX = V' * Z; % transpozice jako inverze (viz slidy)
% eegplot(XX, 'title', 'Dve nejslabsi komponenty')

% Pouze nejslabsi komponenta
Z = V'*x; % spoctu vsechny hl. komponenty
Z(2,:)=0;
Z(3,:)=0;
XX = V' * Z; % transpozice jako inverze (viz slidy)
eegplot(XX, 'title', 'Pouze nejslabsi komponenta')