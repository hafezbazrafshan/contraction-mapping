clear all;
cd('Results'); 
zbusResults=load('IEEE37ZBusResults'); 
sweepResults=load('IEEE37SWeepResults');
cd('..'); 
allNodesActualLabelsWithRegs=zbusResults.allNodesActualLabelsWithRegs;
N=zbusResults.N;

x0=1;
y0=1;
width=8;
height=5;
figure1=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(figure1, 'Name', 'Voltages');
phase_names = ['a' 'b' 'c'];

for phase=1:3
		
    subplot(3,1,phase)
    plot(1:length(allNodesActualLabelsWithRegs), zbusResults.resultsVmag(:,phase), 'bo',1:length(allNodesActualLabelsWithRegs), sweepResults.resultsVmag(:,phase), 'r+','markerSize',12);
    xlim([0 N+2]);
    ylim([0.9 1.2]);
    grid on;
			set(gca,'XTick', [5:5:length(allNodesActualLabelsWithRegs)-5, length(allNodesActualLabelsWithRegs)-1],'YTick', [0.95:0.05:1.05] );
    set(gca,'XTickLabel', [allNodesActualLabelsWithRegs(5:5:end-5) ;allNodesActualLabelsWithRegs(end-1)]);
    set(gca,'XMinorTick','on')
   legendTEXT=legend('FB-Sweep', 'Z-BUS ');
    set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','horizontal'); 
set(legend,'location','NorthEast');
set(gca,'box','on');
    set(gca,'fontSize',14); 
set(0,'defaulttextinterpreter','latex')
    ylabel(sprintf('Phase %c ',phase_names(phase)), 'FontWeight','bold');
    yLabel=get(gca,'ylabel');
    set(yLabel,'Position',get(yLabel,'Position')-[0 0.05 0]);

    
    if phase==3
        xlabel('Nodes');
    end
end


if exist('Figures')~=7
    mkdir Figures;
end
cd('Figures'); 
print -dpdf IEEE37magnitudes.pdf
print -depsc2 IEEE37magnitudes
cd('..');

x0=1;
y0=1;
width=8;
height=5;
figure2=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(figure2, 'Name', 'Phases');
phase_names = ['a' 'b' 'c'];

for phase=1:3
		
    subplot(3,1,phase)
    plot(1:length(allNodesActualLabelsWithRegs), zbusResults.resultsVPhase(:,phase), 'bo', 1:length(allNodesActualLabelsWithRegs), sweepResults.resultsVPhase(:,phase), 'r+','markerSize',12);
    xlim([0 N+2])
    if phase==1
    ylim([-10 10]);
    elseif phase==2
    ylim([-130 -110]); 
    else
    ylim([110 130]);
    end
    grid on;
		set(gca,'XTick', [5:5:length(allNodesActualLabelsWithRegs)-5, length(allNodesActualLabelsWithRegs)-1] );
    set(gca,'XTickLabel', [allNodesActualLabelsWithRegs(5:5:end-5) ;allNodesActualLabelsWithRegs(end-1)]);
    set(gca,'XMinorTick','on')
    legendTEXT=legend('FB-Sweep', 'Z-BUS ');
    set(legendTEXT,'interpreter','Latex'); 
set(legendTEXT,'fontSize',14); 
set(legendTEXT,'fontWeight','Bold');
set(legend,'orientation','horizontal'); 
set(legend,'location','NorthEast');
set(gca,'box','on');
set(gca,'fontSize',14); 
set(0,'defaulttextinterpreter','latex')

    ylabel(sprintf('Phase %c ',phase_names(phase)), 'FontWeight','bold');

    if phase==3
        xlabel('Nodes');
    end
end

cd('Figures'); 
print -dpdf IEEE37phases.pdf
print -depsc2 IEEE37phases
cd('..');