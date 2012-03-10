Fs=11025;
nfft=512;

hold on
omega=warp(2*pi*(Fs/2));
nSamples=floor(omega)-1;
SampInt=omega/(nSamples+1);
H=zeros(1,(nfft/2)+1);
for i=1:nSamples
    wi=unwarp(i*SampInt);
    E=EQL(wi)
    for m=1:((nfft/2)+1)
        w=(2*pi*(Fs/2)*(m-1))/(nfft/2);
        k=warp(w);
        if k < ((i*SampInt)-2.5)
            H(m)=0;
        elseif (k>=((i*SampInt)-2.5)) & (k<=((i*SampInt)-0.5))
            aux=10^(-((i*SampInt)-0.5));
            H(m)=aux*E*10^k;
        elseif (k>((i*SampInt)-0.5)) & (k<((i*SampInt)+0.5))
            H(m)=E;
        elseif (k>=((i*SampInt)+0.5)) & (k<=((i*SampInt)+1.3))
            aux=10^(2.5*((i*SampInt)+0.5));
            H(m)=aux*E*10^(-2.5*k);
        elseif k > ((i*SampInt)+1.3)
            H(m)=0;
        else
            erro
        end
    end
    plot(H, '.')
end
