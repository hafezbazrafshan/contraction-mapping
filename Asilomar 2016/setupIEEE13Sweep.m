cd('Constructed-Mat-Files/'); 
load('IEEE13SweepNetwork'); 
cd('..');


% to find the children nodes of sNodes(i): rNodes(find(inc_mat(sNodes(i),:)=1)); 
v0=[1 exp(-j*2*pi/3) exp(j*2*pi/3)].';




%%  Building the load data
loadData=spotloadData.data.Sheet1(1:end-1,:);
loadType=spotloadData.textdata.Sheet1(5:end-1,2);
loadIndices=loadData(:,1);
gMat=zeros(N,3);  
DI=zeros(3,3,N);
DV=zeros(3,3,N); 

for i=1:N
    DV(:,:,i)=eye(3); 
    DI(:,:,i)=eye(3);  
end


Dv=[1 -1 0; 0 1 -1; -1 0 1]; 
Di=[1 0 -1; -1 1 0; 0 -1 1];

sLoad_mat=zeros(3,N); 
iLoad_mat=zeros(3,N); 
yLoad_mat=zeros(3,N); 



for i=1:length(loadIndices)
    nIdx=find(allNodesActualLabels==loadData(i,1));
    
    
    % distributed load lumped 50% at the two ends of the line
     if (nIdx==671)
        nomin1=17*66+66*117+17*117;
        p1=nomin1./(117); 
        p2=nomin1./(17);
        p3=nomin1./(66); 
        
        
        nomin2= 10*38+38*68+10*68;
        q1=nomin2./(68);
        q2=nomin2./(10);
        q3=nomin2./(38);
        
         pLoad=(loadData(i, [3 5 7])+0.5*[p1 p2 p3])*1000/Sbase; 
    qLoad=(loadData(i,[4 6 8])+0.5*[q1 q2 q3])*1000/Sbase; 
    sLoad=(pLoad+1j*qLoad).';
    
    
    
    % taking care of distributed load:
    pLoad1=0.5*[17 66 117]*1000/Sbase;
    qLoad1=0.5*[10 38 68]*1000/Sbase;
    sLoad1=(pLoad1+1j*qLoad1).';
        AuxIdx=find(   allNodesActualLabels==632);
 
 
         sLoad_mat(:,AuxIdx)=sLoad1;
            
             
           gMat(AuxIdx,1)=1;
           DV(:,:,AuxIdx)=eye(3); 
           DI(:,:,AuxIdx)=eye(3); 
  
    
 
     else
     pLoad=loadData(i, [3 5 7])*1000/Sbase; 
    qLoad=loadData(i,[4 6 8])*1000/Sbase; 
    sLoad=(pLoad+1j*qLoad).';
     end
     
     
     
     switch loadType{i}
         case 'Y-PQ'
             sLoad_mat(:,nIdx)=sLoad;
            
             
           gMat(nIdx,1)=1;
           DV(:,:,nIdx)=eye(3); 
           DI(:,:,nIdx)=eye(3); 
  
           
          
             
             
         case 'Y-PR'
                 sLoad_mat(:,nIdx)=sLoad;
            
             
           gMat(nIdx,1)=1;
           DV(:,:,nIdx)=eye(3); 
           DI(:,:,nIdx)=eye(3); 
  
             
         case  'Y-I'
             

              iLoad_mat(:,nIdx)=conj(sLoad./v0); 
             gMat(nIdx,2)=1;
             DV(:,:,nIdx)=eye(3); 
             DI(:,:,nIdx)=eye(3); 
             
            
           
            
         case 'Y-Z' 
             
           
               
               yLoad_mat(:,nIdx)=conj(sLoad);
             gMat(nIdx,3)=1;
             DV(:,:,nIdx)=eye(3); 
             DI(:,:,nIdx)=eye(3); 
             
             
             
         case 'D-PQ'
             
             sLoad_mat(:,nIdx)=sLoad;
            
             
           gMat(nIdx,1)=1;
           DV(:,:,nIdx)=Dv; 
           DI(:,:,nIdx)=Di;
           
             
         case 'D-I'
             v0AB=v0(1)-v0(2);
             v0BC=v0(2)-v0(3);
             v0CA=v0(3)-v0(1);
             v0D=[v0AB; v0BC; v0CA];

iLoad_mat(:,nIdx)= conj(sLoad./v0D);
             gMat(nIdx,2)=1;
           DV(:,:,nIdx)=Dv; 
           DI(:,:,nIdx)=Di;
              
             
        case 'D-Z'
            
             yLoad_mat(:,nIdx)=conj(sLoad./sqrt(3));

               
       
          
             gMat(nIdx,3)=1;

           DV(:,:,nIdx)=Dv; 
           DI(:,:,nIdx)=Di;
          
end
end


% adding the shunt capacitors as constant impedance y loads 
capOriginalNodes=capData.data.Sheet1(~isnan(capData.data.Sheet1(:,1)));

for i=1:size(capOriginalNodes,1)
    nIdx=find(allNodesActualLabels==capOriginalNodes(i));
    availablePhases=find(~isnan(capData.data.Sheet1(i,[2,3,4])));
    gMat(nIdx,3)=1;
    DV(:,:,nIdx)=eye(3); 
    DI(:,:,nIdx)=eye(3); 
    yLoad_mat(availablePhases,nIdx)=(capData.data.Sheet1(i,1+availablePhases).'*1j)*1000/Sbase;

end


if exist('Case Studies')~=7
    mkdir Case Studies;
end
cd('Case Studies'); 
save('IEEE13SweepData');
cd('..') ;