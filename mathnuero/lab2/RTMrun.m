close all; clear;

tspan = [0, 100];   

% Set initial conditions
V = [100, 110, 120, 130, 140, 150, 160, 170];
m(1)=0;
h(1)=0;
n(1)=0;
w(1)=0;
figure;
hold on
for i = 1:length(V)
    u0=[V(i) m(1) h(1) n(1) w(1)]';
    % Solve HH system of ODEs specified in HH_prime for vector u = [v,m,h,n]
    
    [t,u] = ode45(@(t,u) rmtm(t,u),tspan,u0); 
    
    % Define individual variables from numerical solution vector u
    v=u(:,1);
    
    % Plot time traces for voltage and gating variables
    plot(t,v,'Linewidth',2);
   

end

title('Ca^{+2} model, I_{ext} = 5mv','Fontsize',20);
ylabel('Current(mA)');
xlabel("time(ms)")
legend(arrayfun(@num2str, V, 'UniformOutput', false)+ " mV");
hold off;









