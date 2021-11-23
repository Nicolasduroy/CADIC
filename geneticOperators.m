function children = geneticOperators(parents,f,N,NC,P,V,M,lb,ub)

	children = zeros(NC,V);
	for child = 1:NC
		if rand<P
			% Do recombination
		else
			% Do mutation
		end
	end
	
	children = evaluatePopulation(children,f,NC,V,M,lb,ub);
end
