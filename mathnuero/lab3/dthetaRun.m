close all;
clear;
clc;

% Set custom tolerance settings for higher accuracy
options = odeset("RelTol", 1e-6);

I = -0.1;  % Initial current

% Solve the ODE using ode45
[t, u] = ode45(@(t, u) the(t, u), [0, 300], [0; I], options);

% Compute modulated theta
umod = mod(u(:, 1), 2 * pi);

% Plot the results
figure;
plot(t, cos(pi - umod), 'b');  % Plot the first variable (theta1)
xlabel('Time ms');
ylabel('Voltage mV');
title('Evolution of  over voltage time, I = -0.1');
grid on;

% Define current values for multiple runs
ilist = [0.001, 0.005, 0.06];

% Create a figure for multiple simulations
figure;
hold on;

% First set of initial values
subplot(2, 1, 1);
hold on;
for i = ilist
    [t, u] = ode45(@(t, u) the(t, u), [0, 100], [0; i], options);
    umod = mod(u(:, 1), 2 * pi);
    plot(t, umod);
end
xlabel('Time (ms)');
ylabel('Theta ');
title('Theta Evolution');
grid on;
legend(arrayfun(@num2str, ilist, 'UniformOutput', false));

% Second set of initial values
subplot(2, 1, 2);
hold on;
for i = ilist
    [t, u] = ode45(@(t, u) the(t, u), [0, 100], [0; i], options);
    umod = mod(u(:, 1), 2 * pi);
    plot(t, cos(pi - umod));
end
xlabel('Time ms');
ylabel('Voltage mV');
title('Voltage over varrying I');
grid on;
legend(arrayfun(@num2str, ilist, 'UniformOutput', false));

hold off;


