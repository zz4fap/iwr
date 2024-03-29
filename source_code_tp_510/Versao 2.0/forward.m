% FORWARD            Calcula sa�da de uma Rede Neural Artificial
%
% function saida=forward(x,w1,w2,a,b);
%
% Dados de entrada:
% - x : vetor de entrada
% - w1 : Matriz de pesos sin�pticos da camada escondida
% - w2 : Matriz de pesos sin�pticos da camada de sa�da
% - b1: Constante para nao saturar os neuronios da camada escondida
% - b2: Constante para nao saturar os neuronios da camada de saida
%
% Saida:
% -saida: saida de todos os neuronios da camada de saida
%

function saida=forward(x,w1,w2,a,b);

% Entrada modificada (inser��o do limiar de ativa��o)
y0=[-1;x];

% Sa�da da camada de entrada
y1=tanh(a*w1*y0);

% Entrada da camada de sa�da
y2=[-1;y1];

% Sa�da da camada de sa�da (sa�da da rede)
saida=tanh(b*w2*y2);
