clear all;
clc;
close all;
cd('Case Studies');
IEEE13=load('IEEE13data'); 
IEEE37=load('IEEE37data'); 
IEEE123=load('IEEE123data'); 
cd('..');

[ validRangeIEEE13, alphaTheoryVecIEEE13,...
    lambdaMatyIEEE13, lambdaMatDELTAIEEE13,wyIEEE13,wDELTAIEEE13, ...
    cyPQIEEE13, cyIIEEE13, cDELTAPQIEEE13,...
    cDELTAIIEEE13, dyPQIEEE13, dyIIEEE13,...
    dDELTAPQIEEE13, dDELTAIIEEE13 ] = calculateRegions( IEEE13,diag(IEEE13.w),'yes-plot', 'IEEE13' ); 

[ validRangeIEEE37, alphaTheoryVecIEEE37,...
    lambdaMatyIEEE37, lambdaMatDELTAIEEE37,wyIEEE37,wDELTAIEEE37, ...
    cyPQIEEE37, cyIIEEE37, cDELTAPQIEEE37,...
    cDELTAIIEEE37, dyPQIEEE37, dyIIEEE37,...
    dDELTAPQIEEE37, dDELTAIIEEE37] = calculateRegions( IEEE37,diag(IEEE37.w), 'yes-plot', 'IEEE37'); 

[ validRangeIEEE123, alphaTheoryVecIEEE123,...
     lambdaMatyIEEE123, lambdaMatDELTAIEEE123,wyIEEE123,wDELTAIEEE123,...
    cyPQIEEE123, cyIIEEE123, cDELTAPQIEEE123,...
    cDELTAIIEEE123, dyPQIEEE123, dyIIEEE123,...
    dDELTAPQIEEE123, dDELTAIIEEE123 ] = calculateRegions( IEEE123,diag(IEEE123.w), 'yes-plot','IEEE123'); 

