clear; clc; close all;

% nacteni souboru
load('hlasy.mat')

d = 2;     % pocet signalu
S = S(1:d,:);
A = randn(d,d); % nahodna matice zeslabeni signalu

% abyste si vytvořili libovolnou jejich směs (okamžitou = instantaneous) a spočítali jejich kovarianci
% jak se mění v čase a analyzovali proč tomu tak je, když vezmete v potaz fakt, že cov(X') == A*cov(S')*A';
X = A * S;

%soundsc(S(1,:),fs)
%soundsc(S(2,:),fs)
%soundsc(X(1,:),fs)

% udelat okenko a posunovat
N=1024; % delka okenka
iter=ceil(size(X,2)/N);
covTime = zeros(d, d, iter);
for i=0:(iter-1)
    start = 1+i*N;
    stop = N+i*N;
    
    if(i==(iter-1) && stop > size(X,2))
        stop = size(X,2);
    end
    
    covTime(:,:,i+1)=cov(X(:,start:stop)');
    
%     imagesc(covTime(:,:,i+1))
%     hold on
end
