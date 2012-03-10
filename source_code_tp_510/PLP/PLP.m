%Função para extracao dos parametros de Predição Linear Perceptual de 
%uma locucao
%
%Parâmetros de entrada:
% - File: amostras da locução utilizada para a extracao dos parametros.
% - Fs: frequencia de amostragem.
% - ordem: Ordem do modelo autoregressivo(geralmente usa-se ordem=5).
%
%Parâmetro de saída:
% - PLPMatrix: retorna uma matriz com os coeficientes de
%              uma locucao.

function [PLPMatrix]=PLP(File,Fs,ordem)

%--------------------------------------------------------------------------
%
% Retirando nível DC do sinal
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
        Lframe=80;
        Lwindow=160;
    case 11025
        nfft=512;
        Lframe=110;
        Lwindow=220;
    case 16000
        nfft=1024;
        Lframe=160;
        Lwindow=320;
end
        
media=mean(A);
Nmax=size(A,1);

for indice=1:Nmax
    A(indice)=A(indice)-media;
end

%--------------------------------------------------------------------------
%
% Separação em quadros
%
%--------------------------------------------------------------------------

phi=zeros(1,16);
Sframe=zeros(Lwindow,1);
w=zeros(Lwindow,1);
PW=zeros(nfft,1);
Sjanelado=zeros(Lwindow,1);
Sfft=zeros(nfft,1);
m=0;
pass = 0;
while pass == 0
    a = m*Lframe+1;
    b = m*Lframe+Lwindow;
    if b > Nmax
        a=Nmax-(Lwindow-1);
        b=Nmax;
        pass=1;
    end
    Sframe=A(a:b);
    
    %----------------------------------------------------------------------
    %
    % Tratamento de Frames
    % a) Janelamento
    %
    %----------------------------------------------------------------------
    
    w=hamming(Lwindow);   
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
    % c) Filtrando a energia através dos Filtros Bark
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
    
    %Cálculo da sequência de autocorrelação
    [R]=IDFT_Real(phi,ordem);

    C=[R(1) R(2) R(3) R(4) R(5);
       R(2) R(1) R(2) R(3) R(4);
       R(3) R(2) R(1) R(2) R(3);
       R(4) R(3) R(2) R(1) R(2);
       R(5) R(4) R(3) R(2) R(1)];
   
    B=[-R(2);-R(3);-R(4);-R(5);-R(6)];

    coef=C\B;

    PLPMatrix=[PLPMatrix coef];
    m = m + 1;
end
PLPMatrix=PLPMatrix(:,2:size(PLPMatrix,2));