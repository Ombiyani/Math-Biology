%Code written by Maxwell Sherman 6/2012.

%Models 4 cell theta system with two excitory and two inhibitory
%neurons with feedforward coupling only. Based on theta model from NEURAL RHYTHMS

%Modified from code by Dorea Claassen 5/3/04-6/11/04 

clear all

%load in all parameters
tstop = 300; %length of trial
y0 = [0,0,0,0,0,0,0,0]; %initial conditions for E cells, I cells, and gating variables
be = .06; %external current on excitory cell
bi = -.01; % external applied current on inhibitory cell
gie = 0.1; %synpatic strength inhibitory to excitory
gii = 0.1; %synaptic strenght inhibitory to inhibitory
gei = .2; %synpatic strength excitory to inhibitory 
gee = .2; %synaptic stregnth excitatory to excitatory
te = 2; %time-constant AMPA (excitory on inhibitory)
ti = 10; %time constant GABA (inihbitory to excitory)

%call function in ODE solver to get solutions for four variables
%T is the time
%Y stores solutions in four columns
tvalues = 0:.1:tstop;
[T Y] = ode45(@theta_int_4cell,tvalues,y0,[],be,bi,gei,te,gie,ti,gee,gii);

%taking cos(y) gives something akin to voltage trace
X(:,1) = -cos(Y(:,1)); %E1 trace
X(:,2) = -cos(Y(:,3)); %E2 Trace
X(:,3) = -cos(Y(:,2)); %I1 trace
X(:,4) = -cos(Y(:,4)); %I2 trace

%Plot voltage trace
figure
plot(T,X(:,1),'b-',T,X(:,2),'g-',T,X(:,3),'r--',T,X(:,4),'c--');

%my attempt to make a scattergram
%need to build up a matrix S that will store time of a spike and
%the neuron that spikes
%for this one, only excitory neuron is spiking

k = 0;
%k steps through lenght of S (used to load times/neuron index into S)
for i = 1:4; 
    for j = 2:length(T)
        if X(j,i)>.99 && X(j,i)>X(j-1,i) && X(j,i)>X(j+1,i) 
            k=k+1;
            S(k,1)=T(j);
            S(k,2)=i;
        end
    end
end

% Use the matrix S do define coordinates on the scattergram and plot each
% point 

figure
l=1;
    while(l<=size(S,1))
        if S(l,2)==1
            plot(S(l,1),S(l,2),'b.','MarkerSize',15)
            hold on
        elseif S(l,2)==2
            plot(S(l,1),S(l,2),'r.','MarkerSize',15)
            hold on
        elseif S(l,2)==3
            plot(S(l,1),S(l,2),'g.','MarkerSize',15)
            hold on
        elseif S(l,2)==4
            plot(S(l,1),S(l,2),'c.','MarkerSize',15)
            hold on
        end
    l=l+1;
    end 
axis([0 tstop .5 5])
set(gca,'Xtick',0:50:300,'Fontsize',15)
set(gca,'Ytick',1:4)
set(gca,'Yticklabel',{'Exc.1';'Exc.2';'Inh.1';'Inh.2'},'Fontsize',20,'Fontweight','bold')
xlabel('Spike times (ms)','Fontsize',20);

%Output frequencies
NumExSpikes=length(find(S(:,2)==1));
Freq_E1=NumExSpikes*(1000/tstop) %E1 frequency
NumExSpikes=length(find(S(:,2)==2));
Freq_E2=NumExSpikes*(1000/tstop) %E2 frequency
NumExSpikes=length(find(S(:,2)==3));
Freq_I1=NumExSpikes*(1000/tstop) %I1 frequency
NumExSpikes=length(find(S(:,2)==4));
Freq_I2=NumExSpikes*(1000/tstop) %I2 frequency