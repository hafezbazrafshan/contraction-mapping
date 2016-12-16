clear all;
cd('Case Studies'); 
load('IEEE123data'); 
cd('..'); 


 vPr=repmat(v0,N,1);   
 availableIndices=find(any(Ytilde,2));
 vPr=vPr(availableIndices(1:end-3));


maxIt=5;
 

err=inf+zeros(maxIt+1,1);


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
 
 
 vsol=vNew;
 
vsol=[vsol;v0];
v=zeros(3*(N+1),1);

v(availableIndices,1)=vsol;
v(unavailableIndices,1)=NaN;

v3phase=reshape(v,3,N+1).';




% adding n' of the regulators to the labels:
v3phaseRegs=NaN(4,3);
v3phaseRegs(1,:)=(inv(Av1001)*v3phase(allNodesActualLabels==150,:).').'; % three phases
v3phaseRegs(2,1)= (inv(Av1002)*v3phase(allNodesActualLabels==9,1).').'; % phase a 
v3phaseRegs(3,[1,3])= (inv(Av1003)*v3phase(allNodesActualLabels==25,[1,3]).').'; % phase a and c
v3phaseRegs(4,:)= (inv(Av1004)*v3phase(allNodesActualLabels==160,:).').'; % three phase 
resultsVmag=[abs(v3phase);abs(v3phaseRegs)];
resultsVPhase=[radian2degrees(angle(v3phase)); radian2degrees(angle(v3phaseRegs))];
allNodesActualLabelsWithRegs=[allNodesActualLabels;1001;1002;1003;1004]; % adding n' to the node label list

if exist('Results')~=7
    mkdir Results;
end
cd('Results'); 
save('IEEE123ZBusResults');
cd('..') ;


