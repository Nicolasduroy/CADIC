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
    rank= zeros(height(objectives),1);
    indices = [];

    ndom_k = zeros(height(objectives),1);
    S_k = cell(height(objectives),1);
    for k = 1: height(objectives)
        dom_k = [];
        ndom = 0;
        for j = 1: height(objectives)
            if k~=j
                domin = false;
                domed = false;
                for q = 1:M
                    if objectives(k,q) > objectives(j,q)
                           domed = true;
                    elseif objectives(k,q) < objectives(j,q)
                        domin = true;
                    end
                end
                if xor(domed, domin)
                    if domed
                        ndom = ndom + 1;
                    else
                        dom_k = [dom_k j];
                    end
                end
            end
        end
        ndom_k(k) = ndom;
        S_k{k} = dom_k;
        if ndom == 0
            rank(k) = 1;
            indices = [indices k];
        end
    end 
    front = [];
    frontcount = 1;
    for i = 1:height(rank)
        if rank(i)==frontcount
            front = [front i];
        end
    end
    while ~isempty(front)
        frontcount = frontcount + 1;
        nextfront = [];
        for m = 1:length(front)
            dompoints = S_k{front(m)};
            for l = 1:length(dompoints) %iterate through each dominated point
                ndom_k(dompoints(l)) = ndom_k(dompoints(l)) - 1;
                if ndom_k(dompoints(l)) == 0 
                    nextfront = [nextfront dompoints(l)];
                    rank(dompoints(l)) = frontcount;
                    indices = [indices dompoints(l)];
                end
            end
        end
        front = nextfront;
    end
    

    %% Crowding Distance
	
% only compare each of same rank 
% start with looking for max and min for each rank and give them CD =
% infinity. 
 % compare resting elements and give them a value based on.
  N = height(objectives);
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