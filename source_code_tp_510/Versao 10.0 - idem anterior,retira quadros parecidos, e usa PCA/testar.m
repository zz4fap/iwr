%
% function [erros]=testar(teste,dTeste,nTeste,w1,w2)
%
% Dados de entrada:
% - teste : matriz que tem em suas colunas os vetores de teste da rede
% - dTeste: classes correspondentes a cada uma das colunas da matriz teste
% - nTeste: numero de vetores de teste
% - w1,w2 : Matrizes com os pesos sinápticos da rede neural, geradas pelo programa 'treinar.m'
%
% Saida:
% - erros: numero de vetores classificados incorretamente

function [erros]=testar(teste,dTeste,nTeste,w1,w2)

erros=0;

for i=1:nTeste   
  saida = forward(teste(:,i),w1,w2);
  [v p] = max(saida);
  if p ~= dTeste(i)
    erros=erros+1;
  end
end
      
