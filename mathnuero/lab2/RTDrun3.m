close all; clear;
tspan = [0, 50];   

% Set initial conditions
v(1)=-70;
m(1)= .5;
h(1)= .5;
n(1)= .5;

u0=[v(1) m(1) h(1) n(1)]';

% Solve HH system of ODEs specified in HH_prime for vector u = [v,m,h,n]

[t,u] = ode45(@(t,u) rtm3(t,u),tspan,u0); 

% Define individual variables from numerical solution vector u
v=u(:,1);
m=u(:,2);
h=u(:,3);
n=u(:,4);

% Plot time traces for voltage and gating variables
figure;
subplot(211);
plot(t,v,'-k','Linewidth',2);
set(gca,'Fontsize',16);
title('v [mV]','Fontsize',20);

subplot(212);
plot(t,m,'-b',t,h,'-g',t,n,'-r','Linewidth',2);
set(gca,'Fontsize',16);
xlabel('t [ms]','Fontsize',20); 
title('m (blue), h (green), n (red)','Fontsize',20);


[t,u] = ode45(@(t,u) rtm3a(t,u),tspan,u0); 

% Define individual variables from numerical solution vector u
v=u(:,1);
m=u(:,2);
h=u(:,3);
n=u(:,4);

% Plot time traces for voltage and gating variables
figure;
subplot(211);
plot(t,v,'-k','Linewidth',2);
set(gca,'Fontsize',16);
title('v [mV]','Fontsize',20);

subplot(212);
plot(t,h+n,'-b',t,h,'-g',t,n,'-r','Linewidth',2);
set(gca,'Fontsize',16);
xlabel('t [ms]','Fontsize',20); 
title('h+n (blue), h (green), n (red)','Fontsize',20);


v(1)=-70;
m(1)= .5;
h(1)= .5;
n(1)= .5;

u0=[v(1) m(1) h(1) n(1)]';

[t,u] = ode45(@(t,u) rtm3rest(t,u),tspan,u0); 

% Define individual variables from numerical solution vector u
v=u(:,1);
m=u(:,2);
h=u(:,3);
n=u(:,4);

% Plot time traces for voltage and gating variables
figure;
subplot(211);
plot(t,v,'-k','Linewidth',2);
set(gca,'Fontsize',16);
title('v [mV]','Fontsize',20);

subplot(212);
plot(t,h+n,'-b',t,h,'-g',t,n,'-r','Linewidth',2);
set(gca,'Fontsize',16);
xlabel('t [ms]','Fontsize',20); 
title('h+n (blue), h (green), n (red)','Fontsize',20);
