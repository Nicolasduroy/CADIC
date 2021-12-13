function evalpopulation = evaluatePopulation(population,f,N,V,M,lb,ub)

	% Take only the variables from old population and append to
	% evalpopulation, while appending evalueted values at the end


    pop_temp = zeros(size(population,1),V);


	 for i = 1:N
         population_temp = [];
       for j = 1:V 
            population_temp = [population_temp , (population(i,j) * (ub(j)-lb(j))) + lb(j)];
       end
       pop_temp(i,:) = population_temp;
     end 
    %lb && ub
	% Calculate objectives here
    neg = zeros(N,1);
    p = f(pop_temp);
%     for j = 1:N
%         for k = 1:M
%             if p(j,k)<0
%                 neg(j)=1;
%             end
%         end
%     end
%     for l = 1:N
%         if neg(l)
%             p(l,:) = ones(1,M);
%         end
%     end
	evalpopulation = [population,p];

end
