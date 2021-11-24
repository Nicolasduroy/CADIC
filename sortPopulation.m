function sorted = sortPopulation(unsorted,V,M)

if (M==1) % Single Objective   %  so we crop the useless ones
	%sorted = sort(unsorted);

   
    objectives = unsorted(:,V+M);

    [~,indexes]=sort(objectives);

    sorted = unsorted(indexes,:);
	
else % Multi-objective case : non-domination sorting
    
    %% Ranking % introducing it here, will be used in cropping. Rank most important, in same rank : crowding distance highest
	%% check for optimal points : not both objectives can be improved, if one can be improved doesn't matters.

    objectives=sorted(:,(V:V+M));
    rank= zeros(length(objectives),1);
    score= zeros(length(objectives),1);

        for k = 1: length(objectives)
            for j = 1: length(objectives)
               if objectives(k,1) < objectives(j,1) %% minimize right? want small as possible objectives. 
                    points = 0;
                    for q = 1:M 
                        if objectives(k,q) < objectives(j,q)
                               points = points +1 ;
                        end     
                    end                                         
                    if  points == M       
                            score(k)= score(k) +1; % give them points if they are dominant and than give same points same rank
                    end 
               end 
               
            end 
        end 


N = length(objectives);
indices = [];

score = score +1 ;  %  so no zero anymore 
for s = 1: length(score) %  while all(score ==0)== false
    if all(score == 0) %% loop will always end due to this statement. 
        break  
    end 
    maxi = max(score);
    for i =  1 : N
        if score(i) == maxi
            indices = [indices i];
            rank(i) = s; % rank 1  is best. 
        end
    end
    score(indices)=(0);      % put to zero if rank is assigned 
end 

    

    %% Crowding Distance
	
% only compare each of same rank 
% start with looking for max and min for each rank and give them CD =
% infinity. 
 % compare resting elements and give them a value based on. 
% https://www.youtube.com/watch?v=Z8vMa_ohRNY : very clear movie. I assume
% alle limits for every function get infinity. but that's not super sure. 



end
