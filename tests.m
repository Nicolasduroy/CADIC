clear all;
close all;
N = 10 ;
V = 2;
M = 4;
 population = zeros(N,M);
   
    for i = 1: N
        for j = 1:M 
           population(i,j) = rand; 
        end 
    end 
	
objectives=population ; 
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
                            score(k)= score(k) +1; % can we give them points if they are dominant and than give same points same rank? 
                    end 
               end 
               
            end 
        end 


N = length(objectives);
indices = [];
rank=[];
score = score +1 ; 
for s = 1: length(score) %  while all(score ==0)== false
    if all(score == 0)
        break 
    end 
    maxi = max(score);
    for i =  1 : N
        if score(i) == maxi
            indices = [indices i];
            rank(i) = s;
        end
    end
    score(indices)=(0);     
end 
 distance = zeros(N,1);
 ranks = rank(end);
 l=1;
 for k = 1:ranks
     rankindices = [];
     while(rank(indices(l))==k)
        rankindices = [rankindices indices(l)];
        l = l+1;
        if l>length(indices)
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
    
