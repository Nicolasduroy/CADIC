function sorted = sortPopulation(unsorted,V,M)

if (M==1) % Single Objective   %  so we crop the useless ones
	%sorted = sort(unsorted);

   
    objectives = unsorted(:,V+M);

    [~,indexes]=sort(objectives);

    sorted = unsorted(indexes,:);
	
else % Multi-objective case : non-domination sorting
    
    %% Ranking
	

    %% Crowding Distance
	


end
