function evalpopulation = evaluatePopulation(population,f,N,V,M,lb,ub)

	% Take only the variables from old population and append to
	% evalpopulation, while appending evalueted values at the end

    pop_temp = zeros(N,V);
	 for i = 1:N
         population_temp = [];
       for j = 1:V 
            population_temp = [population_temp , (population(i,j) * (ub(j)-lb(j))) + lb(j)];
       end
       pop_temp(i,:) = population_temp;
     end 
    %lb && ub
	% Calculate objectives here
    p = f(pop_temp);
	evalpopulation = [population, p];
end
