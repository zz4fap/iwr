function [k]=warpp(w)

a=w/(1200*pi);
k=6*log(a+sqrt(a^2 + 1));