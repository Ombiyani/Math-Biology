%% Model Parameters Intialization- RUN THIS ALWAYS
clear;

gamma = [
    19.23, 12.53, 34.17, 14.07, 1.61, 0, 0, 3.82, 1.61, 0, 0, 0, 0, 0;
    12.53, 12.53, 27.47, 14.07, 1.61, 0, 0, 3.82, 1.61, 0, 0, 0, 0, 0;
    -23.45, -23.45, -52.93, -6.70, 0, 0, 0, -23.45, -33.50, 0, 0, -16.75, -16.75, -11.39;
    -3.35, -5.36, -6.03, -20.1, 0, 0, 0, -3.35, -6.70, 0, -2.01, -3.35, 0, -2.01;
    9.72, 0, 0, 0, 22.98, 34.17, 58.96, 7.77, 8.17, 0, 2.14, 0, 0, 0;
    0, 0, 0, 0, -23.45, -52.93, -8.71, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, -6.03, -6.03, -61.64, 0, 0, 0, 0, 0, 0, 0;
    1.47, 0, 0, 0, 0.47, 0, 0, 32.89, 5.36, 20.77, 8.71, 2.14, 0, 0;
    1.21, 0, 0, 0, 1.14, 0, 0, 46.90, 20.77, 8.71, 4.69, 0, 0, 0;
    -23.45, 0, 0, 0, -23.45, -23.45, -52.93, -2.01, -16.75, 0, -5.36, 0, 0, 0;
    0, 0, 0, 0, -2.68, -2.68, -61.64, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0.40, 1.88, 0, 0, 48.78, 34.17, 15.41;
    -23.45, 0, 0, 0, 0, 0, 0, -16.75, -16.75, -5.36, -23.45, -66.33, -8.71, 0;
    0, 0, 0, 0, 0, 0, 0, -9.38, -29.48, -28.14, 0, 0, 0, 0;
];

%intialize population 
population = diag(ones(14,1));

tspan = [0, 10];
u0=zeros(28, 1);


NueronLabels =["L2/3: RS", "L2/3: IB", "L2/3: LTS", "L2/3: FS", "L4: RS", "L4: LTS", "L4: FS", "L5: RS", "L5: IB", "L5: LTS", "L5: FS", "L6: RS", "L6: LTS", "L6: FS"];
%% Test run with normal population
% Solve HH system of ODEs specified in HH_prime for vector u = [v,m,h,n]

[t,u] = ode45(@(t,u)PACM_prime(t,u, population),tspan,u0); 

% Uniform time vector
N = length(t);
t_uniform = linspace(t(1), t(end), N);

dt = t_uniform(2) - t_uniform(1);
Fs = 1/dt;
freq = (0:N-1)*(Fs/N);
half_N = floor(N/2); % Nyquist Cutoff frequency

num_neurons = 14;  

for start_idx = 1:3:num_neurons
    figure;
    tiledlayout(3, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

    for offset = 0:2
        i = start_idx + offset;
        if i > num_neurons
            break;
        end

        x = u(:, i);
        x_uniform = interp1(t, x, t_uniform, 'linear');
        f = fft(x_uniform);

        % Time domain plot
        nexttile;
        plot(t_uniform, x_uniform, 'LineWidth', 1.2);
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(['Neuron ', NueronLabels(i), ' Output']);
        grid on;

        % Frequency domain plot
        nexttile;
        plot(freq(1:half_N), abs(f(1:half_N)), 'LineWidth', 1.2);
        xlabel('Frequency (Hz)');
        ylabel('Magnitude');
        title(['Neuron ', NueronLabels(i), ' Spectrum']);
        grid on;
        xlim([0 100]);  % only show 0–100 Hz - otherwise plots 0-1200 but nothing happens past 100
    end

    sgtitle(['Neuron Outputs and Spectra (Neurons ', num2str(start_idx), '–', num2str(min(start_idx+2,num_neurons)), ')']);
end

%% Testing single nueron population 
%RESETS POPULATION PERCENTAGE
population = diag(ones(14,1));

%choose the nueron to change the population [1-14], model order:
% “L2/3: RS”, “L2/3: IB”, “L2/3: LTS”, “L2/3: FS”, 
% "L4: RS”,  "L4: LTS”, “L4: FS”, 
% “L5: RS”, “L5: IB”, “L5: LTS”, “L5: FS”, 
% "L6: RS”, “L6: LTS”, “L6: FS”,

nueronNum = 1;
%choose nueron population percentage [0-1]
population_percentage = .5;

%running code ...
population(nueronNum , nueronNum) = population_percentage;

[t_1pop,u_1pop] = ode45(@(t,u)PACM_prime(t,u, population),tspan,u0); 

% Uniform time vector
N = length(t_1pop);
t_uniform = linspace(t_1pop(1), t_1pop(end), N);

dt = t_uniform(2) - t_uniform(1);
Fs = 1/dt;
freq = (0:N-1)*(Fs/N);
half_N = floor(N/2); % Nyquist Cutoff frequency

num_neurons = 14;  

for start_idx = 1:3:num_neurons
    figure;
    tiledlayout(3, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

    for offset = 0:2
        i = start_idx + offset;
        if i > num_neurons
            break;
        end

        x = u_1pop(:, i);
        x_uniform = interp1(t_1pop, x, t_uniform, 'linear');
        f = fft(x_uniform);

        % Time domain plot
        nexttile;
        plot(t_uniform, x_uniform, 'LineWidth', 1.2);
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(['Neuron ', NueronLabels(i), ' Output']);
        grid on;

        % Frequency domain plot
        nexttile;
        plot(freq(1:half_N), abs(f(1:half_N)), 'LineWidth', 1.2);
        xlabel('Frequency (Hz)');
        ylabel('Magnitude');
        title(['Neuron ', NueronLabels(i), ' Spectrum']);
        grid on;
        xlim([0 100]);  % only show 0–100 Hz - otherwise plots 0-1200 but nothing happens past 100
    end

    sgtitle(['Neuron Outputs and Spectra (Neurons ', num2str(start_idx), '–', num2str(min(start_idx+2,num_neurons)), '): Nueron ', NueronLabels(nueronNum), " at " num2str(population_percentage*100), "% alive"]);
end
%% Testing multiple nueron populations 
%RESETS POPULATION PERCENTAGE
population = diag(ones(14,1));

%choose the nueron to change the population [1-14], model order:
% “L2/3: RS”, “L2/3: IB”, “L2/3: LTS”, “L2/3: FS”, 
% "L4: RS”,  "L4: LTS”, “L4: FS”, 
% “L5: RS”, “L5: IB”, “L5: LTS”, “L5: FS”, 
% "L6: RS”, “L6: LTS”, “L6: FS”,
%fill list with nueron populations to change
nueronNum = [1, 2];
%choose nueron population percentage [0-1]
population_percentage = [.5, .5];

%loading population parameter
for i = 1:length(nueronNum)
    population(nueronNum(i), nueronNum(i)) = population_percentage(i);
end
label = "";
%making labels 
for i = 1:length(nueronNum)-1
    label = [label, NueronLabels(nueronNum(i)), ": " num2str(population_percentage(i)*100), "%, "];
end
label = [label, NueronLabels(length(nueronNum)), ": " num2str(population_percentage(i)*100), "%"];

%running code ...

[t_1pop,u_1pop] = ode45(@(t,u)PACM_prime(t,u, population),tspan,u0); 

% Uniform time vector
N = length(t_1pop);
t_uniform = linspace(t_1pop(1), t_1pop(end), N);

dt = t_uniform(2) - t_uniform(1);
Fs = 1/dt;
freq = (0:N-1)*(Fs/N);
half_N = floor(N/2); % Nyquist Cutoff frequency

num_neurons = 14;  

for start_idx = 1:3:num_neurons
    figure;
    tiledlayout(3, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

    for offset = 0:2
        i = start_idx + offset;
        if i > num_neurons
            break;
        end

        x = u_1pop(:, i);
        x_uniform = interp1(t_1pop, x, t_uniform, 'linear');
        f = fft(x_uniform);

        % Time domain plot
        nexttile;
        plot(t_uniform, x_uniform, 'LineWidth', 1.2);
        xlabel('Time (s)');
        ylabel('Amplitude');
        title(['Neuron ', NueronLabels(i), ' Output']);
        grid on;

        % Frequency domain plot
        nexttile;
        plot(freq(1:half_N), abs(f(1:half_N)), 'LineWidth', 1.2);
        xlabel('Frequency (Hz)');
        ylabel('Magnitude');
        title(['Neuron ', NueronLabels(i), ' Spectrum']);
        grid on;
        xlim([0 100]);  % only show 0–100 Hz - otherwise plots 0-1200 but nothing happens past 100
    end

    sgtitle(['Neuron Outputs and Spectra (Neurons ', num2str(start_idx), '–', num2str(min(start_idx+2,num_neurons)), '): Nuerons ', label]);
end



