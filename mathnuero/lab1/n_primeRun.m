%____________________________________________________________
%2# 
t_span = [0, 10];
n_0 = 0;
V = linspace(-80, 60, 8);
figure;
hold on;
for i = 1:length(V)
    [t, y] = ode45(@(t, n) n_prime(t, n, V(i)), t_span, n_0);
    plot(t, y);
end

xlabel('Time in ms');
ylabel('Probability');
title("Probability of Potassium Channel Opening")
legend(arrayfun(@num2str, V, 'UniformOutput', false)+ " mV");
hold off;


%____________________________________________________________
%3#
g_k = 36;
V_k = -90;
I_k = @(n,v) -g_k.*n.*(v-(V_k));
figure;
hold on;
for i = 1:length(V)
    [t, y] = ode45(@(t, n) n_prime(t, n, V(i)), t_span, n_0);
    y = I_k(y, V(i));
    plot(t, y);
end

xlabel('Time in ms');
ylabel('Ionic Current');
title("Potassium Ionic Current Evolution")
legend(arrayfun(@num2str, V, 'UniformOutput', false)+ " mV");
hold off;


