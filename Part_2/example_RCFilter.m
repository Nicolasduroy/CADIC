clear;

addpath('interfaceEldo'); % Add folder to path so it can be executed
eldo_setup; % Setup the eldo licence

%Lower and upper bounds of resistor and capacitor values
%VAR W1 W2 W2 L1 L2 L3
%bounds
%Wb [240n 50u]
lb = [ 1e-6 1e-9	];
ub = [ 10e-6 5e-9];

interfaceEldo('circuit1',[1 0.01])

%											V=9,M=2
%res = myGA(@(x) interfaceEldo('circuit1',x),9,2,lb,ub);
