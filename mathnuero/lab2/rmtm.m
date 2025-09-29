function dudt= rmtm(t, u)

c=1;

g_na=100;
g_k=80; 
g_l=0.1;
%%%%%
g_m = .25;
%%%%%
v_na=50;  
v_k=-100;  
v_l=-67;

i_ext=5;

v=u(1);
m=u(2);
h=u(3);
n=u(4);
w=u(5);

    dudt(1)=(g_na*m^3*h*(v_na-v)+g_k*n^4*(v_k-v)+g_l*(v_l-v)+g_m*w*(v_k-v)+i_ext)/c;
    dudt(2)=(alpha_m(v)*(1-m)-beta_m(v)*m);
    dudt(3)=(alpha_h(v)*(1-h)-beta_h(v)*h);
    dudt(4)=(alpha_n(v)*(1-n)-beta_n(v)*n);
    dudt(5)= (w_inf(v)-w)/t_w(v);
    dudt=dudt'; %necessary to return a column vector

end