function [flag,a] = stopCriterion(population,V,M,A_previous,it)
% Return :  1 if the GA must continue 
%           0 if the GA must stop
      
% %%%%%%%%%%%%%%%%% brainstorm 
% 
%           x = population(1:5,V+1);% objective 1 
%           y = population(1:5,V+2); %objective 2 %% on
%           k = boundary(x,y);  
% %           figure 
% %           plot(x,y,'.')
% %           hold on
% %           plot(x(k),y(k));
% 
%           l = sort(x);
%           q =sort(y);
%           
%           s = [l(1); x];
%           t = [q(1);y];
%           [kk,a] = boundary(s,t);
% %           
% %           figure 
% %           plot(s,t,'.')
% %           hold on
% %           plot(s(kk),t(kk));
% 
% 
% 
% 
% 
% % %           for i = 1:height(population) % doesn't work if not enough
% % %           elements rank 1. just take area of line through 5 best elements?
% % %                    if population(i,M+V+1) ~= population(i+1,M+V+1)   % take objective values of elements in first rank. 
% % %                         last_rank1=i;
% % %                         break
% % %                    end 
% % %           end 
% %           x = transpose(population(1:5,V+1));% objective 1 
% %           y = transpose(population(1:5,V+2)); %objective 2 %% only works for M=2 ( the whole area idee, go to variance for more flexibility.
% %           t = 1:numel(x);
% %           xy = [x;y];
% %          % t = 1:numel(xy);
% %           pp = spline(t,xy);
% %           tInterp = linspace(1,numel(x));
% %           xyInterp = ppval(pp, tInterp); 
% %           [k,A] = boundary(transpose(xyInterp(1,:)),transpose(xyInterp(2,:)));  
% % %           figure
% % %           plot(x,y,'o:')
% % %           hold on
% % %           plot(xyInterp(1,:),xyInterp(2,:))
% % %           plot(k);
% % %           legend({'Original data','Spline interpolation'},'FontSize',12)
% %
% %        





%% poging 3000 area
             flag = 1;
%           x = population(1:5,V+1);% objective 1 
%           y = population(1:5,V+2); %objective 2 %% on
%           k = boundary(x,y);  
% %           figure 
% %           plot(x,y,'.')
% %           hold on
% %           plot(x(k),y(k));
% 
%           l = sort(x);
%           q =sort(y);
%           
%           s = [l(1); x];
%           t = [q(1);y];
%           [kk,a] = boundary(s,t);


% %            %%%%% set stop criteria , if A-Aold = smaller as, stop
%              q = abs(a -A_previous)
%             if abs(a -A_previous) < 0.0000005 %%% need to check for suitable value 
%                  flag = 0 ;
%             end 

%%
    if it > 100 % still a time limit to be sure that we don't run indefinitly. 
        flag = 0;
    end
  a=2;

end