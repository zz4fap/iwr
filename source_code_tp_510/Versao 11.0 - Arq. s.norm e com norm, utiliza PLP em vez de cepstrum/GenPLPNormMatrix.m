function [PLPMatrixTreinamento, matriztreinamento, PLPMatrixTeste, matrizteste]=GenPLPNormMatrix(ordem,Fs)

%**************************************************************************
%
%                  CONCATENANDO E ENCONTRANDO A MEDIA
%
%**************************************************************************

[PLPMatrixTreinamento, matriztreinamento]=GenPLPMatrixTreinamento(ordem,Fs);
[PLPMatrixTeste,matrizteste]=GenPLPMatrixTeste(ordem,Fs);
Matrix=[PLPMatrixTreinamento PLPMatrixTeste];
media=mean(Matrix,2);
clear Matrix

%**************************************************************************

%**************************************************************************
%
%           RETIRANDO A MEDIA E FORMATACAO DA MATRIZ DE TREINAMENTO
%
%**************************************************************************

nColunas=size(PLPMatrixTreinamento,2);
for i=1:nColunas
    PLPMatrixTreinamento(:,i)=PLPMatrixTreinamento(:,i)-media;
end

nLocucoes=size(matriztreinamento,2);
MatrixTreinamento=zeros(300,nLocucoes);
for j=1:nLocucoes
    for m=1:60
        for n=1:ordem
            MatrixTreinamento((ordem*(m-1))+n,j)=PLPMatrixTreinamento(n,(60*(j-1))+m);
        end
    end
end

clear PLPMatrixTreinamento;
PLPMatrixTreinamento=[MatrixTreinamento];
clear MatrixTreinamento;

%**************************************************************************
   
%**************************************************************************
%
%           RETIRANDO A MEDIA E FORMATACAO DA MATRIZ DE TESTE
%
%**************************************************************************
clear nColunas;
nColunas=size(PLPMatrixTeste,2);
for i=1:nColunas
    PLPMatrixTeste(:,i)=PLPMatrixTeste(:,i)-media;
end

clear nLocucoes;
nLocucoes=size(matrizteste,2);
MatrixTeste=zeros(300,nLocucoes);
for j=1:nLocucoes
    for m=1:60
        for n=1:ordem
            MatrixTeste((ordem*(m-1))+n,j)=PLPMatrixTeste(n,(60*(j-1))+m);
        end
    end
end

clear PLPMatrixTeste;
PLPMatrixTeste=[MatrixTeste];
clear MatrixTeste;

%**************************************************************************

%**************************************************************************
%
%           ENCONTRANDO E DIVIDINDO PELA VARIANCIA AS MATRIZES
%
%**************************************************************************

Matrix=[PLPMatrixTreinamento PLPMatrixTeste];
clear nColunas
nColunas=size(Matrix,2);
Vector=zeros(1,1);
for i=1:nColunas
    Vector=[Vector;Matrix(:,i)];
end
Vector=Vector(2:size(Vector,1),:)';
variancia=var(Vector);
desvio=sqrt(variancia);
PLPMatrixTreinamento=PLPMatrixTreinamento/desvio;
PLPMatrixTeste=PLPMatrixTeste/desvio;

%**************************************************************************

cd('c:\MATLAB6p5\work');
save PLPMatrixNormalizadoTreinamento.mat PLPMatrixTreinamento matriztreinamento;
save PLPMatrixNormalizadoTeste.mat PLPMatrixTeste matrizteste;