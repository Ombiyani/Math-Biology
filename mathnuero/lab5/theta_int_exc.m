function dxdt = theta_int_exc(t,x,be)
%defines a function that is dtheta/dt for theta model of one exc nueron
dxdt = (1-cos(x(1)))+(be)*(1+cos(x(1))); %diffential equation for theta.
%See Neural Rhythms chapter for details. 