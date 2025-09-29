function W = ConnectivityMatrix(n,network_coupling)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pass in variables to define network size and choice for network
% connectivity

% Set up connectivity matrix/adjacency matrix W

% 1D ring network
% set network size n 
% n = 50;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose network coupling:
% 1 = nearest-neighbor
% 2 = all-to-all coupling
% 3 = random sparse connectivity

% network_coupling=1;

switch(network_coupling)
    case 1 % % nearest neighbor coupling
% % set radius of connectivity crad, # of outgoing synapses per neuron =
% % 2*crad

        crad = 1;

        W = zeros(n);
        for k=1:crad
            W = W +diag(ones(n-k,1),k)+diag(ones(n-k,1),-k);
        end

        % add synapses to end cells = periodic boundary conditions
        for k=crad:-1:1
            for j=crad:-1:k
                W(n-(j-k),k) = 1;
                W(k,n-(j-k)) = 1;
            end
        end
        clear crad j k
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 2 % all-to-all coupling
        W = ones(n);
        W = W - diag(ones(n,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 3 % % random sparse connectivity with 2*crad outgoing synapses per neuron
% % start with all-to-all coupling and set n-2*crad synapses to zero
        crad = 23;

        W = ones(n);
        W = W - diag(ones(n,1));

        %loop through rows of W
        for i=1:n
            % randomly determine which synaptic connections to zero out
            allconnects = randperm(n);
            noconnect=allconnects(1:(n-1)-2*crad);
            %Errorcheck so autapses are not included
            checki=find(noconnect==i);
            if ~isempty(checki)
                noconnect(checki)=allconnects(n-2*crad+1);
            end
            % zero out synaptic connections
            W(i,noconnect) = 0;

        end
        clear crad allconnects noconnect checki i

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    otherwise
        disp('not a valid network coupling case selection')
end