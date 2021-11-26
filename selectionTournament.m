function selection = selectionTournament(population,NP,V,M)

% for i = 1:M  need to change when M is not 

%  [~,indexes] = sort(population(V+1,:)); 
%  not the same as tournament, select two random nummers, and chose best (get out of local minima)
% once lost, out of population.

indexes=[];
objectives = population(:,V+1);
for i = 1:NP
  p = randperm(length(objectives),2);
  r1 = p(1);
  r2 = p(2);  
  
  obj1 = objectives(r1);
  obj2 = objectives(r2);
  objectives([r1,r2],:) = [];
  if obj1 < obj2 
    indexes = [indexes; r1];
  else 
    indexes = [indexes; r2];
  end 
end 
selection = population(indexes,:);

end