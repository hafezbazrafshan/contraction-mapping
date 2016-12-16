clear all;
clc;
close all;
cd('Case Studies');
IEEE13=load('IEEE13SinglePhaseData.mat'); 
IEEE37=load('IEEE37SinglePhaseData.mat'); 
IEEE123=load('IEEE123SinglePhaseData.mat'); 
cd('..');

[ validRangeIEEE13, alphaTheoryVecIEEE13,...
    AIEEE13,BIEEE13,CIEEE13,DIEEE13 ] = calculateRegions( IEEE13,eye(size(diag(IEEE13.w))),'yes-plot', 'IEEE13' ); 

[ validRangeIEEE37, alphaTheoryVecIEEE37,...
    AIEEE37,BIEEE37,CIEEE37,DIEEE37] = calculateRegions( IEEE37,eye(size(diag(IEEE37.w))), 'yes-plot', 'IEEE37'); 

[ validRangeIEEE123, alphaTheoryVecIEEE123,...
     AIEEE123,BIEEE123,CIEEE123,DIEEE123] = calculateRegions( IEEE123,eye(size(diag(IEEE123.w))), 'yes-plot','IEEE123'); 


