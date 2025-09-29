function err = err_funkyDynamics(params,data, times_norm)
% For use with lsqnonlin
% Inputs: parameters (to be optimized) and data (to compute error)
% Output: error in the data set as a vector
% lsqnonlin will minimize (err1^2 + err2^2 + ... + errn^2)
alpha1 = params(1);
alpha2 = params(2);
beta1  = params(3);
beta2  = params(4);
gamma1 = params(5);
gamma2 = params(6);
sigma1 = params(7);
sigma2 = params(8);
mu1 = params(9);
mu2 = params(10);
y0 = [98, 0, 0, 1, 1]; % initial volume is always 1mm^3
 % append initial time to data set
tspan = times_norm;

[~, y] = ode45(@(t, y) funkyDynamics(t, y, alpha1, alpha2, beta1, beta2, gamma1, gamma2, sigma1, sigma2, mu1, mu2), tspan, y0);
err = data'-y; % use a vector to get error at each point
% lsqnonlin will minimize the sum of squares of err
