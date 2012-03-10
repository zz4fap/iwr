function [PLPMatrixTeste,matrizteste]=GenPLPMatrixTeste(ordem,Fs)

PLPMatrixTeste=zeros(ordem,1);
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
        [PLPMatrix]=PLP(File,Fs,ordem);
        PLPMatrixTeste=[PLPMatrixTeste PLPMatrix];
        clear File;
        clear PLPMatrix;
        matrizteste(((i-1)*12)+d)=i;
    end
    cd ..;
end
PLPMatrixTeste=PLPMatrixTeste(:,2:size(PLPMatrixTeste,2));