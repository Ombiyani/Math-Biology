function u = spectral_ode_solver(f, u0, tspan, N)
    % Solves a periodic ODE using a Fourier spectral method.
    % Inputs:
    %   f      - function handle for ODE: du/dt = f(u,t)
    %   u0     - initial condition (vector for multiple modes)
    %   tspan  - [t0, tf] time interval
    %   N      - number of Fourier modes
    % Output:
    %   u      - solution at collocation points
    
    % Time discretization
    t0 = tspan(1);
    tf = tspan(2);
    t = linspace(t0, tf, N+1)'; % Periodic grid (N+1 points for periodicity)
    t = t(1:end-1); % Remove duplicate endpoint
    
    % Compute Fourier differentiation matrix
    k = [0:N/2 -N/2+1:-1]'; % Fourier wave numbers
    D = 1i * diag(k); % Fourier differentiation operator
    
    % Convert initial condition to Fourier space
    u_hat = fft(u0);
    
    % Solve the ODE in Fourier space using Runge-Kutta 4 (RK4)
    dt = (tf - t0) / N;
    for n = 1:N
        % Evaluate in physical space
        u = ifft(u_hat);
        k1 = fft(f(u, t(n)));
        k2 = fft(f(ifft(u_hat + (dt/2) * k1), t(n) + dt/2));
        k3 = fft(f(ifft(u_hat + (dt/2) * k2), t(n) + dt/2));
        k4 = fft(f(ifft(u_hat + dt * k3), t(n) + dt));
        
        % RK4 update in Fourier space
        u_hat = u_hat + (dt/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
    
    % Convert back to physical space
    u = ifft(u_hat);
end
