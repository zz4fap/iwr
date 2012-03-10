function [MelCepsMatrix]=GenMelCepsMatrix2(ordem,Fs)

MelCepsMatrix=zeros(1,720);
cd('c:\locucoes');
locucoes=dir;
nLocucoes=size(locucoes,1)-2;
for i=1:nLocucoes
    nome=int2str(i);
    arq=strcat(nome,'.wav');
    File=wavread(arq);
    [CepstrumMatrix]=MelCepstrum2(File,ordem,Fs);
    MelCepsMatrix=[MelCepsMatrix;CepstrumMatrix];
    clear File;
    clear CepstrumMatrix;
end
MelCepsMatrix=MelCepsMatrix(2:size(MelCepsMatrix,1),:);
cd('c:\MATLAB6p5\work');
save CepstrumMatrix.mat MelCepsMatrix;