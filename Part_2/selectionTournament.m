function selection = selectionTournament(population,NP,V,M)

% for i = 1:M  need to change when M is not 

%  [~,indexes] = sort(population(V+1,:)); 
%  not the same as tournament, select two random nummers, and chose best (get out of local minima)
% once lost, out of population.

<<<<<<< HEAD

indexes=[1; 2 ;3];
objectives = population(:,V+1:end);
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
=======
objectives = population(:,V+M+1:end);
p = randperm(size(objectives,1),size(population,1));
indexes=[];

for i = 1:2:NP*2
 r1 = p(i);
 r2 = p(i+1);  
>>>>>>> 653137422dc487acfcc82e3ca24f852d1fccc55e
 
  rank_obj1 = objectives(r1,1);
  rank_obj2 = objectives(r2,1);
  crow_obj1 = objectives(r1,2);
  crow_obj2 = objectives(r2,2); 

<<<<<<< HEAD
 objectives([r1,r2],:) = 0;

  x= rand;
  if x <1
=======
  x= rand;
  if x <0.2
>>>>>>> 653137422dc487acfcc82e3ca24f852d1fccc55e
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