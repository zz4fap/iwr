function [DeltaMelMatrix]=DeltaMel(CepstrumMatrix,nQuadrosAdjacentes)

ordem=size(CepstrumMatrix,1);
nQuadros=size(CepstrumMatrix,2);
c=1/((2*nQuadrosAdjacentes)+1);
DeltaMelMatrix=zeros(ordem,nQuadros);
ColunadeZeros=zeros(ordem,nQuadrosAdjacentes);
CepstrumMatrix=[ColunadeZeros CepstrumMatrix ColunadeZeros];
for i=1:nQuadros
    for k=-nQuadrosAdjacentes:nQuadrosAdjacentes
        DeltaMelMatrix(:,i)=DeltaMelMatrix(:,i)+(k*CepstrumMatrix(:,i-k+nQuadrosAdjacentes));
    end
    DeltaMelMatrix(:,i)=c*DeltaMelMatrix(:,i);
end