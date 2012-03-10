% REDE NEURAL ARTIFICIAL 
% Utilizando a função <treinar.m> e funçao <testar.m>
% Ultima atualizaçao em setembro/2005

clear all

% Arquitetura da rede neural
nEscondida=150;          % Número de neurônios da camada escondida
nSaida=11;               % Número de neurônios da camada de saída
nEntradas=720;           % Número de sinais de entrada

% Constantes da rede neural
eta1=0.004;       % Fator de aprendizagem para a camada de entrada (escondida)
eta2=0.001;       % Fator de aprendizagem para a camada de saída

% Dados do treinamento

% Carrega parametros .mel para teste e treinamento. 
load CepstrumMatrixTreinamento.mat;  
load CepstrumMatrixTeste.mat;  

nEpocas=10;                  % Numero de epocas
nlocucoesTr=308;             % Número de pares de treinamento
nlocucoesValida=132;         % Número de pares de validacao cruzada
nomePesos='pesosRede';

% Inicializacao das Matrizes 

desejadaTr=zeros(1,nlocucoesTr);            % Matriz desejada dos dados de treinamento
desejadaValida=zeros(1,nlocucoesValida);    % Matriz desejada dos dados de validacao cruzada
treinamento=zeros(nEntradas,nlocucoesTr);   % Dados para treinamento da rede
valida=zeros(nEntradas,nlocucoesValida);	% Dados para validacao cruzada
erro=zeros(1,nEpocas);                      % Erro da Rede
saturados=zeros(1,nEpocas);                 % Numero de neurônios saturados	

% Matriz para treinamento da rede
treinamento=MelCepsMatrixTreinamento;
desejadaTr=matriztreinamento;

% Matriz para validacao cruzada da rede
valida=MelCepsMatrixTeste;
desejadaValida=matrizteste;

% Treinando a rede
treinar(treinamento,desejadaTr,nlocucoesTr,valida,desejadaValida,nlocucoesValida,nEntradas,nEscondida,nSaida,eta1,eta2,nEpocas,'pesos');
 
% Testando a rede
clear w1 w2
load nomePesos
erros=testar(valida,desejadaValida,nlocucoesValida,w1,w2)