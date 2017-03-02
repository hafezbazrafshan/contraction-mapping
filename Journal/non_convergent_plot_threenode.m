
vS=[1;exp(-j*2*pi/3);exp(j*2*pi/3)];

vS=[1;exp(-j*2*pi/3);exp(j*2*pi/3)];

sL1a=0.7+1.5i;
sL1b=0.8+1.5i;
sL1c=0.8+2.5i;
sL1=[sL1a;sL1b;sL1c];

sL2a=0.6+2.5i;
sL2b=0.6+0.5i;
sL2c=0.3+0.5i;
sL2=[sL2a;sL2b;sL2c];

sL=[sL1;sL2];

y1S=0.077-5.33i;
y12=0.056-8.66i;



Y1S=[y1S, 0.01-0.09i, 0.02-0.08i;
       0.01-0.09i, 0.087-8i, 0.03-0.07i;
       0.02-0.08i, 0.03-0.07i, 0.07-1.5i];
   
Y12=[y12, 0 0.02-0.07i;
       0, 0.02-4.8i, 0.03-0.05i;
       0.02-0.07i, 0.03-0.05i, 0.03-3.8i];      
   
Y=[Y1S+Y12 -Y12; -Y12 Y12]; 
Y_NS=[-Y1S; zeros(3,3)]; 




maxIt=21;


Z=inv(Y); 
w=-Z*Y_NS*vS;

theta=[1;0.5;0.3;0.2;0.12;0.11];

CPQ=max( sum( abs(Z*diag(sL)*diag(1./w)),2)); 
K=1./min(abs(w));

C2PQ=max(sum( abs( Z*diag(sL)*diag(1./w)*diag(1./w)),2)); 

% x=fsolve(@(v)nonlinearPQ(v, sL, Y, Y_NS, vS ),w);

%% Plot1
vIterations1=zeros(6,maxIt); 
vIterations1(:,1)=w;
err1=zeros(maxIt,1);

sLPlot1=theta(1)*sL;
for it=2:maxIt
    
    
    fv=-conj(sLPlot1./vIterations1(:,it-1));
    err1(it-1)= max(abs(fv-Y*vIterations1(:,it-1)-Y_NS*vS)); 
    str=[num2str(err1(it-1)), '\n']; 
    fprintf(str);
    vIterations1(:,it)=  (Y)\ (fv-Y_NS*vS);
    
    
end
vSol1=vIterations1(:,end); 
fv=-conj(sLPlot1./vSol1);
err1(end)=max(abs(fv-Y*vSol1-Y_NS*vS)); 


%% Plot2
vIterations2=zeros(6,maxIt); 
vIterations2(:,1)=w;
err2=zeros(maxIt,1);

sLPlot2=theta(2)*sL;
for it=2:maxIt
    
    
    fv=-conj(sLPlot2./vIterations2(:,it-1));
    err2(it-1)= max(abs(fv-Y*vIterations2(:,it-1)-Y_NS*vS)); 
    str=[num2str(err2(it-1)), '\n']; 
    fprintf(str);
    vIterations2(:,it)=  (Y)\ (fv-Y_NS*vS);
    
    
end
vSol2=vIterations2(:,end); 
fv=-conj(sLPlot2./vSol2);
err2(end)=max(abs(fv-Y*vSol2-Y_NS*vS)); 



%% Plot3
vIterations3=zeros(6,maxIt); 
vIterations3(:,1)=w;
err3=zeros(maxIt,1);

sLPlot3=theta(3)*sL;
for it=2:maxIt
    
    
    fv=-conj(sLPlot3./vIterations3(:,it-1));
    err3(it-1)= max(abs(fv-Y*vIterations3(:,it-1)-Y_NS*vS)); 
    str=[num2str(err3(it-1)), '\n']; 
    fprintf(str);
    vIterations3(:,it)=  (Y)\ (fv-Y_NS*vS);
    
    
end
vSol3=vIterations3(:,end); 
fv=-conj(sLPlot3./vSol3);
err3(end)=max(abs(fv-Y*vSol3-Y_NS*vS)); 


%% Plot4
vIterations4=zeros(6,maxIt); 
vIterations4(:,1)=w;
err4=zeros(maxIt,1);

sLPlot4=theta(4)*sL;
for it=2:maxIt
    
    
    fv=-conj(sLPlot4./vIterations4(:,it-1));
    err4(it-1)= max(abs(fv-Y*vIterations4(:,it-1)-Y_NS*vS)); 
    str=[num2str(err4(it-1)), '\n']; 
    fprintf(str);
    vIterations4(:,it)=  (Y)\ (fv-Y_NS*vS);
    
    
end
vSol4=vIterations4(:,end); 
fv=-conj(sLPlot4./vSol4);
err4(end)=max(abs(fv-Y*vSol4-Y_NS*vS)); 


%% Plot5
vIterations5=zeros(6,maxIt); 
vIterations5(:,1)=w;
err5=zeros(maxIt,1);

sLPlot5=theta(5)*sL;
for it=2:maxIt
    
    
    fv=-conj(sLPlot5./vIterations5(:,it-1));
    err5(it-1)= max(abs(fv-Y*vIterations5(:,it-1)-Y_NS*vS)); 
    str=[num2str(err5(it-1)), '\n']; 
    fprintf(str);
    vIterations5(:,it)=  (Y)\ (fv-Y_NS*vS);
    
    
end
vSol5=vIterations5(:,end); 
fv=-conj(sLPlot5./vSol5);
err5(end)=max(abs(fv-Y*vSol5-Y_NS*vS));


%% Plot 6
vIterations6=zeros(6,maxIt); 
vIterations6(:,1)=w;
err6=zeros(maxIt,1);

sLPlot6=theta(6)*sL;
for it=2:maxIt
    
    
    fv=-conj(sLPlot6./vIterations6(:,it-1));
    err6(it-1)= max(abs(fv-Y*vIterations6(:,it-1)-Y_NS*vS)); 
    str=[num2str(err6(it-1)), '\n']; 
    fprintf(str);
    vIterations6(:,it)=  (Y)\ (fv-Y_NS*vS);
    
    
end
vSol6=vIterations6(:,end); 
fv=-conj(sLPlot6./vSol6);
err6(end)=max(abs(fv-Y*vSol6-Y_NS*vS));


%% PLots

x0=2;
y0=2;
width=7;
height=5;
threeNodeFigure=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(threeNodeFigure, 'Name', 'threeNodeFigure');
hold on;


h1= plot(0:maxIt-1,log10(err1(1:maxIt)) , 'b-o','lineWidth',2);
hold on
 h2=plot(0:maxIt-1,log10(err2(1:maxIt)),'r--s','lineWidth',2);
 hold on;
 h3= plot(0:maxIt-1,log10(err3(1:maxIt)) , 'g-^','lineWidth',2);
 hold on;
 h4=plot(0:maxIt-1,log10(err4(1:maxIt)),'m--v','lineWidth',2);
 hold on;
 h5= plot(0:maxIt-1,log10(err5(1:maxIt)) , 'k-*','lineWidth',2);
 hold on; 
  h6= plot(0:maxIt-1,log10(err6(1:maxIt)) , 'c--x','lineWidth',2);

hold on

 


currentAxes=get(threeNodeFigure,'CurrentAxes');
set(0,'defaulttextinterpreter','latex')
set(currentAxes,'XTick',0:2:maxIt-1);
set(currentAxes,'XtickLabels',0:2:maxIt-1);
set(currentAxes,'YTick',[floor(min(min(log10([err1; err2;err3;err4;err5;err6])))):1:ceil(max(max(log10([err1;err2;err3;err4;err5;err6]))))]);
YTickLabelSet=floor(min(min(log10([err1; err2;err3;err4;err5;err6])))):1:ceil(max(max(log10([err1;err2;err3;err4;err5;err6]))));
set(currentAxes,'YTickLabel',[]);
xlim([0 maxIt-1]);
 ylim([floor(min(log10([err1; err2;err3;err4;err5;err6])))-1 ceil(max(log10([err1;err2;err3;err4;err5;err6])))+1]);
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
legendTEXT=legend([h1, h2, h3,h4,h5,h6], '$\theta=1$', '$\theta=0.5$', '$\theta=0.3$', '$\theta=0.2$', '$\theta=0.12$','$\theta=0.11$');
set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontname','Times New Roman');
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','Vertical'); 
set(legend,'location','SouthWest');
set(currentAxes,'box','on');
% 
cd('Figures'); 
print -dpdf threeNodeFigure.pdf
print -depsc2 threeNodeFigure

cd('..'); 