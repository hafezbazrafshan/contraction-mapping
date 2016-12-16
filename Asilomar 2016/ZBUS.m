function [  success, vSol, vIterations, err,itSuccess ] = ZBUS( network , vPr, maxIt)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 3
    maxIt=5;
end
success=0;
itSuccess=[];
v2struct(network); 
err=inf+zeros(maxIt+1,1);
Lambda=diag(w); 
Lambda_max=max(abs(w)); 
Lambda_min=min(abs(w)); 

vIterations=zeros(size(vPr,1),maxIt+1);
vIterations(:,1)=vPr;
fv= calculateIPQII(vPr, gMat, cMat, ePage, sL_load,iL_load,yL_load );
 err(1)=sum(abs(-vPr-Z*fv+w));
str=['Iteration No. ', num2str(0),' Error is ', num2str(err(1)), '\n'];
fprintf(str);
 for it=1:maxIt
     
      if err(it) <1e-5
     itSuccess=it-1;
     fprintf('Convergence \n');
     success=1;
     break;
      end 
 
vNew= Ycheck\ (-fv-Y_NS*v0);
vIterations(:,it+1)=vNew;

 
  fv= calculateIPQII(vNew, gMat, cMat, ePage, sL_load,iL_load,yL_load );
 err(it+1)=sum(abs(Ycheck*vNew+fv+Y_NS*v0));
 str=['Iteration No. ', num2str(it),' Error is ', num2str(err(it+1)), '\n'];
 fprintf(str);
 end
 
 
 vSol=vNew;
 







end

