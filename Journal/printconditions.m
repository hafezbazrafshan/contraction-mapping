function [ C1,C2,C3,C4 ] = printconditions( Lambda_max, w_min, rho_min, ...
    cyPQ, cyI, cDELTAPQ, cDELTAI,....
    dyPQ, dyI, dDELTAPQ, dDELTAI,filename)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here



C1= ['1- ', num2str(double( Lambda_max/w_min)),'R']; 
C2= ['1- ',num2str(double(2*Lambda_max/rho_min)),'R']; 
C3=[num2str(double(cyPQ)), '/', '(1- ', num2str(double(Lambda_max/w_min)),'R)','+',...
    num2str(double(cDELTAPQ)), '/', '(1- ', num2str(double(2*Lambda_max/rho_min)),'R)','+',...
    num2str(double(cyI)), '+', num2str(cDELTAI)];
C4=[num2str(double(dyPQ)), '/', '(1- ', num2str(double(Lambda_max/w_min)),'R)^2','+',...
    num2str(double(dDELTAPQ)), '/', '(1- ', num2str(double(2*Lambda_max/rho_min)),'R)^2','+',...
    num2str(double(dyI)),'/','(1- ', num2str(double(Lambda_max/w_min)),'R)',...
    '+', num2str(dDELTAI),'/', '(1- ', num2str(double(2*Lambda_max/rho_min)),'R)'];

if exist('Text results')~=7
    mkdir 'Text results';
end

cd('Text results'); 
filename=[filename,'.txt'];
fileID=fopen(filename,'w');
fprintf(fileID,[C1,'\n', C2, '\n', C3, '\n', C4, '\n']); 
fclose(fileID); 
cd('..'); 

end

