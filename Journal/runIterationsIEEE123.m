clear all;
clc;
close all;
cd('Case Studies\'); 
IEEE123=load('IEEE123data'); 
cd('..'); 
[ validRangeIEEE123, alphaTheoryVecIEEE123 ] = calculateRegions( IEEE123);

Rmin=validRangeIEEE123(1); 
Rmax=validRangeIEEE123(end);
maxIt=5;
lambdaMat=diag(IEEE123.w);
% Initialization 1
 vPr=repmat(IEEE123.v0,IEEE123.N,1);   
 availableIndices=find(any(IEEE123.Ytilde,2));
 vPr1=vPr(availableIndices(1:end-3));
 [ alphaMax1, alphaNumeric1, success1, vNew1, vIterations1, err1 ] = ZBUSV(IEEE123, vPr1);
 
 
 %Initialization 2
[ alphaMax2,alphaNumeric2, success2, vNew2, vIterations2, err2 ] = ZBUSV(IEEE123, IEEE123.w);


 %Initialization 3
vPr3=IEEE123.w-validRangeIEEE123(1)*IEEE123.w;
[ alphaMax3, alphaNumeric3,success3, vNew3, vIterations3, err3 ] = ZBUSV(IEEE123,vPr3);
 
 
  %Initialization 3
vPr3=IEEE123.w-validRangeIEEE123(end)*IEEE123.w;
[ alphaMax4, alphaNumeric4, success4, vNew4, vIterations4, err4 ] = ZBUSV(IEEE123,vPr3);

w=IEEE123.w;
% plot(err1);
% hold on
% plot(err2,'r');

x0=2;
y0=2;
width=7;
height=5;
selfmappingFigure=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(selfmappingFigure, 'Name', 'Self-mapping');
hold on;


h1= plot(0:maxIt-1,max(abs(inv(lambdaMat)*(vIterations1(:,1:maxIt) - repmat(w,1,maxIt)))) , 'b-o','lineWidth',2);
hold on
 h2=plot(0:maxIt-1,max(abs(inv(lambdaMat)*(vIterations2(:,1:maxIt) - repmat(w,1,maxIt)))),'r--s','lineWidth',2);
 hold on
 h3=plot(0:maxIt-1, max(abs(inv(lambdaMat)*(vIterations3(:,1:maxIt)-repmat(w,1,maxIt)))), 'g-^','lineWidth',2); 
 hold on
 h4=plot(0:maxIt-1, max(abs(inv(lambdaMat)*(vIterations4(:,1:maxIt)-repmat(w,1,maxIt)))), 'm-v','lineWidth',2); 
 hold on;
 h5=plot(0:maxIt-1, repmat(Rmin,1,maxIt),'k-.','lineWidth',3); 
 hold on;
 h6=plot(0:maxIt-1,repmat(Rmax,1,maxIt),'k--','lineWidth',3);
 
set(0,'defaulttextinterpreter','latex')
set(gca,'XTick',0:maxIt-1);
set(gca,'YTick',0:0.1:Rmax);
xlim([0 maxIt-1]);
ylim([-0.1 Rmax+0.1]);
% set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
set(gca,'fontSize',14); 
grid on; 
set(gca, 'box','on'); 
xlabel('Iteration $t$','FontName','Times New Roman'); 
set(gca,'FontName','Times New Roman');

ylabel('$\| \mathbf{\Lambda}^{-1} ( \mathbf{v}[t] - \mathbf{w}) \|_{\infty}$'); 
legendTEXT=legend([h1, h2, h3, h4, h5,h6], '$\mathbf{v}_n[0]=\mathbf{v}_{\mathrm{S}}$', '$\mathbf{v}_n[0]=\mathbf{w}_n$',  '$\mathbf{v}_n[0]=\mathbf{w}_n-R_{\min}\mathbf{w}_n$', '$\mathbf{v}_n[0]=\mathbf{w}_n-R_{\max} \mathbf{w}_n$', '$R_{\min}$', '$R_{\max}$');
set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontname','Times New Roman');
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','Vertical'); 
set(legend,'location','NorthEast');
set(gca,'box','on');
% 
if exist('Figures')~=7
    mkdir Figures 
end
cd('Figures'); 
print -dpdf IEEE123SelfMapping.pdf
print -depsc2 IEEE123SelfMapping
cd('..'); 













x0=2;
y0=2;
width=7;
height=5;
IEEE123alphaFigure=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(IEEE123alphaFigure, 'Name', 'Iterations');
hold on;


h1= plot(0:maxIt-1,log10(err1(1:maxIt)) , 'b-o','lineWidth',2);
hold on
 h2=plot(0:maxIt-1,log10(err2(1:maxIt)),'r--s','lineWidth',2);
 hold on
 h3=plot(0:maxIt-1, log10(err3(1:maxIt)), 'g-^','lineWidth',2); 
 hold on
 h4=plot(0:maxIt-1, log10(err4(1:maxIt)), 'm-v','lineWidth',2); 
 hold on;
% 
% h1= semilogy(0:maxIt,err1 , 'b-o','lineWidth',2);
% hold on
%  h2=semilogy(0:maxIt,err2,'r--s','lineWidth',2);
%  hold on
%  h3=semilogy(0:maxIt, err3, 'g-^','lineWidth',2); 
%  hold on
%  h4=semilogy(0:maxIt, err4, 'm-v','lineWidth',2); 
%  hold on;

currentAxes=get(IEEE123alphaFigure,'CurrentAxes');
set(0,'defaulttextinterpreter','latex')
set(currentAxes,'XTick',0:maxIt-1);
set(currentAxes,'XtickLabels',0:maxIt-1);
set(currentAxes,'YTick',[floor(min(min(log10([err1; err2; err3; err4])))):2:ceil(max(max(log10([err1;err2;err3;err4]))))]);
YTickLabelSet=floor(min(min(log10([err1; err2; err3; err4])))):2:ceil(max(max(log10([err1;err2;err3;err4]))));
% set(currentAxes,'YTickLabel', 10.^(floor(min(log10([err1; err2; err3; err4]))):2:ceil(max(log10([err1;err2;err3;err4])))));
% set(currentAxes, 'YTickLabel','10^{2}');
set(currentAxes,'YTickLabel',[]);
xlim([0 maxIt-1]);
 ylim([floor(min(log10([err1; err2; err3; err4])))-1 ceil(max(log10([err1;err2;err3;err4])))+1]);
HorizontalOffset = 0.05;
ax=axis;
yTicks=get(currentAxes,'YTick');
for i = 1:length(YTickLabelSet)
%Create text box and set appropriate properties
     text(ax(1) - HorizontalOffset,yTicks(i),['$\mathbf{10^{' num2str( YTickLabelSet(i)) '}}$'],...
         'HorizontalAlignment','Right','interpreter', 'latex','fontSize',14,'fontName','Times New Roman');   
end
set(currentAxes,'fontSize',14); 
grid on; 
set(currentAxes, 'box','on'); 
xlabel('Iteration $t$','FontName','Times New Roman'); 
set(currentAxes,'FontName','Times New Roman');

ylabel('$\| \mathbf{v}[t+1] - \mathbf{v}[t]\|_{\infty}$'); 
yLabel=get(currentAxes,'yLabel');
set(yLabel,'Position',get(yLabel,'Position')-[0.3 0 0]);
legendTEXT=legend([h1, h2, h3, h4], '$\mathbf{v}_n[0]=\mathbf{v}_{\mathrm{S}}$', '$\mathbf{v}_n[0]=\mathbf{w}_n$',  '$\mathbf{v}_n[0]=\mathbf{w}_n-R_{\min}\mathbf{w}_n$', '$\mathbf{v}_n[0]=\mathbf{w}_n-R_{\max} \mathbf{w}_n$');
set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontname','Times New Roman');
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','Vertical'); 
set(legend,'location','NorthEast');
set(currentAxes,'box','on');
% 
cd('Figures'); 
print -dpdf IEEE123Error.pdf
print -depsc2 IEEE123Error

cd('..'); 




alphaNumeric=[alphaNumeric1; alphaNumeric2;alphaNumeric3;alphaNumeric4];



x0=2;
y0=2;
width=7;
height=5;
IEEE123alphaFigure=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(IEEE123alphaFigure, 'Name', 'Self-mapping');
hold on;


h1= plot(1:maxIt-1,alphaNumeric1 , 'b-o','lineWidth',2);
hold on
 h2=plot(1:maxIt-1,alphaNumeric2,'r--s','lineWidth',2);
 hold on
 h3=plot(1:maxIt-1, alphaNumeric3, 'g-^','lineWidth',2); 
 hold on
 h4=plot(1:maxIt-1, alphaNumeric4, 'm-v','lineWidth',2); 
 hold on;
% 
% h1= semilogy(0:maxIt,err1 , 'b-o','lineWidth',2);
% hold on
%  h2=semilogy(0:maxIt,err2,'r--s','lineWidth',2);
%  hold on
%  h3=semilogy(0:maxIt, err3, 'g-^','lineWidth',2); 
%  hold on
%  h4=semilogy(0:maxIt, err4, 'm-v','lineWidth',2); 
%  hold on;

currentAxes=get(IEEE123alphaFigure,'CurrentAxes');
set(0,'defaulttextinterpreter','latex')
set(currentAxes,'XTick',1:maxIt-1);
set(currentAxes,'XtickLabels',1:maxIt-1);
set(currentAxes,'YTick',[0.04:0.02: 0.12]);
xlim([0 maxIt]);
 ylim([0.04 0.12]);

set(currentAxes,'fontSize',14); 
grid on; 
set(currentAxes, 'box','on'); 
xlabel('Iteration $t$','FontName','Times New Roman'); 
set(currentAxes,'FontName','Times New Roman');
ylabel('$\frac{\| \mathbf{\Lambda}^{-1}(\mathbf{v}[t+1] - \mathbf{v}[t])\|_{\infty}}{\| \mathbf{\Lambda}^{-1}(\mathbf{v}[t] - \mathbf{v}[t-1])\|_{\infty}} $'); 
legendTEXT=legend([h1, h2, h3, h4], '$\mathbf{v}_n[0]=\mathbf{v}_{\mathrm{S}}$', '$\mathbf{v}_n[0]=\mathbf{w}_n$',  '$\mathbf{v}_n[0]=\mathbf{w}_n-R_{\min}\mathbf{w}_n$', '$\mathbf{v}_n[0]=\mathbf{w}_n-R_{\max} \mathbf{w}_n$');
set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontname','Times New Roman');
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','Vertical'); 
set(legend,'location','NorthEast');
set(currentAxes,'box','on');
% 
if exist('Figures')~=7
    mkdir Figures 
end
cd('Figures') ;
print -dpdf IEEE123alpha.pdf
print -depsc2 IEEE123alpha

cd('..'); 

