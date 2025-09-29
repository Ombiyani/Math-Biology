close all; clear;

tspan = [0, 50];   

% Set initial conditions
v(1)=-50;
m(1)=alpha_m(v(1))/(alpha_m(v(1))+beta_m(v(1)));
h(1)=0.6;
n(1)=0.4;

u0=[v(1) m(1) h(1) n(1)]';

% Solve HH system of ODEs specified in HH_prime for vector u = [v,m,h,n]

[t,u] = ode45(@(t,u)HH_prime(t,u),tspan,u0); 

% Define individual variables from numerical solution vector u
v=u(:,1);
m=u(:,2);
h=u(:,3);
n=u(:,4);

% Plot time traces for voltage and gating variables

subplot(211);
plot(t,v,'-k','Linewidth',2);
set(gca,'Fontsize',16);
title('v [mV]','Fontsize',20);

subplot(212);
plot(t,m,'-b',t,h,'-g',t,n,'-r','Linewidth',2);
set(gca,'Fontsize',16);
xlabel('t [ms]','Fontsize',20); 
title('m (blue), h (green), n (red)','Fontsize',20);

    


% Define individual variables from numerical solution vector u
tspan = [0,1000];
v0=[-50 0.6 0.4]';

[t1,v1] = ode45(@(t,u)HH_primeInf(t,u),tspan,v0); 

v11=v1(:,1);
h11=v1(:,2);
n11=v1(:,3);

% Plot time traces for voltage and gating variables
figure;
subplot(211);
plot(t1,v11,'-k','Linewidth',2);
set(gca,'Fontsize',16);
title('v [mV]','Fontsize',20);

subplot(212);
plot(t1,h11,'-g',t1,n11,'-r','Linewidth',2);
set(gca,'Fontsize',16);
xlabel('t [ms]','Fontsize',20); 
title('m (blue), h (green), n (red)','Fontsize',20);

shg;
