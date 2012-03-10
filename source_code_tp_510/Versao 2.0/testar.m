%
% function [erros]=testar(teste,dTeste,nTeste,w1,w2,b1,b2)
%
% Dados de entrada:
% - teste : matriz que tem em suas colunas os vetores de teste da rede
% - dTeste: classes correspondentes a cada uma das colunas da matriz teste
% - nTeste: numero de vetores de teste
% - w1,w2 : Matrizes com os pesos sinápticos da rede neural, geradas pelo programa 'treinar.m'
% - b1 : Constante para não saturar os neurônios da camada escondida
% - b2 : Constante para não saturar os neurônios da camada de saida
%
% Saida:
% - erros: numero de vetores classificados incorretamente

function [erros]=testar(teste,dTeste,nTeste,w1,w2,b1,b2)

erros=0;

for i=1:nTeste   
    saida = forward(teste(:,i),w1,w2,b1,b2);
    [v p] = max(saida);
    if p ~= dTeste(i)
        erros=erros+1;
    end
end

%  saida = forward(teste(:,i),w1,w2,b1,b2);
%   d=-0.8*ones(size(saida));
%   d(dTeste(i))=0.8;
%   e=d-saida;
%   e=sqrt(e.^2);
%   em=sum(e)/11;
%   if em>1e-3
%       erros=erros+1;
%   end
      
