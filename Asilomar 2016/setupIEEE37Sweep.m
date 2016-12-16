cd('Constructed-Mat-Files/'); 
load('IEEE37SweepNetwork'); 
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
     pLoad=loadData(i, [3 5 7])*1000/Sbase; 
    qLoad=loadData(i,[4 6 8])*1000/Sbase; 
    sLoad=(pLoad+1j*qLoad).';
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





if exist('Case Studies')~=7
    mkdir Case Studies;
end
cd('Case Studies'); 
save('IEEE37SweepData');
cd('..') ;