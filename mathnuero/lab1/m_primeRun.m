%____________________________________________________________
%6# 
t_span = [0 10];
m_0 = 0;
V = linspace(-80, 60, 8);

figure;
hold on;
for i = 1:length(V)
    [t, y] = ode45(@(t, m) m_prime(t, m, V(i)), t_span, m_0);
    plot(t, y);
end

xlabel('Time in ms');
ylabel('Probability');
title("Probability of Sodium Channel Opening given it was closed")
legend(arrayfun(@num2str, V, 'UniformOutput', false)+ " mV");
hold off;

h_0 = 1;


figure;
hold on;
for i = 1:length(V)
    [t, y] = ode45(@(t, h) h_prime(t, h, V(i)), t_span, h_0);
    plot(t, y);
end


xlabel('Time in ms');
ylabel('Probability');
title("Probability of Sodium Channel Opening given it was inactive")
legend(arrayfun(@num2str, V, 'UniformOutput', false)+ " mV");
hold off;



g_na = 120;
V_na = 70;
I_na = @(m,h,v) -g_na.*m.*h.*(v-(V_na));
figure;
hold on;
for i = 1:length(V)
    [t1, y1] = ode45(@(t, x) m_h_prime(t, x, V(i)), [0 1000], [m_0, h_0]);
    y = I_na(y1(:, 1), y1(: , 2), V(i));
    plot(t1, y); 
end

xlabel('Time in ms');
ylabel('Ionic Current');
title("Sodium Ionic Current Evolution")
legend(arrayfun(@num2str, V, 'UniformOutput', false)+ " mV");
hold off;

