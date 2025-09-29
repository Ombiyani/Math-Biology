%____________________________________________________________
%6# 
t_span = [0, 10];
h_0 = 0;
V = [-80, 60, 20];

figure;
hold on;
for i = 1:length(V)
    [t, y] = ode45(@(t, h) h_prime(t, h, V(i)), t_span, h_0);
    plot(t, y);
end

xlabel('Time in ms');
ylabel('Probability');
title("Probability of Potassium Channel Opening given it was inactive")
legend(arrayfun(@num2str, V, 'UniformOutput', false)+ " mV");
hold off;

