clear; clc; close all;

d = 10;     % pocet signalu
N = 1024;   % delka signalu
A = randn(d,d); % nahodna matice zeslabeni signalu

S = randn(d,N);
X = A * S;

R = cov(X');    % odhad

R(1,2)

%mean(X(1,:) .* X(2,:))

% abych dostal kovarianci, odectu stredni hodnotu
mean((X(1,:) - mean(X(1,:))) .* (X(2,:) - mean(X(2,:))))

% matlab ji pocita trochu jinak (nestranny odhad)
sum((X(1,:) - mean(X(1,:))) .* (X(2,:) - mean(X(2,:))))/(N-1)

% kovariance/korelace
% X*X'/N = A*S*(A*S)'/1000 = A*S*S'*A'/1000 = A*(S*S'/1000)*A'

R=zeros(d);
for i=1:N, R=R+X(:,i)*X(:,i)';end
R=R/1000;
% srovnam
sum(sum((R - X*X'/1000)^2)) % algebraicky stejne
 