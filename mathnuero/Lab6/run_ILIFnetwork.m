% run_ILIFnetwork.m
% Script to run ILIFnetwork.m

% 1D ring network
% set network size n 
n = 50;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose network coupling:
% 1 = nearest-neighbor
% 2 = all-to-all coupling
% 3 = random sparse connectivity

network_coupling=3;

W = ConnectivityMatrix(n,network_coupling);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[spiketimes]=ILIFnetwork(n,W);
