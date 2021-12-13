clear;

addpath('interfaceEldo'); % Add folder to path so it can be executed
eldo_setup; % Setup the eldo licence


%Lower and upper bounds of resistor and capacitor values
%VAR W1 W2 W2 L1 L2 L3
%bounds
%Wb [240n 50u]

% for differential_pair .param W1=3u L1=1u Win=3u Lin=360n Wb=2u Lb=180n
% boundaries are sequential
%Vb = [] ; % or better not as parameter? need to guarantee sat? or will that be okay anyway for best objectieves? 
lb = [ 240e-9 180e-9 240e-9 180e-9 240e-9 180e-9];
ub = [ 50e-6 10e-6 50e-6 10e-6 50e-6 10e-6];


% i(v2); 3.00000000000e-06 -5.00949944123e-05
% v(vout) 3.00000000000e-06 8.21984375799e-01



%interfaceEldo('differential_pair',[20e-6 3e-6 20e-6 3e-6 5e-6 1e-6])

%											V=9,M=2

res = myGA(@(x) interfaceEldo('differential_pair',x),6,2,lb,ub);
