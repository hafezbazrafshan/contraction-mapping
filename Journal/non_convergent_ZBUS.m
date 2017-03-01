clear all;
clc;



vS=[1;exp(-j*2*pi/3);exp(j*2*pi/3)];
yLa=1/2;
sLa=1/20;
iLa=-1/2;
yt=1/2;
sL=[sLa; sLa;sLa];
iL=[iLa;iLa;iLa];
yL=[yLa;yLa;yLa];
Y=[yt 0 0 ; 0 yt 0;0 0 yt]; 
Y_NS=-[yt,0,0;0,yt,0;0,0,yt]; 


maxIt=100;

vIterations=zeros(3,maxIt); 

Z=inv(Y+diag(yL)); 
w=-Z*Y_NS*vS;

vIterations(:,1)=w;

for it=2:maxIt
    
    
    fv=-conj(sL./vIterations(:,it-1))-abs(vIterations(:,it-1)).*iL;
    err= max(abs(fv-(Y+diag(yL))*vIterations(:,it-1)-Y_NS*vS)); 
    str=[num2str(err), '\n']; 
    fprintf(str);
    vIterations(:,it)=  (Y+diag(yL))\ (fv-Y_NS*vS);
    
    
end

vSol=vIterations(:,end); 

%% Checking for conditions:
CPQ=max( sum( abs(Z*diag(sL)*diag(1./w)),2)); 
cI=max(sum(abs(Z*diag(iL)),2));
K=1./min(abs(w));

C2PQ=max(sum( abs( Z*diag(sL)*diag(1./w)*diag(1./w)),2)); 
c2I=2*max(sum(abs(Z*diag(iL)*diag(1./w)),2));
