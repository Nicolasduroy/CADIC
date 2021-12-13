function obj = interfaceEldo(foldername,x)
	%% 	'foldername' 	name of the folder containing the following files you will simulate.
	%		If you simulate dc, 'dc_proto' is expected (the same for ac (ac_proto) and tran (tran_proto))
	%% 	'x' 			contains the different sets of parameter values of circuit instances that are simulated.
	%%%% x can be matrix, each row 1 set>.
	%% IMPORTANT: This block of code works as-is.
	% It is advised that you only keep the simulations you need and comment the ones you don't.
	% Be aware that changing anything inside this block (except commenting when you are sure it's not necessary), things might not work any more.
	
    % Perform DC simulation of 'foldername'
    injectValues(foldername,x,'dc');
    unix(['eldo interfaceEldo/' foldername '/dc']);% > /dev/null']);
    dataDC = extractDC(foldername);
    
    % Perform Transient simulation of 'foldername'
    injectValues(foldername,x,'tran');
    unix(['eldo interfaceEldo/' foldername '/tran']);% > /dev/null']);
    dataTran = extractTran(foldername);
    
     % Perform AC simulation of 'foldername'
     injectValues(foldername,x,'ac');
     unix(['eldo interfaceEldo/' foldername '/ac']);% > /dev/null']);
     dataAC = extractAC(foldername);
    
    %% Example plots of data, showing how it is extracted for different instances
    % Remove these when you don't need them!
%     for j=1:size(x,1)
%         plot(dataTran{j}.time,dataTran{j}.X);
%         drawnow;
%         pause;
%     end
%     
%      for j=1:size(x,1)
%         loglog(dataAC{j}.f, sum([dataAC{j}.RX dataAC{j}.IX].^2,2) );
%         drawnow;
%          pause;
%      end
    
    %% Form your objectives here!
    % The objectives you need (at least) are Gain-Bandwidth and Power, more are optional
    obj = zeros(size(x,1),2); % Change second dimension when adding more objectives!
    % minimize power
    %vdd * 1/2 * u*cox*W/L*(Vgs-Vt)^2 
    % can we use model constans?
     % or just use Ids m5?
    %maximize GBW
    %gm /Cl lets take Cl = 5.1p (just to be sure to take in account
    %parasitcs
    % gm from 2* Ids/(vgs-vth) vgs as vgs = vin - vnode ; vth from model?
    % all fun and stuff these formula's but just take is from ac
    % simulation.

    % so need current plot
    % power = vdd *Idsm5
    %ac plot for GBW
    % gain = value for f =0 on AC plot
    % BW = f on AC plot where gain =gainf0 - 3dB 




    obj(:,1) = abs(dataDC())*1.8 ; %Power    %% only works for 1 set at the time. change if you do more! %% extra term to jjust impoveimportance in fitnes function.
%    
 
    %%%%
    elements = length(dataAC{1}.f);
    bandwidth = dataAC{1}.f;
    magnitude = sum([dataAC{1}.RX dataAC{1}.IX].^2,2);

    gain = 10 * log10(sum([dataAC{1}.RX dataAC{1}.IX].^2,2)); % not sure if it is right transistion to dB .
    
    for i = 1:elements
        if gain(i) <= gain(1) -3  % then it should be in decibel. , otherwis recalculate. 
           BW = bandwidth(i);
           break      
        end
        if i == elements
            BW = 0;
        end 
    end 

    obj(:,2) = -BW * gain(1);  % problem is that our fitnes function is not same for both. GWB way more influence than power! (because values much higer)
    
    
    for i = 1:size(obj,1)
        if obj(i,1) <= 0.5e-05
            if  obj(:,2) >=0  
                obj(i,1) = 1;
            end 
        end 
    end 



end

