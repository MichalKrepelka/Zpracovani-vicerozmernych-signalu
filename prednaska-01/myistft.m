function X = myistft(S, N, hop, FFTLength, W)
%Implementace inverzni STFT
%----
%   Vraci rekonstruovany signal
%   Vstup:
%   S : matice z stft
%   N : Delka FT/okenka
%   hop: Posunuti okenka
%   FFTLength :  Delka FFT (protoze padding nulami)
%   W : okenkovaci funkce
%---------------------------------------------------------------

noFrames = size(S,2);
Xlen = noFrames*hop+(N-hop);
X = zeros(1, Xlen);

for m=0:noFrames-1
    Xs = S(:,m+1).';      % zpracovavam po framech, pozor, je to sloupec ne radek => transpozice
    Xf = ifft(Xs, FFTLength, 'symmetric');       % provedu inverzni fft
    Xw = Xf .* W';      % zokenkuju (synthesis window)
    
    % Normalizace z clanku. Problem je ve spatne normalizaci na zacatku
    % resp. na konci. Dochazi k utlumu.
    % Xw = Xw * (hop / sum(W));
    
    X(1+m*hop:m*hop+N) = X(1+m*hop:m*hop+N) + Xw; % prictu pres overlap
end

% alternativni normalizace pro perfektni rekonstrukci
% resi situaci, kdy se kvuli hopu pricitaji overlapy na zacatku a na konci
% min nez N/hop krat.
for i=0:(Xlen/hop-1)
    if i < N/hop
        div_norm = (i+1);
    elseif i > Xlen/hop - N/hop -1
        div_norm = -1 * (i - (Xlen/hop));
    else
        div_norm = (N/hop);
    end
    X(1+i*hop:i*hop+hop) = X(1+i*hop:i*hop+hop) / div_norm;
end