function population = initPopulation(N,V)
	% Generate the initial population
    % rand generates random nummer between 0 and 1 

     population = zeros(N,V);
%     %population(1,:) = 0;
%     population(end,:) = 1;
% 
 
    population(2,:) = 1;
    for i = 3: N   % N/2
        for j = 1:V 
           population(i,j) = rand; 
        end 
    end 
    
    for zero = 1:V
        population(zero,zero) = 0;
    end 
   for one = 1:V
       population(end-one,one) = 1;
   end 

    population(N/2,1:V/2) =  0;
    population(N/2+1,V/2:end) =  0;
    population(N/2+2,1:V/2) =  1;
    population(N/2+3,V/2:end) =  1;

end
