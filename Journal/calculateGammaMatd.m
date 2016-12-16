function GammaMatd=calculateGammaMatd(lambdaMat, Wd, phaseNodesLinIndices, phaseNodes, unavailableIndices, availableIndices)


lambdaMatd=lambdaMat(Wd,Wd); 
lambdaMatVec=diag(lambdaMat); 

Jd=length(Wd); 

GammaMatd=zeros(Jd); 
GammaMatVec=diag(GammaMatd); 


for i=1:Jd
    
    [deltaNodeSet,~]= find(phaseNodesLinIndices==availableIndices(Wd(i)) ); 
    
    vectorToBeEvaluated=setdiff(phaseNodesLinIndices(deltaNodeSet,:), unavailableIndices);
    indexOfInterestforGamma=[];
    for jj=1:length(vectorToBeEvaluated)
        indexOfInterestforGamma= [indexOfInterestforGamma; find(availableIndices==vectorToBeEvaluated(jj))];
    end
    
    GammaMatVec(i)=max( abs(lambdaMatVec(indexOfInterestforGamma))); 
    
end

GammaMatd=diag(GammaMatVec); 
end

