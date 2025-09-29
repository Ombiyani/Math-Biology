function dudt=HH_primeInf(t, u)

c=1;
g_k=9; 
g_na=35;
g_l=0.1;
v_k=-90;
v_na=55;
v_l=-65;

i_ext=0.2;

v=u(1);
h=u(2);x
n=u(3);
m = alpha_m(v)/(alpha_m(v)+beta_m(v));
    dudt(1)=(g_na*m^3*h*(v_na-v)+g_k*n^4*(v_k-v)+g_l*(v_l-v)+i_ext)/c;
    dudt(2)=(alpha_h(v)*(1-h)-beta_h(v)*h);
    dudt(3)=(alpha_n(v)*(1-n)-beta_n(v)*n);
    
    dudt=dudt'; %necessary to return a column vector

end