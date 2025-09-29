close all; clear;

tspan = [0, 100];   

% Set initial conditions
v(1)=-70;
m(1)= .5;
h(1)=0.5;
n(1)=0.5;
g_k=80; 
v_k=-100;
u0=[v(1) m(1) h(1) n(1)]';

% Solve HH system of ODEs specified in HH_prime for vector u = [v,m,h,n]

[t,u] = ode45(@(t,u) rtm4a(t,u),tspan,u0); 
t1 = t;
nv1=u(:,1);
n1= g_k.*u(:,4).^4.*(v_k-nv1);
[t,u] = ode45(@(t,u) rtm4a2(t,u),tspan,u0); 
% Define individual variables from numerical solution vector u
t2=t;
nv2=u(:,1);
n2= g_k.*u(:,4).^2.*(v_k-nv2);

figure
hold on
plot(t1, n1, '-r', 'LineWidth', 2);
plot(t2, n2, '-b', 'LineWidth', 2);
set(gca, 'FontSize', 16);

title('Current vs. Time', 'FontSize', 20); % Title of the plot
xlabel('Time (ms)', 'FontSize', 16); % X-axis label
ylabel('Current mA', 'FontSize', 16); % Y-axis label

legend('n^4 (Red)', 'n^2 (Blue)', 'Location', 'Best'); % Legend
hold off

figure
hold on
plot(t1, nv1, '-r', 'LineWidth', 2);
plot(t2, nv2, '-b', 'LineWidth', 2);
set(gca, 'FontSize', 16);

title('Voltage vs. Time', 'FontSize', 20); % Title of the plot
xlabel('Time (ms)', 'FontSize', 16); % X-axis label
ylabel('Voltage mV', 'FontSize', 16); % Y-axis label

legend('n^4 (Red)', 'n^2 (Blue)', 'Location', 'Best'); % Legend
hold off


