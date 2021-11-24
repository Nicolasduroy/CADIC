function children = geneticOperators(parents,f,N,NC,P,V,M,lb,ub)

	children = zeros(NC,V);
	for child = 1:NC
		if rand<P
			% Do recombination
            %crossover = rand; 
              a =1;
              b = length(parents)-M;
              q = ceil((b-a).*rand + a);   %randperm does it also
              r = ceil((b-a).*rand + a);  % random numer between 1  and amount parents
            
             children(child,:)=[parents(q,1), parents(r,2)] ; % more random! 
		else
			% Do mutation
            

              a =1; %randperm??
              b = length(parents)-M;
              p = ceil((b-a).*rand + a); % random numer between 1  and amount parent
            
              

             children(child,:)= parents(p,(1:V));
             x = rand;
             children(child,ceil(rand*2)) = x;    % change when V is not 2 anymore. 
            
               

		end
	end
	
	children = evaluatePopulation(children,f,NC,V,M,lb,ub);
end
