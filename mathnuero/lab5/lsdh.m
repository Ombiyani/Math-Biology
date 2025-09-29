% --- Parameters ---
Fs = 1000;                     % Sampling frequency (Hz)
T = 1/Fs;                      % Sampling period
L = 1000;                      % Length of signal (number of samples)
t = (0:L-1)*T;                 % Time vector

% --- Signal: A non-repeating sine wave ---
f_signal = 7.3;                % Non-integer frequency (Hz)
data = sin(2*pi*f_signal*t);  % Sine wave that does NOT complete full cycles

% --- Remove DC component (optional) ---
data = data - mean(data);

% --- Apply window (optional) to reduce edge artifacts ---
window = hann(L)';
data_windowed = data .* window;

% --- Compute FFT ---
Y = fft(data_windowed);        % Fast Fourier Transform
P2 = abs(Y/L);                 % Two-sided spectrum
P1 = P2(1:L/2+1);              % One-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);   % Correct amplitude

% --- Frequency axis ---
f = Fs*(0:(L/2))/L;

% --- Plot ---
plot(f, P1)
xlabel('Frequency (Hz)')
ylabel('|Amplitude|')
title('FFT of Non-Repeating Sinusoidal Signal')
grid on