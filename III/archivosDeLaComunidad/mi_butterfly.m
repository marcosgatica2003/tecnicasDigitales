function [Y0,Y1]=mi_butterfly(X0,X1,fg) 

Y1=X0 - (X1*fg);

Y0=X0 + (X1*fg);


end