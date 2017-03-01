clear all;
clc;

vS=[1;exp(-j*2*pi/3);exp(j*2*pi/3)];
yLa=1/2;
sLa=1/20;
iLa=-1/2;
yt=1/2;
sL=[sLa; sLa;sLa];
iL=[iLa;iLa;iLa];
yL=[yLa;yLa;yLa];
Y=[yt 0 0 ; 0 yt 0;0 0 yt]; 
Y_NS=-[yt,0,0;0,yt,0;0,0,yt]; 

maxIt=21;

vIterations=zeros(3,maxIt); 

Z=inv(Y+diag(yL)); 
w=-Z*Y_NS*vS;

vIterations(:,1)=w;
err1=zeros(maxIt,1);

for it=2:maxIt
    
    
    fv=-conj(sL./vIterations(:,it-1))-abs(vIterations(:,it-1)).*iL;
    err1(it-1)= max(abs(fv-(Y+diag(yL))*vIterations(:,it-1)-Y_NS*vS)); 
    str=[num2str(err1(it-1)), '\n']; 
    fprintf(str);
    vIterations(:,it)=  (Y+diag(yL))\ (fv-Y_NS*vS);
    
    
end
vSol=vIterations(:,end); 
fv=-conj(sL./vSol)-abs(vSol).*iL;
err1(end)=max(abs(fv-(Y+diag(yL))*vSol-Y_NS*vS)); 



%% Second plot
sLa2=1/10;
sL2=[sLa2; sLa2;sLa2];


vIterations2=zeros(3,maxIt); 


vIterations2(:,1)=w;
err2=zeros(maxIt,1);

for it=2:maxIt
    
    
    fv=-conj(sL2./vIterations2(:,it-1))-abs(vIterations2(:,it-1)).*iL;
    err2(it-1)= max(abs(fv-(Y+diag(yL))*vIterations2(:,it-1)-Y_NS*vS)); 
    str=[num2str(err2(it-1)), '\n']; 
    fprintf(str);
    vIterations2(:,it)=  (Y+diag(yL))\ (fv-Y_NS*vS);
    
    
end
vSol2=vIterations2(:,end); 
fv=-conj(sL2./vSol2)-abs(vSol2).*iL;
err2(end)=max(abs(fv-(Y+diag(yL))*vSol2-Y_NS*vS)); 






x0=2;
y0=2;
width=7;
height=5;
twoNodeFigure=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(twoNodeFigure, 'Name', 'twoNodeFigure');
hold on;


h1= plot(0:maxIt-1,log10(err1(1:maxIt)) , 'b-o','lineWidth',2);
hold on
 h2=plot(0:maxIt-1,log10(err2(1:maxIt)),'r--s','lineWidth',2);
 hold on

 


currentAxes=get(twoNodeFigure,'CurrentAxes');
set(0,'defaulttextinterpreter','latex')
set(currentAxes,'XTick',0:2:maxIt-1);
set(currentAxes,'XtickLabels',0:2:maxIt-1);
set(currentAxes,'YTick',[floor(min(min(log10([err1; err2])))):1:ceil(max(max(log10([err1;err2]))))]);
YTickLabelSet=floor(min(min(log10([err1; err2])))):1:ceil(max(max(log10([err1;err2]))));
set(currentAxes,'YTickLabel',[]);
xlim([0 maxIt-1]);
 ylim([floor(min(log10([err1; err2])))-1 ceil(max(log10([err1;err2])))+1]);
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

ylabel('$\| \mathbf{v}[t+1]- \mathbf{v}[t]\|_{\infty}$'); 
yLabel=get(currentAxes,'yLabel');
set(yLabel,'Position',get(yLabel,'Position')-[1.5 0 0]);
legendTEXT=legend([h1, h2], '$s_L=\frac{1}{20}~(\mathrm{pu})$', '$s_L=\frac{1}{10}~(\mathrm{pu})$');
set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontname','Times New Roman');
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','Vertical'); 
set(legend,'location','NorthEast');
set(currentAxes,'box','on');
% 
cd('Figures'); 
print -dpdf twoNodeFigure.pdf
print -depsc2 twoNodeFigure

cd('..'); 