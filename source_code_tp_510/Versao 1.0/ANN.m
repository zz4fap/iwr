% REDE NEURAL ARTIFICIAL PARA RECONHECIMENTO DAS PALAVRAS ABRE E FECHA  
% Utilizando a fun��o <treinar.m> e fun�ao <testar.m>
% Ultima atualiza�ao em julho/2004


clear all

% Arquitetura da rede neural
nEscondida=44;          % N�mero de neur�nios da camada escondida
nSaida=11;              % N�mero de neur�nios da camada de sa�da
nEntradas=720;          % N�mero de sinais de entrada

% Constantes da rede neural
b1=0.0004;           % Constante para nao saturar os neuronios da camada escondida
b2=0.5;           % Constante para nao saturar os neuronios da camada de saida
eta1=0.03;           % Fator de aprendizagem para a camada de entrada (escondida)
eta2=0.02;           % Fator de aprendizagem para a camada de sa�da

% Dados do treinamento

% Carrega parametros .mel para teste e treinamento. 
% (Os parametros  de 1 a 11 correspode a palavra abre  e os parametros de 12 a 24 a palavra fecha).
load CepstrumMatrix.mat;      
parmel=MelCepsMatrix';
nEpocas=100;                % Numero de epocas
nlocucoesTr=330;            % N�mero de pares de treinamento
nlocucoesValida=110;        % N�mero de pares de validacao cruzada
nomePesos='pesosRede';

% Inicializacao das Matrizes 

desejadaTr=zeros(1,nlocucoesTr);            % Matriz desejada dos dados de treinamento
desejadaValida=zeros(1,nlocucoesValida);    % Matriz desejada dos dados de validacao cruzada
treinamento=zeros(nEntradas,nlocucoesTr);   % Dados para treinamento da rede
valida=zeros(nEntradas,nlocucoesValida);	% Dados para validacao cruzada
erro=zeros(1,nEpocas);                      % Erro da Rede
saturados=zeros(1,nEpocas);                 % Numero de neur�nios saturados	


% Matriz para treinamento da rede
n=1;
for i=1:11
    for j=1:10
        for m=1:3
            tr=(i-1)*30 + (j-1)*3 + m;
            treinamento(:,tr)=parmel(:,n+m);
            desejadaTr(tr)=i;
        end
        n=n+4;
    end
end

clear n;
clear tr;
   
% Matriz para validacao cruzada da rede
n=1;
for i=1:11
    for j=1:10
        tr=((i-1)*10)+j;
        valida(:,tr)=parmel(:,n);
        desejadaValida(tr)=i;
        n=n+4;
    end
end

% Treinando a rede
treinar(treinamento,desejadaTr,nlocucoesTr,valida,desejadaValida,nlocucoesValida,nEntradas,nEscondida,nSaida,b1,b2,eta1,eta2,nEpocas,'pesos');
 
% Testando a rede
clear w1 w2 b1 b2
load nomePesos
erros=testar(valida,desejadaValida,nlocucoesValida,w1,w2,b1,b2)

