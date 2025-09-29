function dxdt = theta_int_exc_inh_sys(t,x,be,bi,gei,te,gie,ti)
%defines a function that is dtheta/dt for one exc nueron and inhibitory neuron
%system. Includes E-I and I-E synapses
dxdt = zeros(4,1);
dxdt(1) = (1-cos(x(1)))+(be-(gie*x(4)))*(1+cos(x(1))); %defines theta for E cell
dxdt(2) = (1-cos(x(2)))+(bi+(gei*x(3)))*(1+cos(x(2))); %defines theta for I cell
dxdt(3) = -x(3)/te+((1-x(3))/.1)*exp(-5*(1+cos(x(1)))); %defines sej where j is any postsynaptic neuron
dxdt(4) = -x(4)/ti+((1-x(4))/.1)*exp(-5*(1+cos(x(2)))); %defines sij where j is any postsynaptic neuron

