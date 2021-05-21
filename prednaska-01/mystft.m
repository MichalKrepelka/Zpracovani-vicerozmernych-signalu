function A = mystft(X, N, shift, Flen, W)
%Implementace STFT
%----
%   Vraci matici A tvaru (delka okenka)x()
%   Vstup:
%   X : Signal
%   N : Delka FT/okenka
%   shift: Posunuti
%   Flen :  Delka FFT (protoze padding nulami)
%   W : okenkovaci funkce
%---------------------------------------------------------------

A=0