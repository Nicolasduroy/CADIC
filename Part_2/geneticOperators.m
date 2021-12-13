function children = geneticOperators(parents,f,N,NC,P,V,M,lb,ub,eta,PC)
	children = zeros(NC,V);
	for child = 1:NC/2
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
            if rand>PC
             p = randperm(size(parents,1),2);
             
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
            else
            %Simulated Binary Crossover
            p = randperm(height(parents),2);
            for v = 1:V
                [c1, c2] = districross(parents(p(1),v),parents(p(2),v),eta);
                children(child,v) = c1;
                children(child+1,v) = c2;
            end
            end
          
        else
            l = randperm(size(parents,1),1);
            children(child,:)= parents(l,(1:V));
            x = rand;
            z = randperm(V,1);   
            newparam = children(child,z)*(1-(x-0.5)*0.5);
            if newparam>1 
                newparam = 1;
            end
            children(child,z) = newparam;
            
		end
	end
	
	children = evaluatePopulation(children,f,NC,V,M,lb,ub);
end

