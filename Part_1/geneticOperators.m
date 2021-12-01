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
                if x <0.5
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
             %S = randperm(V,1);
             pareto = parents(:,end-1)~=1;
             pareto = sum(pareto);
             if ~pareto
                cd_index = parents(:,end)<Inf;
                cds = parents(cd_index,end);
                average = mean(cds);
                stdev = std(cds);
                uncrowdedind = (parents(:,end)-average) > 15*stdev;
                uncrowdedparents = parents(uncrowdedind,:);
                if isempty(uncrowdedparents)
                    l = randperm(height(parents),1);
                    children(child,:)= parents(l,(1:V));
                    x = rand;
                    z = randperm(V,1);   
                    children(child,z) = children(child,z)*(1-(x-1)*0.5);
                else
                    l = randperm(height(uncrowdedparents),1);
                    children(child,:)= uncrowdedparents(l,(1:V));
                    x = rand;
                    z = randperm(V,1);   
                    children(child,z) = children(child,z)*(1-(x-1)*0.2);
                end
             else
                l = randperm(height(parents),1);
                children(child,:)= parents(l,(1:V));
                x = rand;
                z = randperm(V,1);   
                children(child,z) = children(child,z)*(1-(x-1)*0.2);
             end

             children(child,:)= parents(l,(1:V));
             x = rand;
             z = randperm(V,1);   
             children(child,z) = children(child,z)*(1-(x-1)*0.2);
             %children(child,z) = 1-children(child,z);    % only change one element, we can also change more. or choose random how much we change everytime.  
            
               

		end
	end
	
	children = evaluatePopulation(children,f,NC,V,M,lb,ub);
end
