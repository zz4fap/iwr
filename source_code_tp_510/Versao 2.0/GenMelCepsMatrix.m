function [MelCepsMatrix]=GenMelCepsMatrix(ordem,Fs)

MelCepsMatrix=zeros(1,720);
cd('c:\locucoes');
locucoes=dir;
nPalavras=size(locucoes,1)-2;
for i=1:nPalavras
    locucao=locucoes(i+2).name;
    cd(locucao);
    observacoes=dir;
    D=size(observacoes,1)-2;
    for d=1:D
        File=wavread(observacoes(d+2).name);
        [CepstrumMatrix]=MelCepstrum2(File,ordem,Fs);
        MelCepsMatrix=[MelCepsMatrix;CepstrumMatrix];
        clear File;
        clear CepstrumMatrix;
    end
    cd ..;
end
MelCepsMatrix=MelCepsMatrix(2:size(MelCepsMatrix,1),:);
cd('c:\MATLAB6p5\work');
save CepstrumMatrix.mat MelCepsMatrix;