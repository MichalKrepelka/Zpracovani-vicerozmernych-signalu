clear;clc;

% nacteni souboru
load('F01_421C0201_BUS.mat')

% prvnim radkem je signal samotny
% prvnim sloupcem je prvni hodnota a same nuly
X1=toeplitz(X(1,1)*eye(5,1),X(1,:));

% vyrobim filtr nahdny delky 5, ptz toeplitzovka ma 5 radku
h=randn(5,1);

%vystup
y=h'*X1;

% vykreslim
%plot(y)
%hold on

% porovnam s matlabovskym filterem
% FIR cast h, 1 tj. zadna zpetna vazba, vstup je1. radek
%plot(filter(h,1,X(1,:)))



%%%% MISO na dvou signalech

% k X1 si vyrobim X2
X2=toeplitz(X(2,1)*eye(5,1),X(2,:));

% nahodny filtr delky 5 se dvema vstupz
h=randn(10,1);

% Vyrobim si velkou matici X (oznacoim XX kvuli schode nazvu - viz data)
XX = [X1; X2];

% vystup
y=h'*XX;

plot(y)
hold on

% zkontroluji s matlabovskou implementaci
plot(filter(h(1:5),1,X(1,:)) + filter(h(6:10),1,X(2,:)))

