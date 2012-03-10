function [E]=EQL(wi)

N=((wi^2)+56.8e6)*(wi^4);
D=((wi^2)+6.3e6)^2;
aux=((wi^2)+0.38e9);
E=N/(D*aux);