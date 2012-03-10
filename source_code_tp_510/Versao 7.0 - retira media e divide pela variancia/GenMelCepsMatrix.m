function [MelCepsMatrixTreinamento, matriztreinamento, MelCepsMatrixTeste, matrizteste]=GenMelCepsMatrix(ordem,Fs)

%**************************************************************************
%
%                  CONCATENANDO E ENCONTRANDO A MEDIA
%
%**************************************************************************

[MelCepsMatrixTreinamento, matriztreinamento]=GenMelCepsMatrixTreinamento(ordem,Fs);
[MelCepsMatrixTeste,matrizteste]=GenMelCepsMatrixTeste(ordem,Fs);
Matrix=[MelCepsMatrixTreinamento MelCepsMatrixTeste];
media=mean(Matrix,2);
clear Matrix

%**************************************************************************

%**************************************************************************
%
%           RETIRANDO A MEDIA E FORMATACAO DA MATRIZ DE TREINAMENTO
%
%**************************************************************************

nColunas=size(MelCepsMatrixTreinamento,2);
for i=1:nColunas
    MelCepsMatrixTreinamento(:,i)=MelCepsMatrixTreinamento(:,i)-media;
end

nLocucoes=size(matriztreinamento,2);
MatrixTreinamento=zeros(720,nLocucoes);
for j=1:nLocucoes
    for m=1:60
        for n=1:ordem
            MatrixTreinamento((12*(m-1))+n,j)=MelCepsMatrixTreinamento(n,(60*(j-1))+m);
        end
    end
end

clear MelCepsMatrixTreinamento;
MelCepsMatrixTreinamento=[MatrixTreinamento];

%**************************************************************************
   
%**************************************************************************
%
%           RETIRANDO A MEDIA E FORMATACAO DA MATRIZ DE TESTE
%
%**************************************************************************
clear nColunas;
nColunas=size(MelCepsMatrixTeste,2);
for i=1:nColunas
    MelCepsMatrixTeste(:,i)=MelCepsMatrixTeste(:,i)-media;
end

clear nLocucoes;
nLocucoes=size(matrizteste,2);
MatrixTeste=zeros(720,nLocucoes);
for j=1:nLocucoes
    for m=1:60
        for n=1:ordem
            MatrixTeste((12*(m-1))+n,j)=MelCepsMatrixTeste(n,(60*(j-1))+m);
        end
    end
end

clear MelCepsMatrixTeste;
MelCepsMatrixTeste=[MatrixTeste];

%**************************************************************************

%**************************************************************************
%
%           ENCONTRANDO E DIVIDINDO PELA VARIANCIA AS MATRIZES
%
%**************************************************************************

Matrix=[MelCepsMatrixTreinamento MelCepsMatrixTeste];
clear nColunas
nColunas=size(Matrix,2);
Vector=zeros(1,1);
for i=1:nColunas
    Vector=[Vector;Matrix(:,i)];
end
Vector=Vector(2:size(Vector,1),:)';
variancia=var(Vector);
MelCepsMatrixTreinamento=MelCepsMatrixTreinamento/variancia;
MelCepsMatrixTeste=MelCepsMatrixTeste/variancia;

%**************************************************************************

cd('c:\MATLAB6p5\work');
save CepstrumMatrixTreinamento.mat MelCepsMatrixTreinamento matriztreinamento;
save CepstrumMatrixTeste.mat MelCepsMatrixTeste matrizteste;