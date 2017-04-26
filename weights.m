function [W, Wo] = weights()
[F covar]=train();
covar=inv(covar);
W=covar*F';
W=W';
Wk=(W.*F);
Wo=-(1/2)*sum(Wk,2);
