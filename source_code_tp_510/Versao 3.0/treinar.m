% treinar(treinamento,desejadaTr,nTr,valida,desejadaValida,nlocucoesValida,nEntradas,nEscondida,nSaida,b1,b2,eta1,eta2,nEpocas,nomePesos);
%
% Funcao para treinar uma rede neural
%
% Dados de entrada:
%
% treino: matriz que tem em cada coluna um exemplo de treinamento
% dTreino: vetor em que cada elemento consiste na classe correspondente de cada coluna de 'treinamento'
% nTreino: numero de pares de treinamento
% valida: matriz que tem em cada coluna um exemplo de validacao cruzada
% dValida: vetor em que cada elemento consiste na classe correspondente de cada coluna de 'valida'
% nValida: numero de pares de validacao cruzada
% nEntradas: dimensao de cada vetor de treinamento
% nEscondida: numero de neuronios na camada escondida
% nSaida: numero de saidas da rede (numero de classes)
% b1: constante para evitar a saturacao dos neuronios da camada escondida
% b2: constante para evitar a saturacao dos neuronios da camada de saida
% eta1: taxa de aprendizagem da camada escondida
% eta2: taxa de aprendizagem da camada de saida
% nEpocas: numero maximo de epocas de treinamento
% nomePesos: nome de arquivo onde serao armazenados os pesos sinapticos

function treinar(treino,dTreino,nTreino,valida,dValida,nValida,nEntradas,nEscondida,nSaida,b1,b2,eta1,eta2,nEpocas,nomePesos);

erro_minimo=Inf; % Var aux para calcular o erro minimo

% Inicializando matrizes de pesos sinápticos

a1 = 1e-20;                                     % Faixa de variação dos pesos iniciais da camada escondida
a2 = 1e-20;                                     % Faixa de variação dos pesos iniciais da camada de saida
w1=unifrnd(-a1,a1,nEscondida,nEntradas+1);  % Matriz de pesos sinapticos para camada de entrada
w2=unifrnd(-a2,a2,nSaida,nEscondida+1);     % Matriz de pesos sinapticos para camada de saída

% Fazendo o treinamento e validacao cruzada da RNA
epocas=1;
while (epocas<=nEpocas)
  % Mudando a ordem de apresentacao dos exemplos de forma aleatoria
  [treino,dTreino]=embaralha(treino,dTreino);

  % Treinando a rede por uma epoca
%   eta1=eta1/epocas;
%   eta2=eta2/epocas;
  [w1,w2,saturados(epocas)]=backprop(treino,dTreino,nTreino,nEscondida,nEntradas,nSaida,b1,b2,eta1,eta2,w1,w2);

  % Validacao cruzada
  [erro(epocas)]=testar(valida,dValida,nValida,w1,w2,b1,b2);

  % Salvando pesos da rede (se o desempenho foi melhor que o das epocas anteriores)
  if (erro(epocas)<erro_minimo)
    erro_minimo = erro(epocas);
    save nomePesos w1 w2 b1 b2 epocas
  end

  % Atualizando contador de epocas
  epocas=epocas+1;
end
 
% Gráficos do Erro e do numero de neuronios saturados
eixoX=1:nEpocas;
subplot(2,1,1)
plot(eixoX,erro)  
title('Taxa de erro')
subplot(2,1,2)
title('Neuronios saturados')
plot(eixoX,saturados)  

