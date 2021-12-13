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

% for i = 1:1
%     res1= myGA(@(x) benchmark(bm,x),V,M,lb,ub,50,25,25,0.5,10);
% end

% 
% N = 30:10:200;
% NP = 30:10:150;
% NC = 30:10:150;
N = 60;
NP = 25;
NC = 70;
P = 0.7;
PC = 0.7; %Probability of using SBX
ETA = 0:1:20;
% N = 10:2:16;
% NP = 6:4:14;
% NC = 6:2:14;
% P = 0.1:0.3:1;
ResultsPop = [];

% Use your implementation of GA
for n = 1:length(N)
    for np = 1:length(NP)
        for nc = 1:length(NC)
            for eta = 1:length(ETA)
                if NP(np)<=N(n)/2 && NP(np)<=NC(nc)
                    time=0;
                    ittot=0;
                    for f = 1:100
                    tic;
                    [res.pop, iter] = myGA(@(x) benchmark(bm,x),V,M,lb,ub,N(n),NP(np),NC(nc),P,eta,PC);
                    time = time+toc;
                    ittot = ittot+iter;
                       end
                    res.time = time/100;
                    res.it = iter/100;
                    res.N = N(n);
                    res.NP = NP(np);
                    res.NC = NC(nc);
                    res.eta = ETA(eta);
                    ResultsPop = [ResultsPop res];
                end
            end
        end
    end
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

%% 
time=[];
for i = 1:length(ResultsPop)
    time = [time ResultsPop(i).time]
end
plot(ETA,time)
