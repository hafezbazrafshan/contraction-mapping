function [ZDELTA,sDELTA,iDELTA,wDELTA]=calculateDELTA(Z, sL_loadDelta,iL_loadDelta, Jd, phaseNodesLinIndices, phaseNodes, unavailableIndices, availableIndices,w)

JdLength=length(Jd); 

J=size(Z,1); % number of rows of Z
ZDELTA=zeros(J,length(Jd));
sDELTA=zeros(length(Jd),1);
iDELTA=zeros(length(Jd),1);
wDELTA=zeros(length(Jd),1);
for i=1:JdLength
    
    [deltaNode,deltaPhase]= find(phaseNodesLinIndices==availableIndices(Jd(i)) );  % finds which node Jd(i) belongs to, i.e., equivalent to operation NODE[availableIndices(Jd(i)) )] and also finds the phase
    phaseSet=phaseNodes(deltaNode,:);
    vectorToBeEvaluated=setdiff(phaseNodesLinIndices(deltaNode,:), unavailableIndices);
    indexOfInterestforZDELTA=[];
      for jj=1:length(vectorToBeEvaluated)
        indexOfInterestforZDELTA= [indexOfInterestforZDELTA; find(availableIndices==vectorToBeEvaluated(jj))]; 
        % finds which indices in the set J correspond to the current phases of interest in this particular delta connection
      end
    
    if isequal(phaseSet,[1,2,3])
          sDELTA(i)=sL_loadDelta(i,1);
        iDELTA(i)=iL_loadDelta(i,1);
        if deltaPhase==1
        ZDELTA(:,i)= Z(:,indexOfInterestforZDELTA(1))- Z(:,indexOfInterestforZDELTA(2));
        wDELTA(i)=w(indexOfInterestforZDELTA(1))-w(indexOfInterestforZDELTA(2));
        elseif deltaPhase==2
        ZDELTA(:,i)= Z(:,indexOfInterestforZDELTA(2))- Z(:,indexOfInterestforZDELTA(3));  
         wDELTA(i)=w(indexOfInterestforZDELTA(2))-w(indexOfInterestforZDELTA(3));

        elseif deltaPhase==3
        ZDELTA(:,i)= Z(:,indexOfInterestforZDELTA(3))- Z(:,indexOfInterestforZDELTA(1));  
        wDELTA(i)=w(indexOfInterestforZDELTA(3))-w(indexOfInterestforZDELTA(1));

        end

    
    elseif isequal(phaseSet([2,3]),[2,3])
        
        if deltaPhase==2
            ZDELTA(:,i)=Z(:,indexOfInterestforZDELTA(1))- Z(:,indexOfInterestforZDELTA(2));  
            sDELTA(i)=sL_loadDelta(i,1);
            iDELTA(i)=iL_loadDelta(i,1);
             wDELTA(i)=w(indexOfInterestforZDELTA(1))-w(indexOfInterestforZDELTA(2));

        elseif deltaPhase==3
            ZDELTA(:,i)=0;
              sDELTA(i)=0;
            iDELTA(i)=0;
           wDELTA(i)=w(indexOfInterestforZDELTA(2))-w(indexOfInterestforZDELTA(1));

        end
        
    elseif isequal(phaseSet([1,3]),[1,3])
        
        if deltaPhase==1
            ZDELTA(:,i)=0;
              sDELTA(i)=0;
            iDELTA(i)=0;
            wDELTA(i)=w(indexOfInterestforZDELTA(1))-w(indexOfInterestforZDELTA(2));

        elseif deltaPhase==3
              ZDELTA(:,i)=Z(:,indexOfInterestforZDELTA(2))- Z(:,indexOfInterestforZDELTA(1));  
               sDELTA(i)=sL_loadDelta(i,1);
            iDELTA(i)=iL_loadDelta(i,1);
             wDELTA(i)=w(indexOfInterestforZDELTA(2))-w(indexOfInterestforZDELTA(1));
        end
        
    elseif isequal(phaseSet([1,2]),[1,2])
        
        if deltaPhase==1
              ZDELTA(:,i)=Z(:,indexOfInterestforZDELTA(1))- Z(:,indexOfInterestforZDELTA(2));  
               sDELTA(i)=sL_loadDelta(i,1);
            iDELTA(i)=iL_loadDelta(i,1);
            wDELTA(i)=w(indexOfInterestforZDELTA(1))-w(indexOfInterestforZDELTA(2));

        elseif deltaPhase==3
             ZDELTA(:,i)=0;
                sDELTA(i)=0;
            iDELTA(i)=0;
            wDELTA(i)=w(indexOfInterestforZDELTA(2))-w(indexOfInterestforZDELTA(1));
        end
    end
    
    


end

