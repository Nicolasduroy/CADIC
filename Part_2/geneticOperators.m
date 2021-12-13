<<<<<<< HEAD
function children = geneticOperators(parents,f,N,NC,P,V,M,lb,ub)

	children = zeros(NC,V);
    even = mod(NC/2,2);
    if even ~= 0
        children(ceil(NC/2),:)= parents(1,1:V);
        children(ceil(NC/2),2)= 1-parents(1,2);
        children(ceil(NC/2),4)= 1-parents(1,4);
    end 


	for child = 1:(NC/2)
=======
function children = geneticOperators(parents,f,N,NC,P,V,M,lb,ub,eta)
	children = zeros(NC,V);
	for child = 1:NC/2
>>>>>>> 653137422dc487acfcc82e3ca24f852d1fccc55e
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
            
             p = randperm(size(parents,1),2);
             
            for v = 1:V
                x =rand;
                if x <0.5
                    children(child,v)= parents(p(1),v);
<<<<<<< HEAD
                    children(end-child+1,v)= parents(p(2),v);
                else
                    children(child,v)= parents(p(2),v);
                    children(end-child+1,v)= parents(p(1),v);
                end 
            end
             x = rand;
             z = randperm(V,1);   
             children(child,z) =children(child,z)*(1-(x-1)*0.2);
             children(end-child+1,z) = children(end -child+1,z)*(1-(x-1)*0.2);
             if x <0.3
               
                z = randperm(V,1);   
                children(child,z) =x;
                children(end-child+1,z) = x;
             end 
   

            %% cyclic cross over ?? 
            
            
=======
                    children(child+1,v)= parents(p(2),v); 
                else
                    children(child,v)= parents(p(2),v);
                    children(child+1,v)= parents(p(1),v);
                end 
            end

            %Simulated Binary Crossover
%             p = randperm(height(parents),2);
%             for v = 1:V
%                 [c1, c2] = districross(parents(p(1),v),parents(p(2),v),eta);
%                 children(child,v) = c1;
%                 children(child+1,v) = c2;
%             end
>>>>>>> 653137422dc487acfcc82e3ca24f852d1fccc55e
            
          
        else
            l = randperm(size(parents,1),1);
            children(child,:)= parents(l,(1:V));
<<<<<<< HEAD
            children(end-child+1,:)= parents(l,(1:V));
            x = rand;
            z = randperm(V,1);   
            children(child,z) = children(child,z)*(1-(x-1)*0.2);
            children(end-child+1,z) = children(end -child+1,z)*(1-(x-1)*0.2);
=======
            x = rand;
            z = randperm(V,1);   
            children(child,z) = children(child,z)*(1-(x-1)*0.2);
>>>>>>> 653137422dc487acfcc82e3ca24f852d1fccc55e
		end
	end
	
	children = evaluatePopulation(children,f,NC,V,M,lb,ub);
end

% % Do mutation
%              %S = randperm(V,1);
%              pareto = parents(:,end-1)~=1;
%              pareto = sum(pareto);
%              if ~pareto
%                 cd_index = parents(:,end)<Inf;
%                 cds = parents(cd_index,end);
%                 average = mean(cds);
%                 stdev = std(cds);
%                 uncrowdedind = (parents(:,end)-average) > 5*stdev;
%                 uncrowdedparents = parents(uncrowdedind,:);
%                 if isempty(uncrowdedparents)
%                     l = randperm(height(parents),1);
%                     children(child,:)= parents(l,(1:V));
%                     x = rand;
%                     z = randperm(V,1);   
%                     children(child,z) = children(child,z)*(1-(x-1)*0.2);
%                 else
%                     l = randperm(height(uncrowdedparents),1);
%                     children(child,:)= uncrowdedparents(l,(1:V));
%                     x = rand;
%                     z = randperm(V,1);   
%                     children(child,z) = children(child,z)*(1-(x-1)*0.2);
%                 end
%              else
