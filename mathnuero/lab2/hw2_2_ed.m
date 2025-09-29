vRange = linspace(-100, 50, 1000);

figure;
plot(vRange, t_w(vRange), "-b")
title('t_w vs Voltage', 'FontSize', 20);
xlabel("Voltage [mV]", 'FontSize', 14);
ylabel("t_w", 'FontSize', 14);
grid on;

figure;
plot(vRange, w_inf(vRange), "-b")
title('w_{inf} vs Voltage', 'FontSize', 20);
xlabel("Voltage [mV]", 'FontSize', 14);
ylabel("w_{inf}", 'FontSize', 14);
grid on;