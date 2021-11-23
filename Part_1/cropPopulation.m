function new = cropPopulation(old,N)
	% Remove excess population
% 	randomIndices = randperm(size(old,1)); % Use this to generate a list of randomised indices
% 	new = old(randomIndices(1:N),:);

%% we don't want it random, want to keep the best. 
new = old((1:N),:);

end
