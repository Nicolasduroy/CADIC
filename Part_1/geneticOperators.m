function children = geneticOperators(parents,f,N,NC,P,V,M,lb,ub)

	children = zeros(NC,V);
	for child = 1:(NC/2)
		if rand<P
			% Do recombination %% make 2 childs form 2  parents. %% also insert
            % mutation here 
            %crossover = rand; 
         %%% 1 point crossover 
%             v = randperm(V,1);
%             p = randperm(height(parents),2);
%            
%                 children(child,1:v)= parents(p(1),1:v); 
%                 children(child,v:V)= parents(p(2),v:V);
%                 children(child+1,1:v)= parents(p(2),1:v); 
%                 children(child+1,v:V)= parents(p(1),v:V); 
%                 
%            
%             
            %%% uniform cross over 
            
             p = randperm(height(parents),2);
             
            for v = 1:V
                x =rand;
                if x <0.3
                    children(child,v)= parents(p(1),v);
                    children(child+1,v)= parents(p(2),v); 
                else
                    children(child,v)= parents(p(2),v);
                    children(child+1,v)= parents(p(1),v);
                end 
            end

            %% cyclic cross over ?? 
            
            
            
          
		else
			% Do mutation

              l = randperm(height(parents),1);
              %S = randperm(V,1);
    
              

             children(child,:)= parents(l,(1:V));
             x = rand;
             z = randperm(V,1);   
             %children(child,z) = x;
             children(child,z) = 1-children(child,z);    % only change one element, we can also change more. or choose random how much we change everytime.  
            
               

		end
	end
	
	children = evaluatePopulation(children,f,NC,V,M,lb,ub);
end
