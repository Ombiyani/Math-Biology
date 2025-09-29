function dy = funkyDynamics(t,y,alpha1, alpha2,  beta1, beta2, gamma1, gamma2, sigma1, sigma2, mu1, mu2)
    
    dy = zeros(5,1);
    % N, Not heard
    dy(1) = gamma1*y(2)+gamma2*y(3)-beta1*y(1)*(y(2)+y(4))- beta2*y(1)*(y(3)+y(5))+mu1*y(4)+mu2*y(5);
    % S_1, Swayable opinion 1
    dy(2) = beta1*y(1)*(y(2)+y(4)) + sigma2*y(3)*(y(2)+y(4)) - sigma1*y(2)*(y(3)+y(5)) - alpha1*y(2) - gamma1*y(2);
    % S_2,Swayable opinion 2
    dy(3) = beta2*y(1)*(y(3)+y(5)) + sigma1*y(2)*(y(3)+y(5)) - sigma2*y(3)*(y(2)+y(4)) - alpha2*y(3) - gamma2*y(3);
    % US_1,Unswayable opinion 1
    dy(4) = alpha1*y(2)-mu1*y(4);
    % US_2,Unswayable opinion 2
    dy(5) = alpha2*y(3)-mu2*y(5);  

end