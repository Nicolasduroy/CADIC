function children = geneticOperators(parents,f,N,NC,P,V,M,lb,ub)

	children = zeros(NC,V);
	for child = 1:NC
		if rand<P
			% Do recombination
            %crossover = rand; 
         
           for v = 1:V 
            p = randperm(height(parents),1);
            children(child,v)= parents(p,v); 
           end 
		else
			% Do mutation

              l = randperm(height(parents),1);
              

             children(child,:)= parents(l,(1:V));
             x = rand;
             z = randperm(V,1);   
             children(child,z) = x;    % only change one element, we can also change more. or choose random how much we change everytime.  
            
               

		end
	end
	
	children = evaluatePopulation(children,f,NC,V,M,lb,ub);
end
