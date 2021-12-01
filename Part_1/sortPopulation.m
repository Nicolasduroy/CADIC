function sorted = sortPopulation(unsorted,V,M)

if (M==1) % Single Objective   %  so we crop the useless ones
	%sorted = sort(unsorted);

   
    objectives = unsorted(:,V+M);

    [~,indexes]=sort(objectives);

    sorted = unsorted(indexes,:);
	
else % Multi-objective case : non-domination sorting
    
    %% Ranking % introducing it here, will be used in cropping. Rank most important, in same rank : crowding distance highest
	%% check for optimal points : not both objectives can be improved, if one can be improved doesn't matter.

    objectives=unsorted(:,(V+1:V+M));
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
                        score(k)= score(k) +1; % give them points if they are dominant and then give same points same rank
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
 distance = zeros(N,1);
 ranks = max(rank);
 l=1;
 totindices = [];
 for k = 1:ranks
     rankindices = [];
     while(rank(indices(l))==k)
        rankindices = [rankindices indices(l)];
        l = l+1;
        if l>N 
            break;
        end
     end 
     for m = 1:M
        unsortedrank = objectives(rankindices,m);
        [~, indexsort] = sort(unsortedrank);
        rankindices = rankindices(indexsort);
        fmin = objectives(rankindices(1),m);
        fmax = objectives(rankindices(end),m);
        distance(rankindices(1)) = Inf;  
        distance(rankindices(end)) = Inf;
        for r = 2:length(rankindices)-1
            dist = objectives(rankindices(r+1),m)-objectives(rankindices(r-1),m);
            dist = dist/(fmax-fmin);
            distance(rankindices(r)) = distance(rankindices(r))+dist; 
        end
     end
 end

 totrankindices = [];
 l=1;
 for y = 1:ranks
    rankindices = [];
    distances = [];
    while(rank(indices(l))==y)
        rankindices = [rankindices indices(l)];
        distances = [distances distance(indices(l))];
        l = l+1;
        if l>N 
            break;
        end
    end 
    [~, sortind] = sort(distances,'descend');
    rankindices = rankindices(sortind);    
    totrankindices = [totrankindices rankindices];
 end
 unsorted = cat(2,unsorted,rank);
 unsorted = cat(2,unsorted,distance);
 sorted = unsorted(totrankindices,:);
    end
end