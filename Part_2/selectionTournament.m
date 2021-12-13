function selection = selectionTournament(population,NP,V,M)

% for i = 1:M  need to change when M is not 

%  [~,indexes] = sort(population(V+1,:)); 
%  not the same as tournament, select two random nummers, and chose best (get out of local minima)
% once lost, out of population.

objectives = population(:,V+1:V+M);

indexes=[1; 2 ;3];

for i = 4:NP
    
 p = randperm(size(objectives,1),2);
 r1 = p(1);
 r2 = p(2);  
 while objectives(r1,1)== 0
     r1 = randperm(size(objectives,1),1);
 end 
 while objectives(r2,1)== 0
     r2 = randperm(size(objectives,1),1);
 end 
 
  rank_obj1 = objectives(r1,1);
  rank_obj2 = objectives(r2,1);
  crow_obj1 = objectives(r1,2);
  crow_obj2 = objectives(r2,2); 

 objectives([r1,r2],:) = 0;

  x= rand;
  if x <0.8
     if rank_obj1 < rank_obj2 
         indexes = [indexes; r1];
     elseif  rank_obj1 > rank_obj2
         indexes = [indexes; r2]; 
     elseif rank_obj1 == rank_obj2
         if crow_obj1 < crow_obj2 
            indexes = [indexes; r2];
         else 
            indexes = [indexes; r1];
         end 
     end 
  else
     if crow_obj1 < crow_obj2 
        indexes = [indexes; r2];
     else 
        indexes = [indexes; r1];
     end 
 
  end 
end 
selection = population(indexes,:);

end