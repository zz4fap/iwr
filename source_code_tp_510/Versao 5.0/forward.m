% FORWARD            Calcula saída de uma Rede Neural Artificial
%
% function saida=forward(x,w1,w2,a,b);
%
% Dados de entrada:
% - x : vetor de entrada
% - w1 : Matriz de pesos sinápticos da camada escondida
% - w2 : Matriz de pesos sinápticos da camada de saída
%
% Saida:
% -saida: saida de todos os neuronios da camada de saida
%

function saida=forward(x,w1,w2);

a=1.7159;
b=2/3;

% Entrada modificada (inserção do limiar de ativação)
y0=[-1;x];

% Saída da camada de entrada
y1=a*tanh(b*w1*y0);

% Entrada da camada de saída
y2=[-1;y1];

% Saída da camada de saída (saída da rede)
saida=a*tanh(b*w2*y2);