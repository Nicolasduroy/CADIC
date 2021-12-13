% Clear workspace and figures to prevent unwanted behavior
clear;
close all;
clf;

% Choose 1d benchmark function]
%	Value : function
%		1 : paraboloid 
%		2 : paraboloid with different local and global minima 
%		3 : ZDT4 function
%		4 : ZDT6 function
bm = 4;


% Define boundaries and other paremeters
V = 2 + 4*(bm>2); % 2 for bm 1 and 2; 6 for ZDT functions
M = 1 + (bm>2); % 1 for bm 1 and 2; 2 for ZDT functions
lb = (-5+5*(bm>2))*ones(1,V); % -5 for bm 1 and 2; 0 for ZDT functions
ub = (5-4*(bm>2))*ones(1,V); % 5 for bm 1 and 2; 1 for ZDT functions


res1= myGA(@(x) benchmark(bm,x),V,M,lb,ub,50,25,25,0.5,5);

N = 30:20:200;
NP = 6:10:166;
NC = 6:10:166;
P = 0.1:0.1:0.9;
% N = 10:2:16;
% NP = 6:4:14;
% NC = 6:2:14;
% P = 0.1:0.3:1;
ResultsPop = [];


% Use your implementation of GA
for n = 1:length(N)
    for np = 1:length(NP)
        for nc = 1:length(NC)
            for p = 1:length(P)
                if NP(np)<=N(n)/2 && NP(np)<=NC(nc) && NC(nc)<=N(n)/2
                    tic
                    [res.pop, res.it] = myGA(@(x) benchmark(bm,x),V,M,lb,ub,N(n),NP(np),NC(nc),P(p),0.25);
                    time=toc
                    res.time = time;
                    res.N = N(n);
                    res.NP = NP(np);
                    res.NC = NC(nc);
                    res.P = P(p);
                    ResultsPop = [ResultsPop res];
                end
            end
        end
    end
    disp(n)
end


% Show local and global optima of benchmark 2
if (bm==2) % Change this to some other number to stop plotting!
	bm_ShowFunction
elseif (bm>2)
	% Plot solution
	hold on
	plot((.28*(bm==4):0.01:1),(bm==4)*(1-(.28*(bm==4):0.01:1).^2)+(bm==3)*(1-sqrt((.28*(bm==4):0.01:1)))) % plot of ZDT functions
	hold off
end


 %figure 
 %plot(1:length(q),q)