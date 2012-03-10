function [PLPMatrixTreinamento, matriztreinamento, PLPMatrixTeste, matrizteste]=GenPLPMatrix2(ordem,Fs)

%**************************************************************************
%
%                      ENCONTRANDO AS MATRIZES PLP
%
%**************************************************************************

[PLPMatrixTreinamento, matriztreinamento]=GenPLPMatrixTreinamento(ordem,Fs);
[PLPMatrixTeste,matrizteste]=GenPLPMatrixTeste(ordem,Fs);

%**************************************************************************

%**************************************************************************
%
%                   FORMATACAO DA MATRIZ DE TREINAMENTO
%
%**************************************************************************

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
%                       FORMATACAO DA MATRIZ DE TESTE
%
%**************************************************************************

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

cd('c:\MATLAB6p5\work');
save PLPMatrixTreinamento.mat PLPMatrixTreinamento matriztreinamento;
save PLPMatrixTeste.mat PLPMatrixTeste matrizteste;