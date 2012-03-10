%Fun��o para extracao dos parametros de Predi��o Linear Perceptual de 
%uma locucao
%
%Par�metros de entrada:
% - File: amostras da locu��o utilizada para a extracao dos parametros.
% - Fs: frequencia de amostragem.
% - ordem: Ordem do modelo autoregressivo(geralmente usa-se ordem=5).
%
%Par�metro de sa�da:
% - PLPMatrix: retorna uma matriz com os coeficientes de
%              uma locucao.

function [PLPMatrix]=PLP(File,Fs,ordem)

%--------------------------------------------------------------------------
%
% Retirando n�vel DC do sinal
%
%--------------------------------------------------------------------------

PLPMatrix=zeros(5,1);
NCol=size(File,2);
Nlin=size(File,1);
A=zeros(Nlin,1);
if NCol > 1
    A=File(:,1);
else
    A=File;
end

switch Fs
    case 8000
        nfft=512;
    case 11025
        nfft=512;
    case 16000
        nfft=1024;
end
        
media=mean(A);
Nmax=size(A,1);
Nsamplesframe=floor(Nmax/31);
Deslocamento=floor(Nsamplesframe/2);

for indice=1:Nmax
    A(indice)=A(indice)-media;
end

%--------------------------------------------------------------------------
%
% Separa��o em quadros
%
%--------------------------------------------------------------------------

phi=zeros(1,16);
Sframe=zeros(Nsamplesframe,1);
w=zeros(Nsamplesframe,1);
PW=zeros(nfft,1);
Sjanelado=zeros(Nsamplesframe,1);
Sfft=zeros(nfft,1);
for m=1:60
    a=(m-1)*Deslocamento+1;
    b=(m-1)*Deslocamento+Nsamplesframe;
    Sframe=A(a:b);
    
    %----------------------------------------------------------------------
    %
    % Tratamento de Frames
    % a) Janelamento
    %
    %----------------------------------------------------------------------
    
    w=hamming(Nsamplesframe);   
    Sjanelado=Sframe.*w;
   
    %----------------------------------------------------------------------
    %
    % b) FFT
    %
    %----------------------------------------------------------------------
    
    Sfft=fft(Sjanelado, nfft);  
    PW=Sfft.*conj(Sfft)/nfft;
    
    %----------------------------------------------------------------------
    %
    % c) Filtrando a energia atrav�s dos Filtros Bark
    %
    %----------------------------------------------------------------------
    
    [EPB]=BarkFilter3(PW,Fs,nfft);
    
    %----------------------------------------------------------------------
    %
    % d) Intensity-loudness power law
    %
    %----------------------------------------------------------------------
    
    phi=EPB.^(1/3);
    
    %----------------------------------------------------------------------
    %
    % e) Modelamento Autoregressivo
    %
    %----------------------------------------------------------------------
    
    %C�lculo da sequ�ncia de autocorrela��o
    [R]=IDFT_Real(phi,ordem);

    C=[R(1) R(2) R(3) R(4) R(5);
       R(2) R(1) R(2) R(3) R(4);
       R(3) R(2) R(1) R(2) R(3);
       R(4) R(3) R(2) R(1) R(2);
       R(5) R(4) R(3) R(2) R(1)];
   
    B=[-R(2);-R(3);-R(4);-R(5);-R(6)];

    coef=C\B;

    PLPMatrix=[PLPMatrix coef];
end
PLPMatrix=PLPMatrix(:,2:size(PLPMatrix,2));