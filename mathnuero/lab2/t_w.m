function t_w = t_w(v)
    t_w = 400./(3.3*exp((v+35)/20)+exp(-(v+35)/20));
end