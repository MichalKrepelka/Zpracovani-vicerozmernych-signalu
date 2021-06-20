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
    %Xs = [Xs(1:FFTLength/2), Xs(FFTLength/2+1:FFTLength)];  % prohodim zpet
    Xf = ifft(Xs, FFTLength, 'symmetric');       % provedu inverzni fft
    %Xz = Xf(1:N);       % oriznu padding
    Xw = Xf .* W';      % zokenkuju (synthesis window)
    Xw = Xw * (hop / sum(W));
    X(1+m*hop:m*hop+N) = X(1+m*hop:m*hop+N) + Xw; % prictu pres overlap

end