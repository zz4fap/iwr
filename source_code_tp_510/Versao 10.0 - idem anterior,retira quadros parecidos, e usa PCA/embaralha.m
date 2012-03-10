% EMBARALHA	    Embaralha a matriz treinamento para que a rede não fique viciada
%
% EMBARALHA(treinamento,desejadaTr);
%
%			treinamento: Dados de treinamento da RNA
%			desejadaTR: Dados desejados correspondentes aos dados de treinamento

function [ent_emb,d_emb] = embaralha(treinamento,desejadaTr);

% Número de pares estímulo-resposta
nExemplos = length(desejadaTr);

for i=1:nExemplos
	p1=round((nExemplos-1)*rand+1);
	p2=round((nExemplos-1)*rand+1);
	auxp=treinamento(:,p2);
	treinamento(:,p2)=treinamento(:,p1);
	treinamento(:,p1)=auxp;
	auxd=desejadaTr(p2);
	desejadaTr(p2)=desejadaTr(p1);
	desejadaTr(p1)=auxd;
end
ent_emb=treinamento;
d_emb=desejadaTr;
