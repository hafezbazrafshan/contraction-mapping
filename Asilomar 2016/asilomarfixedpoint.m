x0=2;
y0=2;
width=7;
height=5;
selfmappingFigure=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(selfmappingFigure, 'Name', 'Fixed-point');
hold on;


h1= plot(0:maxIt-1,max(abs(inv(lambdaMat)*(vIterations1(:,1:maxIt) - repmat(vNew1,1,maxIt)))) , 'b-o','lineWidth',2);
hold on
 h2=plot(0:maxIt-1,max(abs(inv(lambdaMat)*(vIterations2(:,1:maxIt) - repmat(vNew2,1,maxIt)))),'r--s','lineWidth',2);
 hold on
 h3=plot(0:maxIt-1, max(abs(inv(lambdaMat)*(vIterations3(:,1:maxIt)-repmat(vNew3,1,maxIt)))), 'g-^','lineWidth',2); 
 hold on
 h4=plot(0:maxIt-1, max(abs(inv(lambdaMat)*(vIterations4(:,1:maxIt)-repmat(vNew4,1,maxIt)))), 'm-v','lineWidth',2); 
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

ylabel('$\|  \mathbf{v}[t] - \mathbf{v}^{\mathrm{fp}} \|_{\infty}$'); 
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
print -dpdf IEEE123fixedpoint.pdf
print -depsc2 IEEE123fixedpoint
cd('..'); 
