%Code written by Maxwell Sherman 6/2012.

%Models simple two cell PING system with one excitory and one inhibitory
%neuron. Based on theta model from NEURAL RHYTHMS

%See theta_exc.m for additional comments. 

%Modified from code by Dorea Claassen 5/3/04-6/11/04 

clear all
close all

%load in all parameters
tstop = 1000; %length of trial
y0 = [0,0,0,0]; %initial conditions for E cell, I cell, sei, sie
be = .06; %external applied current on excitory cell
bi = -.01; % external applied current on inhibitory cell
gei = 0.2; %synaptic strength excitatory to inhibitory, default 0
gie = 0.1; %synaptic strength inhibitory to excitatory, default 0 
te = 2; %time-constant AMPA (excitory to inhibitory)
ti = 10; %time constant GABA (inihbitory to excitory)

%call function in ODE solver to get solutions for four variables
%T is the time
%Y stores solutions in four columns: [theta e cell, theta I cell, sei, sie]
tvalues = 0:.1:tstop; %unnecessary to specify tstep in this model, but
%helpful for analytical purposes later. 
%bvals = 0.7
bvals = linspace(0, 1,10);
for i = bvals
    bi = -0.01;
    gie = i;
    [T Y] = ode45(@theta_int_exc_inh_sys,tvalues,y0,[],be,bi,gei,te,gie,ti);
    %Any ODE solver can be used, but ode45 is fastest. 
    
    %taking cos(y) gives something akin to voltage trace
    X(:,1) = -cos(Y(:,1));
    X(:,2) = -cos(Y(:,2));
    
    %Plot voltage trace
    figure
    plot(T,X(:,1),'-',T,X(:,2),'--');
    xlabel(num2str(gei))
    %Spike sorting------------------------------------------------------------

    %make a raster
    %need to build up a matrix S that will store time of a spike and
    %the neuron that spikes

    k = 0;
    %k steps through length of S (used to load times/neuron index into S)
    for i = 1:2 %for loop steps through both cells
        for j = 2:length(T)
            if j == length(T) && X(j,i)>.99 && X(j,i)>X(j-1,i)
                k=k+1;
                S(k,1)=T(j);
                S(k,2)=i;
            elseif X(j,i)>.99 && X(j,i)>X(j-1,i) && X(j,i)>X(j+1,i) 
                k=k+1;
                S(k,1)=T(j);
                S(k,2)=i;
            end
        end
    end
    % 
    % % Use the matrix S to define coordinates on the rasterplot and draw a line
    % % through this point.  Cell 1 (exc) is on the bottom, cell 2 is on the top
    % 
    % figure
    % l=1;
    %     while(l<=size(S,1))
    %         if S(l,2)==1
    %             col=[0 0 0];
    %         elseif S(l,2)==2
    %             col=[0.5 0.5 0.5];
    %         end
    %     line([S(l,1) S(l,1)],[S(l,2)-0.47 S(l,2)+0.47],'LineWidth',1.5,'color',col)
    %     l=l+1;
    %     end 
    % axis([0 tstop .5 2.5])
    % set(gca,'Xtick',0:50:300,'Fontsize',15)
    % set(gca,'Ytick',1:2)
    % set(gca,'Yticklabel',{'Exc.';'Inh.'},'Fontsize',20,'Fontweight','bold')
    % xlabel('Spike times (ms)','Fontsize',20)
    % 
    % %Output frequency
    % 
    % NumExSpikes=length(find(S(:,2)==2)); %find spikes in inh cell
    % Freq_inh=NumExSpikes*(1000/tstop)
    % NumExSpikes=length(find(S(:,2)==1)); %find spike in exc cell
    % Freq_exc=NumExSpikes*(1000/tstop)
    
    %Plots for synaptic gating variables
    % figure
    % shift=100; %used to shift window of plot 100ms into trial
    % subplot(2,1,2)
    % plot(T-shift,Y(:,3),'color','black','Linewidth',2) %plot sei
    % xlim([0 100])
    % ylim([0 1.1])
    % set(gca,'Xtick',0:25:100)
    % set(gca,'ytick',[0 .5 1],'Fontsize',15)
    % 
    % xlabel(num2str(be),'Fontsize',15)
    % ylabel('s_{ei}, excitation','Fontsize',15)
    % subplot(2,1,1)
    % plot(T-shift,Y(:,4),'color',[0.5 0.5 0.5],'Linewidth',2) %plot sie
    % xlim([0 100])
    % set(gca,'Xtick',0:25:100)
    % ylim([0 1.1])
    % set(gca,'ytick',[0 .5 1],'Fontsize',15)
    % ylabel('s_{ie}, inhibition','Fontsize',15)
end