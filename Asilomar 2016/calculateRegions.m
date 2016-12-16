function [ validRange, alphaVec, lambdaMaty, lambdaMatDELTA, wy,wDELTA ...
    cyPQ, cyI, cDELTAPQ, cDELTAI, dyPQ, dyI, dDELTAPQ, dDELTAI,...
    lambdaResultsMag,allNodesActualLabelsWithRegs] = calculateRegions( network ,lambdaMat,...
    plotOptions, figurename)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
allNodesActualLabelsWithRegs=[];
lambdaResultsMag=[];


if nargin < 2
    plotOptions='no-plots';
    figurename='';
%     lambdaMat=eye(length(network.w));
lambdaMat=diag(network.w);
end

% this code uses v2struct

v2struct(network); 

Jy=find(sum(abs(cMat),2)==1);  %wyeIndices
Jd=find(sum(abs(cMat),2)==2); % deltaIndices




Zy=Z(:,Jy);
sy=sL_load(Jy,1); 
iy=iL_load(Jy,1); 
wy=w(Jy,1);
 [ZDELTA,sDELTA,iDELTA,wDELTA]=...
     calculateZDELTA(Z, sL_load(Jd,1), iL_load(Jd,1),...
     Jd, phaseNodesLinIndices, phaseNodes,...
     unavailableIndices, availableIndices,w);
% w_min=min(abs(w)); 
% rho_min=min(abs(wDELTA));

SY=diag(sy); 
IY=diag(iy); 
SDELTA=diag(sDELTA); 
IDELTA=diag(iDELTA); 
WY=diag(abs(wy)); 
WDELTA=diag(abs(wDELTA)); 





% lambdaMat=diag(w); 
lambdaMaty=lambdaMat(Jy,Jy); 
lambdaMatDELTA=calculateGammaMatd(lambdaMat,...
    Jd, phaseNodesLinIndices, phaseNodesLinIndices,...
    unavailableIndices, availableIndices);
Lambda_max=max(max(abs(diag(lambdaMat))));
Lambda_min=min(min(abs(diag(lambdaMat))));


% cyPQ=max(sum(abs( inv(lambdaMat)*Zy*SY...
%     *diag(1./wy)),2));
% cyI=max(sum(abs(inv(lambdaMat)*Zy*diag(iy)),2));
% cDELTAPQ=max(sum(abs(inv(lambdaMat)*ZDELTA...
%     *diag(sDELTA)*diag(1./wDELTA)),2));
% cDELTAI=max(sum(abs(inv(lambdaMat)*ZDELTA...
%     *diag(iDELTA)),2));
% 
% 
% dyPQ=max(sum(abs( inv(lambdaMat)*Zy*...
%     lambdaMaty*diag(sy)*diag(1./wy)*diag(1./wy)),2));
% dyI=2*max(sum(abs(inv(lambdaMat)*Zy*...
%     lambdaMaty*diag(iy)*diag(1./wy)),2));
% dDELTAPQ=2*max(sum(abs(inv(lambdaMat)*...
%     ZDELTA*lambdaMatDELTA*diag(sDELTA)*...
%     diag(1./wDELTA)*diag(1./wDELTA)),2));
% dDELTAI=4*max(sum(abs(inv(lambdaMat)*...
%     ZDELTA*lambdaMatDELTA*diag(iDELTA)*...
%     diag(1./wDELTA)),2));

Rdist=0.01;

Rset=0:Rdist:1;

if ~isempty(min(abs(diag(WY./lambdaMaty)))) && ~isempty(min(abs(diag(WDELTA./2/lambdaMatDELTA))))
%     Rset=0:Rdist:max(min(abs(diag(WY./lambdaMaty))), min(abs(diag(WDELTA./2/lambdaMatDELTA))) ); 
    RyLimit=min(abs(diag(WY./lambdaMaty)));
    RDELTALimit=min(abs(diag(WDELTA./2/lambdaMatDELTA))) ;
elseif ~isempty(min(abs(diag(WY./lambdaMaty)))) && isempty(min(abs(diag(WDELTA./2/lambdaMatDELTA))))
% Rset=0:Rdist:min(abs(diag(WY./lambdaMaty))) ;
RyLimit=min(abs(diag(WY./lambdaMaty)));
RDELTALimit=inf;
else
%     Rset=0:Rdist:min(abs(diag(WDELTA./2/lambdaMatDELTA)));
    RyLimit=inf;
RDELTALimit=min(abs(diag(WDELTA./2/lambdaMatDELTA)));
    
end




f1Cnt=1;
f2Cnt=1;
f3Cnt=1;
f4Cnt=1;
Rpr1=Rset(1); 
Rpr2=Rset(1); 
Rpr3=Rset(1);
Rpr4=Rset(1); 



f1Set=[];
f2Set=[];
f3Set=[];
f4Set=[];


for rCnt=1:length(Rset)

    
    
    R=Rset(rCnt);
  


f1= R-RyLimit;
f2=R-RDELTALimit;



cyPQ=max(sum(abs( inv(lambdaMat)*Zy*SY...
    *inv(WY-R*lambdaMaty)),2));
cyI=max(sum(abs(inv(lambdaMat)*Zy*IY),2));
cDELTAPQ=max(sum(abs(inv(lambdaMat)*ZDELTA...
    *SDELTA*inv(WDELTA-2*R*lambdaMatDELTA)),2));
cDELTAI=max(sum(abs(inv(lambdaMat)*ZDELTA...
    *IDELTA),2));

dyPQ=max(sum(abs( inv(lambdaMat)*Zy*SY*lambdaMaty...
    *inv(WY-R*lambdaMaty)*inv(WY-R*lambdaMaty)),2));
dyI=2*max(sum(abs(inv(lambdaMat)*Zy*IY*lambdaMaty*inv(WY-R*lambdaMaty)),2));
dDELTAPQ=2*max(sum(abs(inv(lambdaMat)*ZDELTA...
    *SDELTA*lambdaMatDELTA*inv(WDELTA-2*R*lambdaMatDELTA)*inv(WDELTA-2*R*lambdaMatDELTA)),2));
dDELTAI=4*max(sum(abs(inv(lambdaMat)*ZDELTA...
    *IDELTA*lambdaMatDELTA*inv(WDELTA-2*R*lambdaMatDELTA)),2));




f3=  cyPQ+ cyI + cDELTAPQ+ cDELTAI - R;
f4= dyPQ + dyI + dDELTAPQ+ dDELTAI - 1 ;

if f1<0 

    f1Set=[f1Set, R];

end

if f2<0 

    f2Set=[f2Set,R];

end

if f3<0 

    f3Set=[f3Set,R];
end
% 
% 
if f4<0 

f4Set=[f4Set,R];
end

end


%% Plotting the conditions





if strcmp(plotOptions,'yes-plot')

x0=2;
y0=2;
width=7;
height=1.5;
figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
hold on;



h1=plot(f1Set(1:2:end), ones(size(f1Set(1:2:end)))...
    -0.04,'b+','lineWidth',2);
hold on
h2=plot(f2Set(1:2:end), ones(size(f2Set(1:2:end)))...
    -0.03,'r^','lineWidth',2);
hold on;
h3=plot(f3Set(1:2:end), ones(size(f3Set(1:2:end)))...
    -0.02,'gs','lineWidth',2);
hold on;
h4=plot(f4Set(1:2:end), ones(size(f4Set(1:2:end)))...
    -0.01,'ko','lineWidth',2);





set(0,'defaulttextinterpreter','latex')
set(gca,'XTick',Rset(1):10*Rdist:R(end));
% set(gca,'YTick',0.97:0.01:1.03);
xlim([-0.1*R(end) R(end)+0.1*R(end)]);
ylim([0.95 1.05]);
set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
set(gca,'fontSize',14); 
grid on; 
xlabel('$R$','FontName','Times New Roman'); 
set(gca,'FontName','Times New Roman');

% ylabel('Acceptable region of $R$'); 
legendTEXT=legend([h1, h2, h3, h4], '(C1)', '(C2)', ...
    '(C3)', '(C4)');
set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontname','Times New Roman');
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','Horizontal'); 
set(legend,'location','North');
set(gca,'box','on');

if exist('Figures')~=7
    mkdir('Figures'); 
end
cd('Figures');
 print('-dpdf', figurename);
 print('-depsc2', figurename);
 cd('..');
end


%% Intersecting the regions to find a validRange for R
validRange=intersect(intersect(intersect(f1Set,...
    f2Set),f3Set),f4Set);


%% Calculating alpha for the valid range of R
alphaVec=zeros(size(validRange));






for rCnt=1:length(validRange)

    
    
R=validRange(rCnt);
  
dyPQ=max(sum(abs( inv(lambdaMat)*Zy*SY*lambdaMaty...
    *inv(WY-R*lambdaMaty)*inv(WY-R*lambdaMaty)),2));
dyI=2*max(sum(abs(inv(lambdaMat)*Zy*IY*lambdaMaty*inv(WY-R*lambdaMaty)),2));
dDELTAPQ=2*max(sum(abs(inv(lambdaMat)*ZDELTA...
    *SDELTA*lambdaMatDELTA*inv(WDELTA-2*R*lambdaMatDELTA)*inv(WDELTA-2*R*lambdaMatDELTA)),2));
dDELTAI=4*max(sum(abs(inv(lambdaMat)*ZDELTA...
    *IDELTA*lambdaMatDELTA*inv(WDELTA-2*R*lambdaMatDELTA)),2));

alphaVec(rCnt)= dyPQ + dyI + dDELTAPQ+ dDELTAI  ;



end







if N==125

lambdavec=[diag(lambdaMat);v0]; 
lambaVec3phase=zeros(3*(N+1),1);

lambaVec3phase(availableIndices,1)=lambdavec;
lambaVec3phase(unavailableIndices,1)=NaN;

lambda3phase=reshape(lambaVec3phase,3,N+1).';




% adding n' of the regulators to the labels:
v3phaseRegs=NaN(4,3);
v3phaseRegs(1,:)=(inv(Av1001)*lambda3phase(allNodesActualLabels==150,:).').'; % three phases
v3phaseRegs(2,1)= (inv(Av1002)*lambda3phase(allNodesActualLabels==9,1).').'; % phase a 
v3phaseRegs(3,[1,3])= (inv(Av1003)*lambda3phase(allNodesActualLabels==25,[1,3]).').'; % phase a and c
v3phaseRegs(4,:)= (inv(Av1004)*lambda3phase(allNodesActualLabels==160,:).').'; % three phase 
lambdaResultsMag=[abs(lambda3phase);abs(v3phaseRegs)];
lambdaResultsPhase=[radian2degrees(angle(lambda3phase)); radian2degrees(angle(v3phaseRegs))];
allNodesActualLabelsWithRegs=[allNodesActualLabels;1001;1002;1003;1004]; % adding n' to the node label list

end



end

