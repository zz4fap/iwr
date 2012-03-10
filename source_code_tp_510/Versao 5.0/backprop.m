% TREINAR            Treinamento de uma época da RNA
%    
% [w1,w2,saturados]=TREINAR(treinamento,dese,nlocucoesTr,nEscondida,nEntradas,nSaida,b1,b2,eta1,eta2,w1,w2);
%
% treinamento: Dados de treinamento da rede
% dese : Dados desejados correspondentes aos dados de treinamento
% nEscondida : Número de neurônios da camada escondida
% nEntradas : Número de entradas da RN
% nSaida : Número de saídas
% a,b : Constantes para não saturar os neurônios
% eta1,eta2 : Fatores de aprendizagem
% nlocucoesTr : Número de locuações de treinamento
% w1,w2 : Matrizes de pesos sinápticos
% saturados : Número de neurônios saturados 
%

function [w1,w2,saturados]=backprop(treinamento,dese,nlocucoesTr,nEscondida,nEntradas,nSaida,eta1,eta2,w1,w2);

a=1.7159;
b=2/3;

for i=1:nlocucoesTr
    
  % Entrada modificada (inserção do limiar de ativação)
  y0=[-1;treinamento(:,i)];

  % Saída da camada de entrada
  y1=a*tanh(b*w1*y0);
     
  % Verificando se há saídas saturadas
  saturados=0;
  for j=1:length(y1)
    if (y1(j)>=0.95 | y1(j)<=-0.95)
      saturados=saturados+1;
    end
  end   
      
  % Entrada da camada de saída
  y2=[-1;y1];

  % Saída da camada de saída (saída da rede)
  y3=a*tanh(b*w2*y2);
      
  % Verificando se há saídas saturadas
  for j=1:length(y3)
    if (y3(j)>=0.95 | y3(j)<=-0.95)
      saturados=saturados+1;
    end
  end   
      
  % Determinando vetor de saida desejado para esta entrada
  d=-1*ones(size(y3));
  d(dese(i))=1;

  % Cálculo do gradiente local para a camada de saída
  delta2 = (d-y3).*(1-y3.*y3);         

  % Atualização dos pesos da camada de saída
  w2=w2+eta2*delta2*y2';

  % Cálculo do gradiente local para a camada escondida
  aux = w2'*delta2;
  delta1=diag((1-y1.*y1)*aux');

  % Atualização dos pesos da camada escondida
  w1=w1+eta1*delta1*y0';
end