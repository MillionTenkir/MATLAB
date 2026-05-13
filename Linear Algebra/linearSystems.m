% Ax=b
% then x=A^-1b but the determinant must be different from zero

A=[3 5 4; 2 10 1; 2 2 9]
b=[25;25;33]
x=inv(A)*b

% we can also use A\b
y = A \ b; % Solve the system using the backslash operator

% 
rng(1000)
n=20
p=3
X=randn(n,p)*3+10


averageX=mean(X,1) % by changing "all" to a number it can be used t calculate the mean of a row
sigma=std(X)

Xtilde=X-averageX

mXtilde=mean(Xtilde,1)
newSigma=std(Xtilde)

% zscores = (x-M)/sigma
