function sorted = sortPopulation(unsorted,V,M)

if (M==1) % Single Objective   %  so we crop the useless ones
	%sorted = sort(unsorted);

   
    objectives = unsorted(:,V+M);

    [~,indexes]=sort(objectives);

    sorted = unsorted(indexes,:);
	
else % Multi-objective case : non-domination sorting
 
    %% Ranking % introducing it here, will be used in cropping. Rank most important, in same rank : crowding distance highest
	%% check for optimal points : not both objectives can be improved, if one can be improved doesn't matter.
    objectives = unsorted(:,(V+1:V+M));
    rank = zeros(size(objectives,1),1);
    indices = zeros(size(objectives,1),1);
    ind_indices = 1;
    rank1count = 0;

    ndom_k = zeros(size(objectives,1),1);
    S_k = cell(size(objectives,1),1);
    for k = 1: size(objectives,1)
        dom_k = [];
        ndom = 0;
        for j = 1: size(objectives,1)
            if k~=j
                domin = false;
                domed = false;
                for q = 1:M
                    if objectives(k,q) > objectives(j,q)
                        domed = true;
                    elseif objectives(k,q) < objectives(j,q) 
                        domin = true;
                    end
                    if domed && domin
                        break;
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
            indices(ind_indices) = k;
            ind_indices = ind_indices+1;
            rank1count = rank1count+1;
        end
    end 
    front = zeros(rank1count,1);
    frontind = 1;
    for i = 1:size(rank,1)
        if rank(i)==1
            front(frontind) = i;
            frontind = frontind+1;
        end
    end
    rankcount = 1;
    frontcount = 1;
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
                    indices(ind_indices) = dompoints(l);
                    ind_indices = ind_indices+1;
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
 N = size(objectives,1);
 distance = zeros(N,1);
 ranks = max(rank);

 ranknum = zeros(max(rank),1);
 currank=1;
 for i = 1:length(rank)
     if(rank(indices(i))==currank)
         ranknum(currank) = ranknum(currank)+1;
     else
         currank = currank+1;
         ranknum(currank) = ranknum(currank)+1;
     end 
 end

 l=1;
 for k = 1:ranks
     rankindices = zeros(ranknum(k),1);
     p = 1;
     while(rank(indices(l))==k)
        rankindices(p) = indices(l);
        p = p+1;
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
 totrankindices = zeros(N,1);
 ind_totrank = 1;
 l=1;
 for y = 1:ranks
    rankindices = zeros(ranknum(y),1);
    distances = zeros(ranknum(y),1);
    while(rank(indices(l))==y)
        rankindices(l-ind_totrank+1) = indices(l);
        distances(l-ind_totrank+1) = distance(indices(l));
        l = l+1;
        if l>N 
            break;
        end
    end 
    [~, sortind] = sort(distances,'descend');
    rankindices = rankindices(sortind);    
    totrankindices(ind_totrank:ind_totrank+ranknum(y)-1) = rankindices;
    ind_totrank = ind_totrank + ranknum(y);
 end
 unsorted = cat(2,unsorted,rank);
 unsorted = cat(2,unsorted,distance);
 sorted = unsorted(totrankindices,:);
end
end