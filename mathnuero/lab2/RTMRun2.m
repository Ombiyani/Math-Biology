close all; clear;

tspan = [0, 50];   

% Set initial conditions
v(1)=-70;
m(1)= .5;
h(1)=0.5;
n(1)=0.5;

u0=[v(1) m(1) h(1) n(1)]';

% Solve HH system of ODEs specified in HH_prime for vector u = [v,m,h,n]

[t,u] = ode45(@(t,u) rtm2(t,u),tspan,u0); 

% Define individual variables from numerical solution vector u
v=u(:,1);
m=u(:,2);
h=(1-u(:,4));

n=u(:,4);

% Plot time traces for voltage and gating variables

subplot(211);
plot(t,v,'-k','Linewidth',2);
set(gca,'Fontsize',16);
title('v [mV]','Fontsize',20);

subplot(212)
plot(t,(h+n),'-k','Linewidth',2);
set(gca,'Fontsize',16);
title('(h+n)','Fontsize',20);


