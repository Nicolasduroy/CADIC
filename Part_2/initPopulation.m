function population = initPopulation(N,V)
	% Generate the initial population
    % rand generates random nummer between 0 and 1 
<<<<<<< HEAD
     population = zeros(N,V);
%     %population(1,:) = 0;
%     population(end,:) = 1;
% 
 
    population(2,:) = 1;
    for i = 3: N   % N/2
=======
    population = zeros(N,V);
   
    for i = 1: N
>>>>>>> 653137422dc487acfcc82e3ca24f852d1fccc55e
        for j = 1:V 
           population(i,j) = rand; 
        end 
    end 
	
<<<<<<< HEAD

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

%     
%     for i = ((N/2)+2):N-1
%         for j = 1:V 
%            population(i,j) = 1-population(i-(N/2),j); 
%         end 
%     end 
%    
=======
   
>>>>>>> 653137422dc487acfcc82e3ca24f852d1fccc55e
end
