% Loads SWEEPdata and performs the FB-Sweep algorithm
% Saves the results in SWEEPresults
clear all;
clc;
cd('Case Studies'); 
load('IEEE13SweepData'); 
cd('..'); 

v_mat=zeros(3,N+1); 
iL_mat=zeros(3,N);   %   load currents not considering the substation
iB_mat_in=zeros(3,N);  % branch currents going into a node used in backsweep
iB_mat_out=zeros(3,N); % branch currents going out of the ancestor node going into a node used in forward sweep
% for each node you have three currents:
% currents from the load
% currents going in to the node at the node
% currents going in to the node from the sending node
tol=+inf;
v_mat(:,N+1)= v0;
vPr=zeros(3,N+1);



sweep_path=gen_path(14,inc_mat, sNodes,rNodes);  % generate a sweep path from the substation
cnt=0; 


while tol >0.0001
   
    %forward sweep 
    
for i=1:N
    receiverNode= sweep_path(i+1);
    branchIdx=find(rNodes==receiverNode); 
    ancestorNode=  sNodes(branchIdx);
    
    A=A_mat(:,:,branchIdx); 
    B=B_mat(:,:,branchIdx); 
    v_mat(:,receiverNode)=A*v_mat(:,ancestorNode)- B * iB_mat_out(:,receiverNode); 
    
    
end


% backward sweep

for i=1:N
    receiverNode=sweep_path(N-i+2);
    branchIdx=find(rNodes==receiverNode); 
    
    C=C_mat(:,:,branchIdx); 
    D=D_mat(:,:,branchIdx);
    
    childrenIdx=rNodes(inc_mat(receiverNode,:)==1);
    
    sumChildrenCurrents= zeros(3,1); 
    
    if ~isempty(childrenIdx)
        sumChildrenCurrents=sum(iB_mat_out(:,childrenIdx),2);
    end
    

    
    iB_mat_in(:,receiverNode)= sumChildrenCurrents+...
        getILoad(v_mat(:,receiverNode),...
        sLoad_mat(:,receiverNode),...
        iLoad_mat(:, receiverNode), ...
        yLoad_mat(:,receiverNode), ...
        gMat(receiverNode, :), ...
        DV(:,:,receiverNode), ...
        DI(:,:,receiverNode)); 


    
    
  
    iB_mat_out(:,receiverNode)=C*v_mat(:,receiverNode)+ D*iB_mat_in(:,receiverNode);
    
    
    
end


tol=sum(sum(abs(vPr-v_mat)));

vPr=v_mat;
cnt=cnt+1; % monitors the iterations
 str=['Iteration No. ', num2str(cnt-1),' Error is ', num2str(tol), '\n'];
 fprintf(str);

end
 
 fprintf('Convergence \n');

v3phase=v_mat.';
v3phase(v3phase==0)=NaN;






labelsNoRegs=allNodesActualLabels(allNodesActualLabels~=1001);
labelsNoRegs=[labelsNoRegs(labelsNoRegs~=650);650];


v3phaseRegs=v3phase(allNodesActualLabels==1001,:);
v3phaseNet=v3phase(allNodesActualLabels~=1001 ,:);
v3phaseNet=[v3phaseNet(1:end-1,:); v3phaseNet(end,:)];

resultsVmag=[abs(v3phaseNet);abs(v3phaseRegs)];
resultsVPhase=[radian2degrees(angle(v3phaseNet)); radian2degrees(angle(v3phaseRegs))];

allNodesActualLabelsWithRegs=[labelsNoRegs;1001];

if exist('Results')~=7
    mkdir Results;
end
cd('Results'); 
save('IEEE13SweepResults');
cd('..') ;



