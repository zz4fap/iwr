function [MelCepsMatrixTeste,matrizteste]=GenMelCepsMatrixTeste(ordem,Fs,nQuadrosAdjacentes)

MelCepsMatrixTeste=zeros(ordem,1);
cd('c:\locucoes_teste');
locucoes=dir;
nPalavras=size(locucoes,1)-2;
matrizteste=zeros(1,132);
for i=1:nPalavras
    locucao=locucoes(i+2).name;
    cd(locucao);
    observacoes=dir;
    D=size(observacoes,1)-2;
    for d=1:D
        File=wavread(observacoes(d+2).name);
        [CepstrumMatrix]=MelCepstrum3(File,(ordem/2),Fs);
        [DeltaMelMatrix]=DeltaMel(CepstrumMatrix,nQuadrosAdjacentes);
        CepstrumMatrix=[CepstrumMatrix;DeltaMelMatrix];
        MelCepsMatrixTeste=[MelCepsMatrixTeste CepstrumMatrix];
        clear File;
        clear CepstrumMatrix;
        matrizteste(((i-1)*12)+d)=i;
    end
    cd ..;
end
MelCepsMatrixTeste=MelCepsMatrixTeste(:,2:size(MelCepsMatrixTeste,2));