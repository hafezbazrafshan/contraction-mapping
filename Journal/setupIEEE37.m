%% 1. Importing the mat file for IEEE37 network
cd('Constructed-Mat-Files/'); 
load('IEEE37Network'); 
cd('..');

%% 2. Some preliminary work
Indices=1:3*(N+1);
phaseNodesLinIndices=reshape(Indices, 3,N+1).';  % this matrix gives the linear indices. For example, 
% if you want to know the index for node 3 and phase a,  you should type
% phaseNodesLinIndices(3,1).

Ynet=Ytilde(any(Ytilde,2),any(Ytilde,2));
YbusS=Ynet;
Y=Ynet(1:end-3,1:end-3);
Y_NS=Ynet(1:end-3,end-2:end);
Y_SS=Ynet(end-2:end,end-2:end);
Ybus=Y;  % the rank deficient admittance matrix



availableIndices=find(any(Ytilde,2));  % picks the set of available phases at all nodes
unavailableIndices=find(~any(Ytilde,2)); % determines which phases are non-existent
phaseNodesLin(unavailableIndices)=NaN; % Makes sure non-existent phases are labeled as NaN
phaseNodes=reshape(phaseNodesLin,3,N+1).'; % gives the phases per node as a (N+1)*3 matrix with potential NaNs;

%% 3. Setting up the ZIP loads
v0=[1  1*exp(-j*(2*pi/3))  1*exp(j*(2*pi/3))].';
sL=zeros(N*3,2);
yL=zeros(N*3,2);
iL=zeros(N*3,2);




loadData=spotloadData.data.Sheet1(1:end-1,:);
loadType=spotloadData.textdata.Sheet1(5:end-1,2);

loadIndices=loadData(:,1);




cMat=zeros(3*N,2);
ePage=zeros(3*N,3*N,2);
gMat=zeros(3*N,3);  % defines the load type  gVec(1) PQ, gVec(2) I , gVec(3) Y

for i=1:length(loadIndices)
 
    nIdx=find(allNodesActualLabels==loadData(i,1));
    
    linIdx1=phaseNodesLinIndices(nIdx,1);
    linIdx2=phaseNodesLinIndices(nIdx,2);
    linIdx3=phaseNodesLinIndices(nIdx,3);
    
     pLoad=loadData(i, [3 5 7])*1000/Sbase; 
    qLoad=loadData(i,[4 6 8])*1000/Sbase; 
    sLoad=(pLoad+1j*qLoad).';
        
    
    
     switch loadType{i}
         
         
         case 'Y-PQ'
             sL([linIdx1,linIdx2,linIdx3],1)=sLoad;
             
             
             
            gMat(linIdx1,1)=1;
            gMat(linIdx2,1)=1;
            gMat(linIdx3,1)=1;
             
             
           cMat(linIdx1,1)=1;
           ePage(linIdx1, linIdx1,1)=1;
           
           
           
           cMat(linIdx2,1)=1;
           ePage(linIdx2,linIdx2,1)=1;
           
           cMat(linIdx3,1)=1;
           ePage(linIdx3,linIdx3,1)=1;
             
             
         case 'Y-PR'
               sL([linIdx1,linIdx2,linIdx3],1)=sLoad;
             
             
             
              gMat(linIdx1,1)=1;
            gMat(linIdx2,1)=1;
            gMat(linIdx3,1)=1;
             
             
            cMat(linIdx1,1)=1;
           ePage(linIdx1,linIdx1,1)=1;
           
           
           
           cMat(linIdx2,1)=1;
           ePage(linIdx2,linIdx2,1)=1;
           
           cMat(linIdx3,1)=1;
           ePage(linIdx3,linIdx3,1)=1;
             
         case  'Y-I'
             
              iL([linIdx1,linIdx2,linIdx3],1)=conj(sLoad./v0);
             
             
              gMat(linIdx1,2)=1;
            gMat(linIdx2,2)=1;
            gMat(linIdx3,2)=1;
             
            cMat(linIdx1,1)=1;
           ePage(linIdx1,linIdx1,1)=1;
           
           
           
           cMat(linIdx2,1)=1;
           ePage(linIdx2,linIdx2,1)=1;
           
           cMat(linIdx3,1)=1;
           ePage(linIdx3,linIdx3,1)=1;
            
         case 'Y-Z' 
             
               yL([linIdx1,linIdx2,linIdx3],1)=conj(sLoad);
               
             
              gMat(linIdx1,3)=1;
            gMat(linIdx2,3)=1;
            gMat(linIdx3,3)=1;
             
             
            cMat(linIdx1,1)=1;
           ePage(linIdx1,linIdx1,1)=1;
           
           
           
           cMat(linIdx2,1)=1;
           ePage(linIdx2,linIdx2,1)=1;
           
           cMat(linIdx3,1)=1;
           ePage(linIdx3,linIdx3,1)=1;
             
             
         case 'D-PQ'
             
               sL([linIdx1,linIdx2,linIdx3],1)=sLoad;
               sL(linIdx1,2)=sLoad(3);
               sL(linIdx2,2)=sLoad(1);
               sL(linIdx3,2)=sLoad(2);
             
              gMat(linIdx1,1)=1;
            gMat(linIdx2,1)=1;
            gMat(linIdx3,1)=1;
             
             
            cMat(linIdx1,1)=1;
            cMat(linIdx1,2)=-1;
            
           ePage(linIdx1,linIdx1,1)=1;
           ePage(linIdx1,linIdx2,1)=-1;
           ePage(linIdx1,linIdx3,2)=1;
           ePage(linIdx1,linIdx1,2)=-1;
           
           
           cMat(linIdx2,1)=1;
           cMat(linIdx2,2)=-1;
           ePage(linIdx2,linIdx2,1)=1;
           ePage(linIdx2,linIdx3,1)=-1;
           ePage(linIdx2,linIdx1,2)=1;  
           ePage(linIdx2,linIdx2,2)=-1;
           
           
           
           cMat(linIdx3,1)=1;
           cMat(linIdx3,2)=-1;
           ePage(linIdx3,linIdx3,1)=1;
           ePage(linIdx3,linIdx1,1)=-1;
           ePage(linIdx3,linIdx2,2)=1;
           ePage(linIdx3,linIdx3,2)=-1;
           
           
             
         case 'D-I'
             v0AB=v0(1)-v0(2);
             v0BC=v0(2)-v0(3);
             v0CA=v0(3)-v0(1);
             v0D=[v0AB; v0BC; v0CA];
              iL([linIdx1,linIdx2,linIdx3],1)=conj(sLoad./v0D);
             
              iL(linIdx1,2)=conj(sLoad(3)./v0D(3));
               iL(linIdx2,2)=conj(sLoad(1)./v0D(1));
               iL(linIdx3,2)=conj(sLoad(2)./v0D(2));
             
             
              gMat(linIdx1,2)=1;
            gMat(linIdx2,2)=1;
            gMat(linIdx3,2)=1;
             
             cMat(linIdx1,1)=1;
            cMat(linIdx1,2)=-1;
            
           ePage(linIdx1,linIdx1,1)=1;
           ePage(linIdx1,linIdx2,1)=-1;
           ePage(linIdx1,linIdx3,2)=1;
           ePage(linIdx1,linIdx1,2)=-1;
           
           
           cMat(linIdx2,1)=1;
           cMat(linIdx2,2)=-1;
           ePage(linIdx2,linIdx2,1)=1;
           ePage(linIdx2,linIdx3,1)=-1;
           ePage(linIdx2,linIdx1,2)=1;
           ePage(linIdx2,linIdx2,2)=-1;
           
           
           
           cMat(linIdx3,1)=1;
           cMat(linIdx3,2)=-1;
           ePage(linIdx3,linIdx3,1)=1;
           ePage(linIdx3,linIdx1,1)=-1;
           ePage(linIdx3,linIdx2,2)=1;
           ePage(linIdx3,linIdx3,2)=-1;
              
             
        case 'D-Z'
            
             yL([linIdx1,linIdx2,linIdx3],1)=conj(sLoad./sqrt(3));

               yL(linIdx1,2)=conj(sLoad(3)./sqrt(3));
               yL(linIdx2,2)=conj(sLoad(1)./sqrt(3));
               yL(linIdx3,2)=conj(sLoad(2)./sqrt(3));

            
             gMat(linIdx1,3)=1;
            gMat(linIdx2,3)=1;
            gMat(linIdx3,3)=1;
            
              cMat(linIdx1,1)=1;
            cMat(linIdx1,2)=-1;
            
           ePage(linIdx1,linIdx1,1)=1;
           ePage(linIdx1,linIdx2,1)=-1;
           ePage(linIdx1,linIdx3,2)=1;
           ePage(linIdx1,linIdx1,2)=-1;
           
           
           cMat(linIdx2,1)=1;
           cMat(linIdx2,2)=-1;
           ePage(linIdx2,linIdx2,1)=1;
           ePage(linIdx2,linIdx3,1)=-1;
           ePage(linIdx2,linIdx1,2)=1;
           ePage(linIdx2,linIdx2,2)=-1;
           
           
           
           cMat(linIdx3,1)=1;
           cMat(linIdx3,2)=-1;
           ePage(linIdx3,linIdx3,1)=1;
           ePage(linIdx3,linIdx1,1)=-1;
           ePage(linIdx3,linIdx2,2)=1;
           ePage(linIdx3,linIdx3,2)=-1;
          
end
end

%% 4. Removing the missing phases
sL_load=sL(availableIndices(1:end-3),:);
iL_load=iL(availableIndices(1:end-3),:);
yL_load=yL(availableIndices(1:end-3),:);
ePage=ePage(availableIndices(1:end-3), availableIndices(1:end-3), :);
gMat=gMat(availableIndices(1:end-3), :); 
cMat=cMat(availableIndices(1:end-3),:);


%% 5. Creating Y_L, Y+Y_L, Z, and w
yImpedance=getYLoadImpedance(cMat, ePage, yL_load);
Ycheck=Y+yImpedance;  % (Y+YL) in the text
Z=inv(Ycheck); 
w= -Z*Y_NS*v0; 

%% 7. Saving the IEEE37data for usage
if exist('Case Studies')~=7
    mkdir 'Case Studies'
end
cd('Case Studies'); 
save('IEEE37data');
cd('..'); 
