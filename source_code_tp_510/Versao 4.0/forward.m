% FORWARD            Calcula saída de uma Rede Neural Artificial
%
% function saida=forward(x,w1,w2,a,b);
%
% Dados de entrada:
% - x : vetor de entrada
% - w1 : Matriz de pesos sinápticos da camada escondida
% - w2 : Matriz de pesos sinápticos da camada de saída
% - b1: Constante para nao saturar os neuronios da camada escondida
% - b2: Constante para nao saturar os neuronios da camada de saida
%
% Saida:
% -saida: saida de todos os neuronios da camada de saida
%

function saida=forward(x,w1,w2,a,b);

% Entrada modificada (inserção do limiar de ativação)
y0=[-1;x];

% Saída da camada de entrada
y1=tanh(a*w1*y0);

% Entrada da camada de saída
y2=[-1;y1];

% Saída da camada de saída (saída da rede)
saida=tanh(b*w2*y2);
