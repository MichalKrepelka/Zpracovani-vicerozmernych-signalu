function S = mystft(X, N, hop, FFTLength, W)
%Implementace STFT
%----
%   Vraci matici A tvaru (delka okenka/fft)x(pocet framu)
%   Vstup:
%   X : Signal
%   N : Delka FT/okenka
%   hop: Posunuti okenka
%   FFTLength :  Delka FFT (protoze padding nulami)
%   W : okenkovaci funkce
%---------------------------------------------------------------

% oriznu, co se mi nevejde do okenka (alternativne padding nulami)
over=mod(size(X,2)-(N-hop), hop);
X = X(1,1:end-over);

noFrames = ceil(1+((size(X,2)-N)/hop));
S = zeros(N, noFrames);
zp = zeros(1, FFTLength-N);

for m=0:noFrames-1
    Xn = X(1+m*hop:+m*hop+N);    % vyberu samply
    Xw = Xn .* W';      % zokenkuju
    Xz = [Xw, zp];      % pridam na konec zero padding  
    Xf = fft(Xz);       % provedu fft
    %Xf = mydft(Xz);    % nebo provedu moji dft - trva vecnost
    %Xs = [Xf(FFTLength/2+1:FFTLength), Xf(1:FFTLength/2)];  % prohodim
    S(:,m+1) = Xf;
end