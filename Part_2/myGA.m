function [population,it] = myGA(f,V,M,lb,ub,N,NP,NC,P,eta,PC)
	% myGA(f,V,M,lb,ub)
	% f : function to minimize
	% V : Dimension of the search space.
	% M : Number of objectives.
	% lb = lower bound vector.
	% ub = upper bound vector. 

	%% DEFINITION OF THE PARAMETERS

% 	N = 50;    % Population size
% 	NP = 25;    % Size of the mating pool 
% 	NC = 25;    % Number of children generated by generation
% 	P = 0.4;     % probability of recombination
	verbose = false; % (true) plots each iteration
    q = [];
    gem = [];
    crowdis = [];
    qnew=10;
    
	%% GENETIC ALGORITHM

	% Generation of the intial population
	population = initPopulation(N,V); % [10 *2] 

	population = evaluatePopulation(population,f,N,V,M,lb,ub); %10*3

	population = sortPopulation(population,V,M,qnew);

	% Main loop
	
%%%%%%%%%%%%%%%%%%%%%%%% \\ Do not change this part of the code!!
	it = 1;
	runFlag = true;
	while runFlag
%%%%%%%%%%%%%%%%%%%%%%%% \\ Proceed with changes below!
		parents = selectionTournament(population,NP,V,M);	

		offspring = geneticOperators(parents,f,N,NC,P,V,M,lb,ub,eta,PC);

		population = [ population(:,1:V+M) ; offspring(:,1:V+M) ]; % vertical on eachother 

		population = sortPopulation(population,V,M,qnew);

		population = cropPopulation(population,N);

        

		% Visualization
		if verbose
			illustratePopulation(population,V,M,lb,ub,it);
			drawnow;
			pause(0.1);
        end
		it = it+1;
        %% set first time 
        if it == 2
            fitness = 0;
            for i = 1 : size(population,1)
                for m = 1:M 
                    fitness = fitness + population(i,V+m);
                    max_prev = 0;
                end 
            end 
            A_old = fitness + 15;
        end 
		[runFlag,A,qnew,m,crowd,max_crowd] = stopCriterion(population,V,M,A_old,it,max_prev);

        %q = [q qnew];
        A_old = [A_old A];
        %gem = [gem m];
        %crowdis = [crowdis crowd];
        max_prev = max_crowd;
    
        
    end
end
