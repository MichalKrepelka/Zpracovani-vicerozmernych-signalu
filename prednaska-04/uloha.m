clear; clc; close all;

m = 4;  % pocet senzoru

% budu mit ULA, tj. ve 2D
P = zeros(2,m); % pripravim si polohu senzoru (vektor z pocatku)
for i=1:m
    P(1, i) = 0.05 * (i-1); % dam od sebe senzory 5 cm
end

% Nastavim beamformer, tj. M1,...,Mm
% M = (m:-1:1) ./ m; % zpozdeni po m-tinach
% M = (1:m);
% M = randn(1,m);
M = zeros(1,m); % nej prjem z primeho smeru

% Zvolim parametry
fs = 16e3;  % vzorkovaci frekvence (Hz)
c = 343;    % Rychlost sireni signalu (= cca rychlost zvuku) (m/s)

% Zakresli magnitudovou charakteristiku prenosove funkce v zavislosti na
% uhlu sireni signalu pro zvolenou frekvenci
theta = 3000; % zvolena frekvence 1kHz
theta = 2 * pi * theta / fs; % normalizace - vydelenim fs ziskam bezrozmerovou velicinu 

rad = pi / 180; % Neni lepsi 2pi vydelit Fs?
alpha_ticks = 0:rad:2*pi-rad; % vsechny uhly pro zavislost, odcitam, abych mel 360

% vektor ma jednotkovou delku a znam uhel alfa
u = [1 * cos(alpha_ticks); 1 * sin(alpha_ticks)];

D = (u' * P / c) * fs; % posunuti - vynasobenim fs ziskam bezrozmerovou velicinu

% Prenosova funkce
H = zeros(size(D, 1), 1);
for i=1:m
    H = H + exp(-1i * theta * (D(:, i) - M(i)));
end
H = (1/m) * H;

% Vykresleni
figure
plot(alpha_ticks, abs(H'))

figure
polarplot(alpha_ticks, abs(H'))