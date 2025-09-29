function dudt = the(t, u)
    dudt = zeros(2,1); 
    dudt(1) = 1 - cos(u(1)) + u(2) * (1 + cos(u(1))); 
    dudt(2) = 0; 
end
