% REDE NEURAL ARTIFICIAL PARA RECONHECIMENTO DAS PALAVRAS ABRE E FECHA  
% Utilizando a função <treinar.m> e funçao <testar.m>
% Ultima atualizaçao em julho/2004


clear all

load CepstrumMatrix;
nEntradas=size(Matrix,2);

% Arquitetura da rede neural
nEscondida =100;       % Número de neurônios da camada escondida
nSaida = 11;          % Número de neurônios da camada de saída
%nEntradas = 720;     % Número de sinais de entrada

% Constantes da rede neural
b1=0.0002;           % Constante para nao saturar os neuronios da camada escondida
b2=0.9999;           % Constante para nao saturar os neuronios da camada de saida
eta1=0.05;           % Fator de aprendizagem para a camada de entrada (escondida)
eta2=0.01;           % Fator de aprendizagem para a camada de saída

% Dados do treinamento

% Carrega parametros .mel para teste e treinamento. 
% (Os parametros  de 1 a 11 correspode a palavra abre  e os parametros de 12 a 24 a palavra fecha).
%load parmel.mat      
parmel=Matrix';
nEpocas=50;          % Numero de epocas
nlocucoesTr=25;	     % Número de pares de treinamento
nlocucoesValida=15;   % Número de pares de validacao cruzada
nomePesos = 'pesosRede';

% Inicializacao das Matrizes 

desejadaTr=zeros(1,nlocucoesTr);            % Matriz desejada dos dados de treinamento
desejadaValida=zeros(1,nlocucoesValida);    % Matriz desejada dos dados de validacao cruzada
treinamento=zeros(nEntradas,nlocucoesTr);   % Dados para treinamento da rede
valida=zeros(nEntradas,nlocucoesValida);    % Dados para validacao cruzada
erro=zeros(1,nEpocas);                      % Erro da Rede
saturados=zeros(1,nEpocas);                 % Numero de neurônios saturados	


% Matriz para treinamento da rede

for i=1:9
  treinamento(:,i)=parmel(:,i);
  desejadaTr(i)=1;
end
   
i=10;
j=12;

while  (i<=29) & (j<=36)
  treinamento(:,i)=parmel(:,j);
  desejadaTr(i)=2;
  i=i+1;
  j=j+1;
end
   
% Matriz para validacao cruzada da rede

i=1;
j=10;

while  (i<=2) & (j<=11)
  valida(:,i)= parmel(:,j);
  desejadaValida(i)=1;
  i=i+1;
  j=j+1;
end
   
i=3;
j=22;

while  (i<=24) & (j<=36)
  valida(:,i)= parmel(:,j);
  desejadaValida(i)=2;
  i=i+1;
  j=j+1;
end 

% Treinando a rede
treinar(treinamento,desejadaTr,nlocucoesTr,valida,desejadaValida,nlocucoesValida,nEntradas,nEscondida,nSaida,b1,b2,eta1,eta2,nEpocas,'pesos');
 
% Testando a rede
clear w1 w2 b1 b2
load nomePesos
erros=testar(valida,desejadaValida,nlocucoesValida,w1,w2,b1,b2)

