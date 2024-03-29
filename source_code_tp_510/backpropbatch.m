% treinamento: Dados de treinamento da rede
% dese : Dados desejados correspondentes aos dados de treinamento
% nEscondida : N�mero de neur�nios da camada escondida
% nEntradas : N�mero de entradas da RN
% nSaida : N�mero de sa�das
% a,b : Constantes para n�o saturar os neur�nios
% eta1,eta2 : Fatores de aprendizagem
% nlocucoesTr : N�mero de locua��es de treinamento
% w1,w2 : Matrizes de pesos sin�pticos
% saturados : N�mero de neur�nios saturados 
%

function [w1,w2,saturados]=backprop(treinamento,dese,nlocucoesTr,nEscondida,nEntradas,nSaida,b1,b2,eta1,eta2,w1,w2);

batchw1=0;
batchw2=0;
for i=1:nlocucoesTr
    
  % Entrada modificada (inser��o do limiar de ativa��o)
  y0=[-1;treinamento(:,i)];

  % Sa�da da camada de entrada
  y1=tanh(b1*w1*y0);
     
  % Verificando se h� sa�das saturadas
  saturados=0;
  for j=1:length(y1)
    if (y1(j)>=0.95 | y1(j)<=-0.95)
      saturados=saturados+1;
    end
  end   
      
  % Entrada da camada de sa�da
  y2=[-1;y1];

  % Sa�da da camada de sa�da (sa�da da rede)
  y3=tanh(b2*w2*y2);
      
  % Verificando se h� sa�das saturadas
  for j=1:length(y3)
    if (y3(j)>=0.95 | y3(j)<=-0.95)
      saturados=saturados+1;
    end
  end   
      
  % Determinando vetor de saida desejado para esta entrada
  d=-0.8*ones(size(y3));
  d(dese(i))=0.8;

  % C�lculo do gradiente local para a camada de sa�da
  delta2 = (d-y3).*(1-y3.*y3);

  % Acumulacao do gradiente local de cada locucao de treinamento(camada de saida)
  batchw2=batchw2+(eta2*delta2*y2');
  batchw2=batchw2/nlocucoesTr;
  
  % C�lculo do gradiente local para a camada escondida
  aux = w2'*delta2;
  delta1=diag((1-y1.*y1)*aux');

  % Acumulacao do gradiente local de cada locucao de treinamento(camada escondida)
  batchw1=batchw1+(eta1*delta1*y0');
  batchw1=batchw1/nlocucoesTr;
  
end
w2=w2+batchw2;
w1=w1+batchw1;