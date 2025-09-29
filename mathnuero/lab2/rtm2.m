function dudt=rtm2(t, u)

c=1;
g_k=80; 
g_na=100;
g_l=0.1;
v_k=-100;
v_na=50;
v_l=-67;

i_ext=1.5;

v=u(1);
m=alpha_m(v)/(alpha_m(v)+beta_m(v));
n=u(4);
h=1-u(4);

    dudt(1)=(g_na*m^3*h*(v_na-v)+g_k*n^4*(v_k-v)+g_l*(v_l-v)+i_ext)/c;
    dudt(2)=0;
    dudt(3)=0;
    dudt(4)=(alpha_n(v)*(1-n)-beta_n(v)*n);
    
    dudt=dudt'; %necessary to return a column vector

end