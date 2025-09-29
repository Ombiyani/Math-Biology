function dm =m_prime(t, m, V)
    dm(1) = alpha_m(V)*(1-m)-beta_m(V)*m;
end