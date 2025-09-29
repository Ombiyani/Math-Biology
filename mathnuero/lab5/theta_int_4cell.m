function dxdt = theta_int_4cell(t,x,be,bi,gei,te,gie,ti,gee,gii)
%defines a function that is dtheta/dt for two exc nueron and two inhibitory
%neurons. Synaptic coupling has not yet been added
dxdt = zeros(8,1);
dxdt(1) = (1-cos(x(1)))+(be)*(1+cos(x(1))); %defines theta for E1
dxdt(2) = (1-cos(x(2)))+(bi)*(1+cos(x(2))); %defines theta for I1
dxdt(3) = (1-cos(x(3)))+(be)*(1+cos(x(3))); %defines theta for E2
dxdt(4) = (1-cos(x(4)))+(bi)*(1+cos(x(4))); %defines theta for I2
dxdt(5) = -x(5)/te+((1-x(5))/.1)*exp(-5*(1+cos(x(1)))); %defines synpatic gating variable from E1 to any postsynaptic cell 
dxdt(6) = -x(6)/ti+((1-x(6))/.1)*exp(-5*(1+cos(x(2)))); %defines synaptic gating variable from I1 to any postsynapric cell
dxdt(7) = -x(7)/te+((1-x(7))/.1)*exp(-5*(1+cos(x(3)))); %defines synaptic gating variable from E2 to any postsynapric cell
dxdt(8) = -x(8)/ti+((1-x(8))/.1)*exp(-5*(1+cos(x(4)))); %defines synaptic gating variable from I2 to any postsynapric cell
