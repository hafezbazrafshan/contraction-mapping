clear all;
clc;

vS=[1;exp(-j*2*pi/3);exp(j*2*pi/3)];
yLa=1/2;
sLa=-1/2;
iLa=1/2;
yt=1/2;
sL=[sLa; sLa;sLa];
iL=[iLa;iLa;iLa];
yL=[yLa;yLa;yLa];
Y=[yt 0 0 ; 0 yt 0;0 0 yt]; 
Y_NS=-[yt,0,0;0,yt,0;0,0,yt]; 

maxIt=11;

vIterations=zeros(3,maxIt); 

Z=inv(Y+diag(yL)); 
w=-Z*Y_NS*vS;

vIterations(:,1)=vS;
err1=zeros(maxIt,1);
dist1=zeros(maxIt,1); 
vsol=0;

for it=2:maxIt
    
    
    fv=-conj(sL./vIterations(:,it-1))-(vIterations(:,it-1)./abs(vIterations(:,it-1))).*iL;
    err1(it-1)= max(abs(fv-(Y+diag(yL))*vIterations(:,it-1)-Y_NS*vS)); 
    dist1(it-1)= max(abs(vIterations(:,it-1)-vsol)); 
    str=[num2str(err1(it-1)), '\n']; 
    fprintf(str);
    vIterations(:,it)=  (Y+diag(yL))\ (fv-Y_NS*vS);
    
    
end
vSol=vIterations(:,end); 
fv=-conj(sL./vSol)-(vSol./abs(vSol)).*iL;
err1(end)=max(abs(fv-(Y+diag(yL))*vSol-Y_NS*vS)); 
dist1(end)=max(abs(vSol-vsol)); 


%% Second plot

sLa2=sLa;
sL2=[sLa2; sLa2;sLa2];
vIterations2=zeros(3,maxIt); 


vIterations2(:,1)=2*sqrt(-sLa)*vS;
err2=zeros(maxIt,1);
dist2=zeros(maxIt,1); 

for it=2:maxIt
    
    
    fv=-conj(sL./vIterations2(:,it-1))-(vIterations2(:,it-1)./abs(vIterations2(:,it-1))).*iL;
    err2(it-1)= max(abs(fv-(Y+diag(yL))*vIterations2(:,it-1)-Y_NS*vS)); 
    dist2(it-1)= max(abs(vIterations2(:,it-1)-vsol)); 
    str=[num2str(err2(it-1)), '\n']; 
    fprintf(str);
    vIterations2(:,it)=  (Y+diag(yL))\ (fv-Y_NS*vS);
    
    
end
vSol2=vIterations2(:,end); 
fv=-conj(sL./vSol2)-(vSol2./abs(vSol2)).*iL;
err2(end)=max(abs(fv-(Y+diag(yL))*vSol2-Y_NS*vS)); 
dist2(end)=max(abs(vSol2-vsol)); 

%% Third plot
sLa3=sLa;
sL3=[sLa3; sLa3;sLa3];

vIterations3=zeros(3,maxIt); 

vIterations3(:,1)=0.5*sqrt(-sLa)*vS;
err3=zeros(maxIt,1);
dist3=zeros(maxIt,1); 

for it=2:maxIt
    
    
    fv=-conj(sL./vIterations3(:,it-1))-(vIterations3(:,it-1)./abs(vIterations3(:,it-1))).*iL;
    err3(it-1)= max(abs(fv-(Y+diag(yL))*vIterations3(:,it-1)-Y_NS*vS)); 
   dist3(it-1)= max(abs(vIterations3(:,it-1)-vsol)); 
    str=[num2str(err3(it-1)), '\n']; 
    fprintf(str);
    vIterations3(:,it)=  (Y+diag(yL))\ (fv-Y_NS*vS);
    
    
end
vSol3=vIterations3(:,end); 
fv=-conj(sL./vSol3)-(vSol3./abs(vSol3)).*iL;
err3(end)=max(abs(fv-(Y+diag(yL))*vSol3-Y_NS*vS)); 
dist3(end)=max(abs(vSol3-vsol)); 


%% Fourth plot
sLa4=sLa;
sL4=[sLa4; sLa4;sLa4];

vIterations4=zeros(3,maxIt); 

vIterations4(:,1)=sqrt(-sLa)*vS+0.1;
err4=zeros(maxIt,1);
dist4=zeros(maxIt,1); 

for it=2:maxIt
    
    
    fv=-conj(sL./vIterations4(:,it-1))-(vIterations4(:,it-1)./abs(vIterations4(:,it-1))).*iL;
    err4(it-1)= max(abs(fv-(Y+diag(yL))*vIterations4(:,it-1)-Y_NS*vS)); 
    dist4(it-1)= max(abs(vIterations4(:,it-1)-vsol)); 
    str=[num2str(err4(it-1)), '\n']; 
    fprintf(str);
    vIterations4(:,it)=  (Y+diag(yL))\ (fv-Y_NS*vS);
    
    
end
vSol4=vIterations4(:,end); 
fv=-conj(sL./vSol4)-(vSol4./abs(vSol4)).*iL;
err4(end)=max(abs(fv-(Y+diag(yL))*vSol4-Y_NS*vS)); 
dist4(end)=max(abs(vSol4-vsol)); 



%% Plots

x0=2;
y0=2;
width=7;
height=5;
twoNodeFigure=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(twoNodeFigure, 'Name', 'twoNodeFigure');
hold on;


h1= plot(0:maxIt-1,dist1(1:maxIt) , 'b-o','lineWidth',2);
hold on
 h2=plot(0:maxIt-1,dist2(1:maxIt),'r--s','lineWidth',2);
 hold on
 h3= plot(0:maxIt-1,dist3(1:maxIt) , 'g-^','lineWidth',2);
hold on
 h4=plot(0:maxIt-1,dist4(1:maxIt),'m--v','lineWidth',2);

 


currentAxes=get(twoNodeFigure,'CurrentAxes');
set(0,'defaulttextinterpreter','latex')
set(currentAxes,'XTick',0:2:maxIt-1);
set(currentAxes,'XtickLabels',0:2:maxIt-1);
set(currentAxes,'YTick',[floor(min(min([dist1; dist2;dist3;dist4]))):0.2:ceil(max(max([dist1;dist2;dist3;dist4])))]);
YTickLabelSet=floor(min(min([dist1; dist2;dist3;dist4]))):0.2:ceil(max(max([dist1;dist2;dist3;dist4])));
% set(currentAxes,'YTickLabel',[]);
xlim([0 maxIt-1]);
 ylim([floor(min([dist1; dist2;dist3;dist4])) ceil(max([dist1;dist2;dist3;dist4]))+0.1]);
% HorizontalOffset = 0.05;
ax=axis;
% yTicks=get(currentAxes,'YTick');
% for i = 1:length(YTickLabelSet)
% %Create text box and set appropriate properties
%      text(ax(1) - HorizontalOffset,yTicks(i),['$\mathbf{10^{' num2str( YTickLabelSet(i)) '}}$'],...
%          'HorizontalAlignment','Right','interpreter', 'latex','fontSize',14,'fontName','Times New Roman');   
% end
set(currentAxes,'fontSize',14); 
grid on; 
set(currentAxes, 'box','on'); 
xlabel('Iteration $t$','FontName','Times New Roman'); 
set(currentAxes,'FontName','Times New Roman');

ylabel('$\| \mathbf{v}[t]\|_{\infty}$'); 
yLabel=get(currentAxes,'yLabel');
set(yLabel,'Position',get(yLabel,'Position')-[0 0 0]);
legendTEXT=legend([h1, h2, h3, h4], '$\mathbf{v}[0]=\mathbf{v}_{\mathrm{s}}$',...
    '$\mathbf{v}[0]=2\mathbf{v}^{\mathrm{sol}}$','$\mathbf{v}[0]=0.5\mathbf{v}^{\mathrm{sol}}$', '$\mathbf{v}[0]=\mathbf{v}^{\mathrm{sol}}+0.1 \mathbf{v}_{\mathrm{S}}$');
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