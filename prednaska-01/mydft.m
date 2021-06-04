function [Xi] = mydft(X)
%Implementace DFT
%----
%   Vraci vektor Xi stejneho rozmeru jako vstup
%   Vstup:
%   X : Signal
%---------------------------------------------------------------

N=length(X); % size napr 1x1024
Xi=zeros(1,N);

for k=1:N
    for n=1:N
        Xi(k)= Xi(k) + X(n)*exp(-1i*2*pi/N*(k-1)*n);
    end
end

end

