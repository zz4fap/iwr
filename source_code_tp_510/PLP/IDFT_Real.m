%Ordem: Ordem do modelo autoregressivo(geralmente usa-se ordem=5)

function [R]=IDFT_Real(phi,ordem)

N=size(phi,2);
R=zeros((ordem+1),1);
for n=1:(ordem+1)
    for k=1:N
        R(n)=R(n)+(phi(k)*cos((2*pi*(k-1)*(n-1))/N));
    end
    R(n)=R(n)/N;
end