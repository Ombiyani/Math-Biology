function dx =m_h_prime(t, x, V)
    dx= zeros(2,1);
    dx(1) = alpha_m(V)*(1-x(1))-beta_m(V)*x(1);
    dx(2) = alpha_h(V)*(1-x(2))-beta_h(V)*x(2);
end