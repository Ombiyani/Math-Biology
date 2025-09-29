%Code written by Maxwell Sherman 6/2012.

%Models a single excitory neuron based on theta model from NEURAL RHYTHMS

%Modified from code by Dorea Claassen 5/3/04-6/11/04 

clear all

%load parameters
tstop = 300; %length of trial
y0 = 0; %initial conditions for E cell
be = .001; %external applied current to E cell

%call function in ODE solver to get solution
%T is the time
%Y stores solution
tvalues = 0:.1:tstop; %set tstep (dt) for ODE solver. MATLAB can do this on
%its own, but for the Theta model, it is helpful for analytical purposes to
%set the step size.
[T Y] = ode23t(@theta_int_exc,tvalues,y0,[],be); %must use ode23t to get
%to get proper solution. ODE is stiff and errors accumulate quickly in
%numerical approximation. 

%taking cos(y) gives something akin to voltage trace
X = -cos(Y);

%Plot voltage trace
figure
plot(T,X)


%Spike sorting-------------------------------------------------------------

%need to build up a matrix S that will store time of a spike and
%the neuron that spikes.
%for this modle, only excitory neuron (neuron 1) is spiking

k = 0;
%k steps through lenght of S (used to load times/neuron index into S)
i = 1; %if more than 1 nueron were in the network, you could use a for loop
%here to iterate through the various neurons.
for j = 2:length(T) %step through the length of T
    if X(j,i)>.99 && X(j,i)>X(j-1,i) && X(j,i)>X(j+1,i) %if statement
        %identifies if you are at a miximum in X (the voltage trace)
        k=k+1; %used to index into the matrix S
        S(k,1)=T(j); %first colum stores time at which maximum occurs
        S(k,2)=i; %second column records the neuron in which maxima occurs
    end
end

% Use the matrix S do define coordinates on the rasterplot and draw a line
% through this point.  Cell 1 (exc) is on the bottom, cell 2 (inh) is on the top

%Create raster plot (AKA scattergram)
figure
l=1; %l steps through S and plots every entry as a line
    while(l<=size(S,1))
        if S(l,2)==1
            col=[0 0 0];
        end
    line([S(l,1) S(l,1)],[S(l,2)-0.47 S(l,2)+0.47],'LineWidth',1.5,'color',col)
    l=l+1;
    end 
axis([0 tstop .5 2.5])
set(gca,'Xtick',0:50:300,'Fontsize',15)
set(gca,'Ytick',1:2)
set(gca,'Yticklabel',{'Exc.';'Inh.'},'Fontsize',20,'Fontweight','bold')
xlabel('Spike times (ms)','Fontsize',20)

%Output frequency of E cell
NumExSpikes=length(find(S(:,2)==1)); %finds all instances of E cell spikes 
Freq=NumExSpikes*(1000/tstop); %divides # of spikes duration of trial
