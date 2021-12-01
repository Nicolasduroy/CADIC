function population = initPopulation(N,V)
	% Generate the initial population
    % rand generates random nummer between 0 and 1 
    population = zeros(N,V);
   
    for i = 1: N
        for j = 1:V 
           population(i,j) = rand; 
        end 
    end 
	
   
end
