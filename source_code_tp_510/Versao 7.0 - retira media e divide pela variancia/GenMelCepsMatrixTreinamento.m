function [MelCepsMatrixTreinamento, matriztreinamento]=GenMelCepsMatrixTreinamento(ordem,Fs)

MelCepsMatrixTreinamento=zeros(ordem,1);
cd('c:\locucoes_treinamento');
locucoes=dir;
nPalavras=size(locucoes,1)-2;
matriztreinamento=zeros(1,308);
for i=1:nPalavras
    locucao=locucoes(i+2).name;
    cd(locucao);
    observacoes=dir;
    D=size(observacoes,1)-2;
    for d=1:D
        File=wavread(observacoes(d+2).name);
        [CepstrumMatrix]=MelCepstrum3(File,ordem,Fs);
        MelCepsMatrixTreinamento=[MelCepsMatrixTreinamento CepstrumMatrix];
        clear File;
        clear CepstrumMatrix;
        matriztreinamento(((i-1)*28)+d)=i;
    end
    cd ..;
end
MelCepsMatrixTreinamento=MelCepsMatrixTreinamento(:,2:size(MelCepsMatrixTreinamento,2));