times15= [1984, 1989, 1990, 1991, 1997, 1999, 2000, 2001, 2002, 2003, 2004, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021];
data15 = [98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          1, 63, 57, 62, 50, 59, 72, 63, 58, 58, 51, 62, 65, 66, 60, 52, 51, 55, 58, 56, 55, 64, 66, 63, 65, 65, 65;
          1, 30, 36, 34, 46, 39, 27, 35, 40, 40, 47, 36, 34, 33, 40, 48, 38, 45, 43, 43, 45, 36, 34, 36, 35, 34, 35
          ];

normtimes15 = times15 - 1984;

times20 = [1991, 1997, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021];
data20 = [98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          1, 27, 32, 32, 33, 33, 35, 38, 35, 29, 28, 25, 29, 31, 33, 33, 35, 40, 35, 41, 42, 38, 39;
          1, 31, 30, 31, 33, 38, 31, 30, 33, 35, 41, 48, 43, 42, 41, 42, 42, 34, 34, 33, 35, 37, 38;
          ];

normtimes20 = times20- 1996+5;

times22 = [1995, 2001, 2003, 2006, 2007, 2008, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021];
data22 = [98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          1, 61, 61, 58, 61, 58, 50, 52, 53, 57, 57, 55, 65, 68, 64, 66, 64, 64;
          1, 33, 33, 36, 35, 38, 46, 43, 41, 39, 40, 41, 31, 29, 33, 31, 34, 34;
          ];


normtimes22 = times22- 1995;

times23 =  [1992, 1997, 2001, 2002, 2006, 2008, 2009, 2010, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021];
data23 = [98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
          1, 25, 31, 33, 35, 40, 38, 32, 38, 34, 36, 37, 41, 42, 45, 45, 45, 43;
          1, 69, 66, 65, 62, 58, 60, 67, 61, 64, 64, 62, 57, 57, 54, 55, 54, 57;
  ];

normtimes23 = times23- 1992;

timeplot = times23;
timechoice = normtimes23;
choice = data23;
datachoice =zeros(size(choice));
[~, colCount] = size(choice);
for i=1:colCount
  datachoice(:,i)= choice(:,i)/sum(choice(:,i));
end
datachoice = datachoice*100;


figure
plot(timeplot, datachoice, "Marker","o", 'LineStyle', 'none', 'LineWidth',3, "MarkerSize",5)


%% Data fitting to average tumor size

% parameters are a and b;
params_0 = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];  % guess of parameters [a,b]
lb = [0,0, 0,0, 0,0, 0,0];  % lower bounds of parameters (OPTIONAL)
ub = [5,5,1,1,1,1,1,1];    % upper bounds of parameters (OPTIONAL)
options = optimoptions('lsqnonlin','Display','iter');

% Call the code lsqnonlin
% First input is the function to be minimized
% Second input: initial guess of the parameters that you vary
% Third input: lb (OPTIONAL)
% Fourth input: up (OPTIONAL)
% Fifth input: options
p_best = lsqnonlin(@(p) err_funkyDynamics(p,datachoice(:,1:6), timechoice(1:6) ), params_0,lb,ub,options);

% The best parameters are...
best_alpha1 = p_best(1);
best_alpha2 = p_best(2);
best_beta1 = p_best(3);
best_beta2 = p_best(4);
best_gamma1 = p_best(5);
best_gamma2 = p_best(6);
best_sigma1 = p_best(7);
best_sigma2 = p_best(8);
best_mu1 = p_best(9);
best_mu2 = p_best(10);

params1 = [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];  % guess of parameters [a,b]
lb1 = [0,0, 0,0, 0,0, 0, 0, 0, 0];  % lower bounds of parameters (OPTIONAL)
ub1 = [5,5,1,1,1,1,1, 1, 1, 1];   

p_best2 = lsqnonlin(@(p) err_funkyDynamics(p,datachoice(:,6:end), timechoice(6:end)), params1,lb1,ub1,options);

Abest_alpha1 = p_best2(1);
Abest_alpha2 = p_best2(2);
Abest_beta1 = p_best2(3);
Abest_beta2 = p_best2(4);
Abest_gamma1 = p_best2(5);
Abest_gamma2 = p_best2(6);
Abest_sigma1 = p_best2(7);
Abest_sigma2 = p_best2(8);
Abest_mu1 = p_best2(9);
Abest_mu2 = p_best2(10);



% Solve the model with the best-fitting parameters
y0 = [98, 0, 0, 1, 1];
[t1,y1] = ode45(@(t, y) funkyDynamics(t, y, best_alpha1, best_alpha2, best_beta1, best_beta2, best_gamma1, best_gamma2, best_sigma1, best_sigma2, best_mu1, best_mu2), [timechoice(1), timechoice(6)], y0);

[t2,y2] = ode45(@(t, y) funkyDynamics(t, y, Abest_alpha1, Abest_alpha2, Abest_beta1, Abest_beta2, Abest_gamma1, Abest_gamma2, Abest_sigma1, Abest_sigma2, Abest_mu1, Abest_mu2), [timechoice(6), timechoice(end)], y1(end,:));
% OPTION 2: Can solve over a longer period of time for predictions
% [t,y] = ode45(f,[times(1),100],V0);
t1 = t1+timeplot(1);
t2 = t2+timeplot(1);

% Plot the data on the reproduction curve
hold on
plot(t1, y1, "LineWidth",3)
hold on
plot(t2, y2, "LineWidth",3)

legend({"Nuetral data", '', '', 'Unswayble 1', 'Unswayble 2', 'Nuetral fit no-mu','Swayble 1 fit no-mu', 'Swayble 2 fit no-mu', 'Unswayble1 fit no-mu', 'Unswayble2 fit no-mu', '', '', '', 'Unswayble1 Mu', 'Unswayble2 Mu'}, 'FontSize', 15)
title("Fitted Data with new model in 2005", 'FontSize', 25)
xlabel('Year', "FontSize",15)
ylabel("Percent of Population", "FontSize",15)
















