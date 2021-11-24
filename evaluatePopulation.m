function evalpopulation = evaluatePopulation(population,f,N,V,M,lb,ub)

	% Take only the variables from old population and append to
	% evalpopulation, while appending evalueted values at the end
	objectives = zeros(N,M);
     
    % everything written for V =2, M = 1 
	 for i = 1:N
       population_temp =[];
       for j = 1:V 
            population_temp = [population_temp , (population(i,j) * (ub(j)-lb(j))) + lb(j)];
       end
       for k = 1:M  
            p = f(k);
           objectives(i,k)= p(population_temp) ;
          %population_temp = [(population(i,j) * (ub(1)-lb(1))) + lb(1) , ((population(i,2)* (ub(2)-lb(2))) + lb(2))];
         % population_temp2 = (population(i,2)* (ub-lb)) + lb;
       end 
     end 
	
    %lb && ub
	% Calculate objectives here

	
	evalpopulation = [population, objectives];
end
