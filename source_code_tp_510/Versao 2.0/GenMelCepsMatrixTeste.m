function [MelCepsMatrixTeste]=GenMelCepsMatrixTeste(ordem,Fs)

MelCepsMatrixTeste=zeros(1,720);
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
        [CepstrumMatrix]=MelCepstrum2(File,ordem,Fs);
        MelCepsMatrixTeste=[MelCepsMatrixTeste;CepstrumMatrix];
        clear File;
        clear CepstrumMatrix;
        matrizteste(((i-1)*12)+d)=i;
    end
    cd ..;
end
MelCepsMatrixTeste=MelCepsMatrixTeste(2:size(MelCepsMatrixTeste,1),:);
cd('c:\MATLAB6p5\work');
save CepstrumMatrixTeste.mat MelCepsMatrixTeste matrizteste;