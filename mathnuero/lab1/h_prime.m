function dh =h_prime(t, h, V)
    dh  = alpha_h(V)*(1-h)-beta_h(V)*h;
end