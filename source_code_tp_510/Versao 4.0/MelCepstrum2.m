%Função para extracao dos parametros Mel Cepstrais de uma locucao
%
%Parâmetros de entrada:
% - File: matriz com as amostras de uma locução que serão utilizadas
%         para a extracao.
% - ordem: numero de coeficientes Mel Cepstrais desejados.
% - Fs: Frequencia de Amostragem
%
%Parâmetro de saída:
% - CepstrumMatrix: retorna uma matriz com os coeficientes Mel Cepstrais de
%                   uma locucao.

function [CepstrumMatrix]=MelCepstrum2(File,ordem,Fs)

%--------------------------------------------------------------------------
%
% Retirando nível DC do sinal
%
%--------------------------------------------------------------------------

NCol=size(File,2);
if NCol > 1
    A=File(:,1);
else
    A=File;
end

switch Fs
    case 8000
        nFiltros=19;
    case 11025
        nFiltros=21;
    case 16000
        nFiltros=24;
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
% Pre-enfatizando o sinal
%
%--------------------------------------------------------------------------

S=zeros(Nmax,1);
S(1)=A(1);
for i=2:Nmax
    S(i)=A(i)-0.95*A(i-1);
end

%--------------------------------------------------------------------------
%
% Separação em quadros
%
%--------------------------------------------------------------------------

CepstrumMatrix=zeros(1,720);
for m=1:60
    a=(m-1)*Deslocamento+1;
    b=(m-1)*Deslocamento+Nsamplesframe;
    Sframe=S(a:b);
    
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
    
    Sfft=fft(Sjanelado);  
    mod_fft=(Sfft.*conj(Sfft))/Nsamplesframe;
    
    %----------------------------------------------------------------------
    %
    % c) Banco de Filtros
    %
    %----------------------------------------------------------------------
    
    fc=[0,100,200,300,400,500,600,700,800,900,1000,1149,1320,1516,1741,2000,2297,2639,3031,3482,4000,4595,5278,6063,6964,8000];
    epb=zeros(1,nFiltros);
    for k=1:nFiltros
        for i=1:Deslocamento
            f=((Fs/2)*(i-1))/Deslocamento;
            if f <= fc(k+2)
                if f >= fc(k)
                    if f <= fc(k+1)
                        epb(k)=epb(k)+mod_fft(i)*(f-fc(k))/(fc(k+1)-fc(k));
                    else
                        epb(k)=epb(k)+mod_fft(i)*(fc(k+2)-f)/(fc(k+2)-fc(k+1));
                    end
                end
            end
        end
        if epb(k) > 0
            epb(k)=log10(epb(k));
        else
            epb(k)=-100;
        end
    end
    
    %----------------------------------------------------------------------
    %
    % Cálculo dos Coeficientes Mel Cepstrais
    %
    %----------------------------------------------------------------------
    
    for j=1:ordem
        b=0;
        for k=1:nFiltros
            b=b+(epb(k)*cos(j*(k-0.5)*(pi/nFiltros)));
        end
        coluna=((m-1)*ordem)+j;
        CepstrumMatrix(1,coluna)=b;
    end
end