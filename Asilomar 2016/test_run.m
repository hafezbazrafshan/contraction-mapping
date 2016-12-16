% typical run
clear all;
%% 1. Setup loads and data

setupIEEE123; 

%% 2. run Z-Bus
performZBusIEEE123; 


%% 3. Setup sweep:
setupIEEE123Sweep; 

%% 4. Run Sweep
performSweepIEEE123; 

%% plot results
plot_loadflowIEEE123; 