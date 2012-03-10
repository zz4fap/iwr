function [Matrix]=DimNumQua(CepstrumMatrix);

erromin=0.3;
nColunas=size(CepstrumMatrix,2);
nLinhas=size(CepstrumMatrix,1);
elimina=zeros(1,nColunas);
nEliminados=0;
for i=1:(nColunas-1)
    aux=(CepstrumMatrix(:,i)-CepstrumMatrix(:,i+1)).^2;
    distance=(sqrt(sum(aux)))/nLinhas;
    if distance<=erromin
        elimina(i)=1;
        nEliminados=nEliminados+1;
    end
end
nColRestantes=nColunas-nEliminados;
Matrix=zeros(nLinhas,nColRestantes);
n=0;
for i=1:nColunas
    if elimina(i)==0
        n=n+1;
        Matrix(:,n)=CepstrumMatrix(:,i);
    end
end